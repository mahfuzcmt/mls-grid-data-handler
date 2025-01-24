package com.bitsoft.cms

import grails.gorm.transactions.Transactional
import groovy.json.JsonSlurper

@Transactional
class MlsService {

    String mlsGridAPIKey = "38e0a05020fd4fdf29430a851686d691dca9f957"
    String mlsGridAPIURL = "https://api.mlsgrid.com/v2/Property?\$filter=StandardStatus eq 'Active' or StandardStatus eq 'ComingSoon'"
    int fetchTop = 500
    List<String> validStatuses = ['Active', 'ComingSoon']
    List<String> validPropertyTypes = ['Commercial Sale', 'Farm', 'Land', 'Residential', 'ResidentialIncome']
    List<String> invalidListings = []


    void fetchMLSData(String url = mlsGridAPIURL, int retryCount = 0) {
        try {
            // Perform API request
            def response = new URL(url).openConnection()
            response.setRequestProperty("Authorization", "Bearer $mlsGridAPIKey")
            def responseText = response.inputStream.text
            def jsonResponse = new JsonSlurper().parseText(responseText)

            if (!jsonResponse?.value || !(jsonResponse.value instanceof List)) {
                throw new IllegalArgumentException("MLS Data is not in the expected format")
            }

            // Filter and process listings
            List<Map> listings = jsonResponse.value.findAll { listing ->
                validStatuses.contains(listing.StandardStatus) &&
                        validPropertyTypes.contains(listing.PropertyType) &&
                        listing.StateOrProvince == 'MN'
            }.collect { listing ->
                mapListing(listing)
            }

            processListings(listings)

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

    private void saveOrUpdateListing(Map listingData) {
        def existingListing = Listing.findByListingKey(listingData.ListingKey)
        if (existingListing) {
            existingListing.properties = listingData
            existingListing.save(flush: true, failOnError: true)
            log.info "Listing ${listingData.ListingKey} updated successfully"
        } else {
            new Listing(listingData).save(flush: true, failOnError: true)
            log.info "Listing ${listingData.ListingKey} created successfully"
        }
    }

    private void deleteInvalidListings(List<String> listingKeys) {
        Listing.where { listingKey in listingKeys }.deleteAll()
        log.info "Deleted invalid listings: ${listingKeys}"
    }

    private String generateURL(Map listing) {
        def today = new Date().format('yyyy-MM-dd')
        "${listing.StreetNumber}-${listing.StreetName}-${listing.StreetSuffix}-${listing.PostalCity}-${listing.StateOrProvince}-${listing.PostalCode}-${today}".replaceAll(' ', '-')
    }
}
