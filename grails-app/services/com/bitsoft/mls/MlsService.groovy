package com.bitsoft.mls

import grails.gorm.transactions.Transactional
import grails.util.Environment
import groovy.json.JsonSlurper

import java.time.ZonedDateTime
import java.time.format.DateTimeFormatter


class MlsService {

    int FETCH_TOP = 100

    String mlsGridAPIURL = "https://api.mlsgrid.com/v2/Property?" +
            "%24filter=StandardStatus%20eq%20%27Active%27%20or%20StandardStatus%20eq%20%27ComingSoon%27%20and%20ModificationTimestamp%20gt%20%modificationTimestampFromDB%" +
            //"&%24top=${FETCH_TOP}&%24skip=%SKIP_VALUE%" +
            "&%24top=${FETCH_TOP}" +
            "&%24expand=Media"


    List<String> validStatuses = ['Active', 'ComingSoon']
    List<String> validPropertyTypes = ['Commercial Sale', 'Farm', 'Land', 'Residential', 'ResidentialIncome']
    List<String> invalidListings = []

    private String getURL() {
        Listing lastListing = Listing.last()
        String url
        if(lastListing && lastListing.modificationTimestamp){
            url = mlsGridAPIURL.replaceAll("%modificationTimestampFromDB%", lastListing.modificationTimestamp)
            return url
        }
        Config config = Config.last()
        if (config) {
            url = mlsGridAPIURL.replaceAll("%modificationTimestampFromDB%", config.lastImport)
          /*  if (config.skip) {
                url = url.replaceAll("%SKIP_VALUE%", "${config.skip}")
            } else {
                url = url.replaceAll("%SKIP_VALUE%", "0")
            }*/
        } else {
            url = "https://api.mlsgrid.com/v2/Property?" +
                    "%24filter=StandardStatus%20eq%20%27Active%27%20or%20StandardStatus%20eq%20%27ComingSoon%27%20" +
                    "&%24top=${FETCH_TOP}" +
                    "&%24expand=Media"
        }
        return url
    }

    private String getApiKey(){
        Config config = Config.last()
        if (config) {
            return config.getApiKey()
        } else {
            return "38e0a05020fd4fdf29430a851686d691dca9f957"
        }
    }

    void updateCornRunningStatus(Boolean status = false){
        Config config = Config.last()
        if(config){
            config.isRunning =  status
            config.save()
        }
    }

    @Transactional
    void updateConfigAfterCornRun(Config config){
        Listing lastListing = Listing.last() ?: null
        String lastImport = lastListing ? lastListing.modificationTimestamp : ""
        println("lastImport: ${lastImport}")
        if(lastImport){
            config.lastImport = lastImport
        }
        config.isRunning = false
        config.updated = new Date()
        config.merge()
        if(!config.errors){
            println("config Updated")
            return
        }
        println("errors: ${config.errors}")
    }

    void extractAndUpdateSkipValue(String url) {
        if (!url) {
            println "URL not found"
            return
        }
        try {
            def query = url.split("\\?")[1] // Get query part of URL
            def params = query.split("&") // Split parameters
            def skipParam = params.find { it.startsWith("%24skip=") } // Find $skip param
            if(!skipParam){
                skipParam = params.find { it.startsWith("\$skip=") }
            }
            if (skipParam) {
                Integer skip = URLDecoder.decode(skipParam.split("=")[1], "UTF-8").toInteger()
                updateSkipValue(skip)
            } else {
                println "Skip value not found in the URL"
            }
        } catch (Exception e) {
            println "Skip value is invalid. ${e.message}"
        }
    }

    void updateSkipValue(Integer skip) {
        Config config = Config.last()
        if (config && skip) {
            config.skip = skip
            config.save()
            println "Updated skip value to: ${skip}"
        } else {
            println "Failed to update skip value"
        }
    }

