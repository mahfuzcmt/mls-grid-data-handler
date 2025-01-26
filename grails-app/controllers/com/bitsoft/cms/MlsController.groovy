package com.bitsoft.cms

import grails.converters.JSON
import grails.gorm.PagedResultList

class MlsController {

    MlsService mlsService

    def list() {
        // Retrieve pagination parameters
        int max = params.int('max') ?: 10 // Default to 20 items per page
        int offset = params.int('offset') ?: 0 // Default to starting at the beginning

        // Retrieve sorting parameters
        String sort = params.sort
        String order = params.order

        // Retrieve filtering parameters
        Double latitudeGte = params.double('Latitude_gte')
        Double latitudeLte = params.double('Latitude_lte')
        Double longitudeGte = params.double('Longitude_gte')
        Double longitudeLte = params.double('Longitude_lte')

        // Apply criteria query
        PagedResultList listings = Listing.createCriteria().list(max: max, offset: offset) {
            // Apply latitude range filter
            if (latitudeGte != null) {
                ge('latitude', latitudeGte)
            }
            if (latitudeLte != null) {
                le('latitude', latitudeLte)
            }

            // Apply longitude range filter
            if (longitudeGte != null) {
                ge('longitude', longitudeGte)
            }
            if (longitudeLte != null) {
                le('longitude', longitudeLte)
            }

            // Apply sorting
            /*if (sort && order) {
                order(sort, order)
            } else {
                order("id", "desc")
            }*/
        }

        // Total count of listings after applying filters
        def total = listings.totalCount

        // Construct response
        def response = [
                total   : total,
                max     : max,
                offset  : offset,
                listings: listings.collect {
                    [
                            listingKey    : it.listingKey,
                            media         : it.media,
                            streetAddress : it.streetAddress,
                            unitNumber    : it.unitNumber,
                            postalCity    : it.postalCity,
                            stateOrProvince: it.stateOrProvince,
                            postalCode    : it.postalCode,
                            listPrice     : it.listPrice,
                            bedroomsTotal : it.bedroomsTotal,
                            bathroomsTotal: it.bathroomsTotal,
                            publicRemarks : it.publicRemarks,
                            latitude      : it.latitude,
                            longitude     : it.longitude,
                            url           : it.url
                    ]
                }
        ]

        // Render response as JSON
        render response as JSON
    }


    def details(Integer id) {
        User response = userService.getById(id)
        session.activeTab = "Profile"
        if (!response){
            redirect(controller: "user", action: "index")
        }else{
            [user: response]
        }
    }

    def create() {
        [user: mlsService.fetchMLSData(null)]
    }



}
