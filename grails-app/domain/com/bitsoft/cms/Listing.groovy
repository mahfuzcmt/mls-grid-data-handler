package com.bitsoft.cms

class Listing {

    String listingKey
    String streetAddress
    String streetNumber
    String streetDirPrefix
    String streetName
    String streetSuffix
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
    Integer associationFee
    Integer daysOnMarket
    Integer daysOnMarketCumulative
    Integer nstSqFtTotal // NST_SqFtTotal mapped here

    String url

    Double latitude
    Double longitude
    Double listPrice
    Double lotSizeArea

    Date listDate
    Date originalEntryTimestamp
    Date inputDate
    Date created
    Date updated
    Date listingContractDate

    Integer sqFtFinishedBuilding
    Integer buildingAreaTotal

    Boolean parkingGarage

    Collection<ListingMedia> media

    static hasMany = [media: ListingMedia]

    static constraints = {
        listingKey nullable: false
        media nullable: true
        streetAddress nullable: true
        streetNumber nullable: true
        streetDirPrefix nullable: true
        streetName nullable: true
        streetSuffix nullable: true
        unitNumber nullable: true
        postalCity nullable: true
        stateOrProvince nullable: true
        postalCode nullable: true
        publicRemarks nullable: true
        listOfficeName nullable: true
        bedroomsTotal nullable: true
        bathroomsTotal nullable: true
        sqFtTotal nullable: true
        nstSqFtTotal nullable: true // Constraint for NST_SqFtTotal
        garageSpaces nullable: true
        waterfrontFeet nullable: true
        associationFee nullable: true
        daysOnMarket nullable: true
        daysOnMarketCumulative nullable: true
        url nullable: true
        latitude nullable: true
        longitude nullable: true
        listPrice nullable: true
        lotSizeArea nullable: true
        listDate nullable: true
        originalEntryTimestamp nullable: true
        inputDate nullable: true
        listingContractDate nullable: true
        sqFtFinishedBuilding nullable: true
        buildingAreaTotal nullable: true
        parkingGarage nullable: true
    }

    static mapping = {
        media type: 'text'
        publicRemarks type: 'text'
    }

    def beforeInsert (){
        this.created = new Date()
    }

    def beforeUpdate(){
        this.updated = new Date()
    }
}
