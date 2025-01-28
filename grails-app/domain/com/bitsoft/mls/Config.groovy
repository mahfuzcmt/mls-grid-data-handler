package com.bitsoft.mls

class Config {

    Long id

    Long lastTimeStamp

    String url
    String apiKey

    Date lastImport
    Date created
    Date updated

    static belongsTo = []

    static constraints = {
        url nullable: true
        apiKey nullable: true
        lastTimeStamp nullable: true
    }

    def beforeInsert (){
        this.created = new Date()
        this.lastImport = new Date()
    }


    def beforeUpdate(){
        this.updated = new Date()
    }

    static mapping = {
        version(false)
    }

}
