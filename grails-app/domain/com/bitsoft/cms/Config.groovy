package com.bitsoft.cms

class Config {

    Long id

    Long lastTimeStamp

    Date lastImport
    Date created
    Date updated

    static belongsTo = []

    static constraints = {
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
