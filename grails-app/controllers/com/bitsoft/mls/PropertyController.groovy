package com.bitsoft.mls

import grails.converters.JSON
import grails.gorm.PagedResultList

class PropertyController {

    MlsService mlsService

    def list() {
        try {
            int max = params.int('max') ?: 20
            int offset = params.int('offset') ?: 0

            String direction = params.order ?: "desc"
            String orderedBy = params.sort ?: "id"

            Double latitudeGte = params.double('Latitude_gte')
            Double latitudeLte = params.double('Latitude_lte')
            Double longitudeGte = params.double('Longitude_gte')
            Double longitudeLte = params.double('Longitude_lte')

            println("params : ${params}")

            PagedResultList listings = Listing.createCriteria().list(max: max, offset: offset) {
                if (params.searchText) {
                    def searchText = "%${params.searchText.trim()}%"
                    or {
                        ilike("streetAddress", searchText)
                        ilike("streetNumber", searchText)
                        ilike("streetDirPrefix", searchText)
                        ilike("streetSuffix", searchText)
                        ilike("postalCity", searchText)
                        ilike("postalCode", searchText)
                        ilike("streetName", searchText)
                        ilike("stateOrProvince", searchText)
                    }
                }

                if(params.city) {
                    ilike("postalCity", "%${params.city.trim()}%")
                }
                if (latitudeGte != null) {
                    ge('latitude', latitudeGte)
                }
                if (latitudeLte != null) {
                    le('latitude', latitudeLte)
                }

                if (longitudeGte != null) {
                    ge('longitude', longitudeGte)
                }
                if (longitudeLte != null) {
                    le('longitude', longitudeLte)
                }
                order(orderedBy, direction)
            }

            String requestURL = request.requestURL.toString()
            String baseURL = requestURL.replaceAll("(https?://[^/]+).*", "\$1")

            def response = [
                    total   : listings.totalCount,
                    max     : max,
                    offset  : offset,
                    listings: listings.collect { Listing listing ->
                        [
                                id               : listing.id,
                                listingKey       : listing.listingKey,
                                media            : listing.media ? listing.media.collect { [fullUrl: baseURL + "/" + it.mediaURL, url: it.mediaURL, alt: it.longDescription] } : [],
                                streetAddress    : listing.streetAddress,
                                unitNumber       : listing.unitNumber,
                                postalCity       : listing.postalCity,
                                stateOrProvince  : listing.stateOrProvince,
                                postalCode       : listing.postalCode,
                                listPrice        : listing.listPrice,
                                bedroomsTotal    : listing.bedroomsTotal,
                                bathroomsTotal   : listing.bathroomsTotal,
                                publicRemarks    : listing.publicRemarks,
                                latitude         : listing.latitude,
                                longitude        : listing.longitude,
                                lotSizeArea      : listing.lotSizeArea,
                                nstSqFtTotal     : listing.nstSqFtTotal,
                                garageSpaces     : listing.garageSpaces,
                                nstWaterfrontFeet: listing.waterfrontFeet,
                                lotSizeUnits     : 'acres',
                                url              : listing.url
                        ]
                    }
            ]

            render response as JSON
        } catch (Exception e) {
            render([status: "error", message: "Failed to fetch listings", error: e.message] as JSON)
        }
    }

    def info() {
        try {
            Listing listing = Listing.get(params.id)
            if (!listing) {
                render([status: "error", message: "Listing not found"] as JSON)
                return
            }
            String requestURL = request.requestURL.toString()
            String baseURL = requestURL.replaceAll("(https?://[^/]+).*", "\$1")
            Map listingInfo = [
                    id               : listing.id,
                    listingKey       : listing.listingKey,
                    media            : listing.media ? listing.media.collect { [fullUrl: baseURL + "/" + it.mediaURL, url: it.mediaURL, alt: it.longDescription] } : [],
                    streetAddress    : listing.streetAddress,
                    unitNumber       : listing.unitNumber,
                    postalCity       : listing.postalCity,
                    stateOrProvince  : listing.stateOrProvince,
                    postalCode       : listing.postalCode,
                    listPrice        : listing.listPrice,
                    bedroomsTotal    : listing.bedroomsTotal,
                    bathroomsTotal   : listing.bathroomsTotal,
                    publicRemarks    : listing.publicRemarks,
                    latitude         : listing.latitude,
                    longitude        : listing.longitude,
                    lotSizeArea      : listing.lotSizeArea,
                    nstSqFtTotal     : listing.nstSqFtTotal,
                    garageSpaces     : listing.garageSpaces,
                    nstWaterfrontFeet: listing.waterfrontFeet,
                    lotSizeUnits     : 'acres',
                    url              : listing.url
            ]

            render([status: "success", listing: listingInfo] as JSON)
        } catch (Exception e) {
            render([status: "error", message: "Failed to fetch listing", error: e.message] as JSON)
        }
    }

    def count() {
        render([status: "success", total: Listing.count()] as JSON)
    }

    def create() {
        try {
            def createdListing = mlsService.fetchMLSData(null) // Adjust as needed for actual implementation
            render([status: "success", listing: createdListing] as JSON)
        } catch (Exception e) {
            render([status: "error", message: "Failed to create listing", error: e.message] as JSON)
        }
    }

    def delete() {
        try {
            Long id = params.long('id')
            if (!id) {
                render([status: "error", message: "Listing ID is required"] as JSON)
                return
            }

            Listing listing = Listing.get(id)
            if (!listing) {
                render([status: "error", message: "Listing not found"] as JSON)
                return
            }

            listing.delete(flush: true)
            render([status: "success", message: "Listing deleted successfully"] as JSON)
        } catch (Exception e) {
            render([status: "error", message: "Failed to delete listing", error: e.message] as JSON)
        }
    }
}