    void fetchMLSData(String url, int retryCount = 0) {
        try {
            updateCornRunningStatus(true)
            if(!url){
                url = getURL()
            }
            //extractAndUpdateSkipValue(url)
            println("url: ${url}")
            def connection = new URL(url).openConnection()
            connection.setRequestProperty("Authorization", "Bearer ${getApiKey()}")
            connection.setRequestProperty("Content-Type", "application/json")
            connection.setRequestProperty("Accept", "application/json")
            connection.setRequestProperty("Accept-Encoding", "gzip") // Add gzip compression

            connection.doOutput = false // Ensures this is a GET request

            // Get response
            def responseCode = connection.responseCode
            println "Response Code: $responseCode"

            if (responseCode != 200) {
                def errorMessage = connection.errorStream?.text ?: "No error message"
                println "Error Response: $errorMessage"
                throw new IllegalArgumentException("Unexpected response code: $responseCode")
            }

            // Read and decompress the response (if gzip is used)
            def inputStream = connection.inputStream
            if ("gzip".equalsIgnoreCase(connection.getContentEncoding())) {
                inputStream = new java.util.zip.GZIPInputStream(inputStream)
            }
            def responseText = inputStream.text
            def jsonResponse = new JsonSlurper().parseText(responseText)
            if (!jsonResponse?.value || !(jsonResponse.value instanceof List)) {
                throw new IllegalArgumentException("MLS Data is not in the expected format")
            }

            // Filter and process listings
            List<Map> listings = jsonResponse.value.findAll { listing ->
                validStatuses.contains(listing.StandardStatus) &&
                        validPropertyTypes.contains(listing.PropertyType) &&
                        listing.StateOrProvince == 'MN'
            }

            if(jsonResponse.value && listings && jsonResponse.value.size() != listings.size()){
                def toBeRemoved = jsonResponse.value - listings
                println "toBeRemoved: ${toBeRemoved.size()}"
                deleteInvalidListings(toBeRemoved.ListingId)
            }

            println("-------------To be Saved/Updated: ${listings.size()}-----------------------")
            processListings(listings)


            // Handle next link
            if (jsonResponse['@odata.nextLink']) {
                fetchMLSData(jsonResponse['@odata.nextLink'])
            } else {
                println "Data import completed successfully"
            }

        } catch (Exception e) {
            if (retryCount < 3) {
                int waitTime = (Math.pow(2, retryCount) * 1000).toInteger()
                log.warn "Error fetching data, retrying (attempt ${retryCount + 1}) in ${waitTime}ms... ${e.message}"
                sleep(waitTime)
                fetchMLSData(url, retryCount + 1)
            } else {
                println "Failed after 3 retries: ${e.message}"
                updateCornRunningStatus(false)
                throw e
            }
        }
    }

    private void processListings(List<Map> listings) {
        listings.each { listing ->
            try {
                // Save or update in the database
                saveOrUpdateListing(listing)
            } catch (Exception e) {
                println "Error processing listing ${listing.ListingKey}: ${e.message}"
            }
        }
    }

   List formatMediaData(List mediaList) {
        if (!mediaList || Environment.isDevelopmentMode()) {
            return []
        }
       String photoDir = "/opt/tomcat/webapps/images/"
       if (Environment.isDevelopmentMode()) {
           photoDir = "grails-app/assets/images/user-photos"
       }

        File directory = new File(photoDir)
        if (!directory.exists()) {
            directory.mkdirs()  // Ensure the directory exists
        }

        List parsedMediaList = []
        mediaList.each {
            Map mediaInfo = [:]
            mediaInfo.idx = it["Order"]
            mediaInfo.resourceRecordKey = it["ResourceRecordKey"]
            mediaInfo.mediaObjectID = it["MediaObjectID"]
            mediaInfo.longDescription = it["LongDescription"]
            mediaInfo.imageWidth = it["ImageWidth"]
            mediaInfo.imageHeight = it["ImageHeight"]
            mediaInfo.imageSizeDescriptio = it["ImageSizeDescriptio"]
            mediaInfo.originalUrl = it["MediaURL"]
            mediaInfo.mediaModificationTimestamp = it["MediaModificationTimestamp"]
            mediaInfo.mediaKey = it["MediaKey"]
            mediaInfo.created = new Date()
            mediaInfo.updated = new Date()

            // Download and save the image
            try {
                String mediaURL = it["MediaURL"]
                if (mediaURL) {
                    String fileName = mediaInfo.mediaKey ? "${mediaInfo.mediaKey}.jpg" : "default_${System.currentTimeMillis()}.jpg"
                    File imageFile = new File(directory, fileName)

                    // Download and save the image
                    imageFile.withOutputStream { outputStream ->
                        outputStream << new URL(mediaURL).openStream()
                    }

                    // Update the media URL to point to the local file
                    mediaInfo.mediaURL = "images/${fileName}"
                }
            } catch (Exception e) {
                println "Failed to download image for MediaObjectID: ${mediaInfo.mediaObjectID}. Error: ${e.message}"
                mediaInfo.mediaURL = null
            }

            parsedMediaList.add(mediaInfo)
        }

        return parsedMediaList
    }

