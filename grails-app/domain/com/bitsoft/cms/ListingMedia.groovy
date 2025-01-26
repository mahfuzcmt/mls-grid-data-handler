package com.bitsoft.cms

class ListingMedia {

    String resourceRecordKey
    String order
    String mediaObjectID
    String longDescription
    String imageWidth
    String imageHeight
    String imageSizeDescription
    String mediaURL
    String mediaModificationTimestamp
    String mediaKey

    Date created
    Date updated

    static constraints = {
        resourceRecordKey nullable: true, blank: false
        order nullable: true
        mediaObjectID nullable: true, blank: false
        longDescription nullable: true, maxSize: 5000
        imageWidth nullable: true
        imageHeight nullable: true
        imageSizeDescription nullable: true
        mediaURL nullable: false, blank: false, maxSize: 10000
        mediaModificationTimestamp nullable: false
        mediaKey nullable: true
    }

    static mapping = {
        mediaURL type: 'text'
        longDescription type: 'text'
    }

    def beforeInsert() {
        this.created = new Date()
    }

    def beforeUpdate() {
        this.updated = new Date()
    }
}
