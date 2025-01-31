package com.bitsoft.mls

class Config {

    Long id

    Long lastTimeStamp
    Integer skip = 0

    String url
    String apiKey

    Boolean isCorn = true

    Date lastImport
    Date created
    Date updated

    static belongsTo = []

    static constraints = {
        url nullable: true
        skip nullable: true
        isCorn nullable: true
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