    @Transactional
    private void saveOrUpdateListing(Map listingData) {
        // Map JSON keys to domain class properties
        def mappedData = [
                listingKey              : listingData.ListingKey,
                streetAddress           : "${listingData.StreetNumber} ${listingData.StreetDirPrefix ?: ''} ${listingData.StreetName} ${listingData.StreetSuffix ?: ''}".trim(),
                streetNumber            : listingData.StreetNumber,
                streetDirPrefix         : listingData.StreetDirPrefix ?: '',
                streetName              : listingData.StreetName,
                streetSuffix            : listingData.StreetSuffix ?: '',
                unitNumber              : listingData.UnitNumber ?: '',
                postalCity              : listingData.PostalCity,
                stateOrProvince         : listingData.StateOrProvince,
                postalCode              : listingData.PostalCode,
                publicRemarks           : listingData.PublicRemarks,
                listOfficeName          : listingData.ListOfficeName,
                bedroomsTotal           : listingData.BedroomsTotal as Integer,
                bathroomsTotal          : listingData.BathroomsTotalInteger as Integer,
                sqFtTotal               : listingData.SqFtTotal as Integer,
                nstSqFtTotal            : listingData.NST_SqFtTotal as Integer, // New field
                garageSpaces            : listingData.GarageSpaces as Integer,
                waterfrontFeet          : listingData.WaterfrontFeet as Integer,
                url                     : listingData.Url,
                latitude                : listingData.Latitude as Double,
                longitude               : listingData.Longitude as Double,
                listPrice               : listingData.ListPrice as Double,
                lotSizeArea             : listingData.LotSizeArea as Double,
                associationFee          : listingData.AssociationFee as Integer,
                daysOnMarket            : listingData.DaysOnMarket ?: 9999, // Default value if null
                daysOnMarketCumulative  : listingData.CumulativeDaysOnMarket ?: 9999, // Default value if null
                listDate                : listingData.ListDate,
                originalEntryTimestamp  : listingData.OriginalEntryTimestamp,
                modificationTimestamp   : listingData.ModificationTimestamp,
                inputDate               : listingData.NST_LastUpdateDate,
                listingContractDate     : listingData.ListingContractDate,
                sqFtFinishedBuilding    : listingData.SqFtFinishedBuilding as Integer,
                buildingAreaTotal       : listingData.BuildingAreaTotal as Integer,
                parkingGarage           : listingData.ParkingGarage as Boolean,
                media                   : formatMediaData(listingData.Media),
        ]


        // Check if a listing with the same key exists
        Listing existingListing = Listing.findByListingKey(listingData.ListingKey)
        if (existingListing) {
            existingListing.properties = mappedData
            existingListing.updated = new Date()
            if (existingListing.save()) {
                //TODO update images
                println "Listing ${listingData.ListingKey} updated successfully"
            } else {
                println "Failed to update listing ${listingData.ListingKey}: ${existingListing.errors.allErrors}"
            }
        } else {
            Listing newListing = new Listing(mappedData)
            newListing.created = new Date()
            newListing.updated = new Date()
            if (newListing.save()) {
                println "Listing ${listingData.ListingKey} created successfully"
            } else {
                println "Failed to create listing ${listingData.ListingKey}: ${newListing.errors.allErrors}"
            }
        }
    }

    @Transactional
    private void deleteInvalidListings(List<String> listingKeys) {
        try {
            List<Listing> listings = Listing.createCriteria().list(){
                inList("listingKey", listingKeys)
            }
            listings.each { Listing listing ->
                listing.media.each { media ->
                    if (media.mediaURL) {
                        try {
                            File mediaFile = new File(media.mediaURL)
                            if (mediaFile.exists()) {
                                mediaFile.delete()
                                println("Deleted media file: ${mediaFile.absolutePath}")
                            }
                        } catch (Exception e) {
                            println( "Failed to delete media file for Listing ${listing.listingKey}: ${e.message}")
                        }
                    }
                    media.delete()
                }
                listing.delete()
            }
            println "Deleted invalid listings: ${listingKeys}"
        } catch (Exception e) {
            println("Error deleting invalid listings: ${e.message}")
        }
    }

}
