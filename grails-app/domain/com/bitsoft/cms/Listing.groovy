package com.bitsoft.cms

class Listing {

    String listingKey
    String media
    String streetAddress
    String unitNumber
    String postalCity
    String stateOrProvince
    String postalCode
    String publicRemarks
    String listOfficeName

    Integer bedroomsTotal
    Integer bathroomsTotal
    Integer sqFtTotal
    Integer garageSpaces
    Integer waterfrontFeet


    String url

    Double latitude
    Double longitude
    Double listPrice
    Double lotSizeArea

    static constraints = {
        media nullable: true
        unitNumber nullable: true
        garageSpaces nullable: true
        waterfrontFeet nullable: true
        publicRemarks nullable: true
        sqFtTotal nullable: true
        lotSizeArea nullable: true
    }

    static mapping = {
        media type: 'text'
    }
}
