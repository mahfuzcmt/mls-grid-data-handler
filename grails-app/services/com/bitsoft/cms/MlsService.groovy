package com.bitsoft.cms

import grails.gorm.transactions.Transactional
import groovy.json.JsonSlurper


class MlsService {

    String mlsGridAPIKey = "38e0a05020fd4fdf29430a851686d691dca9f957"
    String mlsGridAPIURL = "https://api.mlsgrid.com/v2/Property?%24filter=StandardStatus%20eq%20%27Active%27%20or%20StandardStatus%20eq%20%27ComingSoon%27"
    int fetchTop = 5
    List<String> validStatuses = ['Active', 'ComingSoon']
    List<String> validPropertyTypes = ['Commercial Sale', 'Farm', 'Land', 'Residential', 'ResidentialIncome']
    List<String> invalidListings = []


    void fetchMLSData(String url = mlsGridAPIURL, int retryCount = 0) {
        try {
            // Open connection
            def connection = new URL(url).openConnection()
            connection.setRequestProperty("Authorization", "Bearer $mlsGridAPIKey")
            connection.setRequestProperty("Content-Type", "application/json")
            connection.setRequestProperty("Accept", "application/json")
            connection.setRequestProperty("Accept-Encoding", "gzip") // Add gzip compression

            connection.doOutput = false // Ensures this is a GET request

            println "Request URL: $url"
            println "Headers: Authorization: Bearer $mlsGridAPIKey"

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
                println "toBeRemoved: $toBeRemoved.ListingId"
                deleteInvalidListings(toBeRemoved.ListingId)
            }


            processListings(listings)
            Config config = Config.last() ?: new Config()
            config.lastTimeStamp = System.currentTimeMillis()
            config.save()

            // Handle next link
            if (jsonResponse['@odata.nextLink']) {
                fetchMLSData(jsonResponse['@odata.nextLink'])
            } else {
                log.info "Data import completed successfully"
                deleteInvalidListings(invalidListings)
            }

        } catch (Exception e) {
            if (retryCount < 3) {
                int waitTime = (Math.pow(2, retryCount) * 1000).toInteger()
                log.warn "Error fetching data, retrying (attempt ${retryCount + 1}) in ${waitTime}ms... ${e.message}"
                sleep(waitTime)
                fetchMLSData(url, retryCount + 1)
            } else {
                log.error "Failed after 3 retries: ${e.message}"
                throw e
            }
        }
    }

    private Map mapListing(def listing) {
        [
                ListingKey          : listing.ListingKey,
                Media               : listing.Media?.collect { it.MediaURL } ?: [],
                ListPrice           : listing.ListPrice,
                StreetAddress       : "${listing.StreetNumber} ${listing.StreetDirPrefix ?: ''} ${listing.StreetName} ${listing.StreetSuffix ?: ''}".trim(),
                UnitNumber          : listing.UnitNumber ?: '',
                PostalCity          : listing.PostalCity,
                StateOrProvince     : listing.StateOrProvince,
                PostalCode          : listing.PostalCode,
                BedroomsTotal       : listing.BedroomsTotal,
                BathroomsTotal      : listing.BathroomsTotalInteger,
                SqFtTotal           : listing.NST_SqFtTotal,
                LotSizeArea         : listing.LotSizeArea,
                GarageSpaces        : listing.GarageSpaces,
                WaterfrontFeet      : listing.NST_WaterfrontFeet,
                PublicRemarks       : listing.PublicRemarks,
                ListOfficeName      : listing.ListOfficeName,
                Latitude            : listing.Latitude,
                Longitude           : listing.Longitude,
                URL                 : generateURL(listing)
        ]
    }

    private void processListings(List<Map> listings) {
        listings.each { listing ->
            try {
                // Save or update in the database
                saveOrUpdateListing(listing)
            } catch (Exception e) {
                log.error "Error processing listing ${listing.ListingKey}: ${e.message}"
            }
        }
    }

    @Transactional
    private void saveOrUpdateListing(Map listingData) {
        // Map JSON keys to domain class properties
        def mappedData = [
                listingKey              : listingData.ListingKey,
                media                   : listingData.Media,
                streetAddress           : listingData.StreetAddress,
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
                inputDate               : listingData.NST_LastUpdateDate,
                listingContractDate     : listingData.ListingContractDate,
                sqFtFinishedBuilding    : listingData.SqFtFinishedBuilding as Integer,
                buildingAreaTotal       : listingData.BuildingAreaTotal as Integer,
                parkingGarage           : listingData.ParkingGarage as Boolean
        ]


        // Check if a listing with the same key exists
        def existingListing = Listing.findByListingKey(listingData.ListingKey)
        if (existingListing) {
            existingListing.properties = mappedData
            if (existingListing.save()) {
                log.info "Listing ${listingData.ListingKey} updated successfully"
            } else {
                log.error "Failed to update listing ${listingData.ListingKey}: ${existingListing.errors.allErrors}"
            }
        } else {
            def newListing = new Listing(mappedData)
            if (newListing.save()) {
                log.info "Listing ${listingData.ListingKey} created successfully"
            } else {
                log.error "Failed to create listing ${listingData.ListingKey}: ${newListing.errors.allErrors}"
            }
        }
    }

    @Transactional
    private void deleteInvalidListings(List<String> listingKeys) {
        try {
            Listing.where { listingKey in listingKeys }.deleteAll()
            log.info "Deleted invalid listings: ${listingKeys}"
        } catch (Exception e) {
            log.error("Deleted invalid listings: ${e.message}")
        }
    }

    private String generateURL(Map listing) {
        def today = new Date().format('yyyy-MM-dd')
        "${listing.StreetNumber}-${listing.StreetName}-${listing.StreetSuffix}-${listing.PostalCity}-${listing.StateOrProvince}-${listing.PostalCode}-${today}".replaceAll(' ', '-')
    }
}
