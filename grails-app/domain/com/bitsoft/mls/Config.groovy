package com.bitsoft.mls

class Config {

    Long id

    Integer skip = 0

    String url
    String apiKey
    String lastImport

    Boolean isCorn = true
    Boolean isRunning = false

    Date created
    Date updated

    static belongsTo = []

    static constraints = {
        url nullable: true
        skip nullable: true
        isCorn nullable: true
        apiKey nullable: true
        lastImport nullable: true
        isRunning nullable: true
    }

    def beforeInsert (){
        this.created = new Date()
    }


    def beforeUpdate(){
        this.updated = new Date()
    }

    static mapping = {
        version(false)
    }

}
