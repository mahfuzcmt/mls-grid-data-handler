package com.bitsoft.cms

class User {

    Integer id
    String firstName
    String lastName

    String email
    String mobile
    String password
    String userType = "OPERATOR"
    String identityHash
    Long identityHashLastUpdate
    Boolean isActive = true

    String address

    static hasMany = []

    Date dateCreated
    Date lastUpdated

    static belongsTo = []

    static constraints = {
        email(email: true, nullable: false, unique: true, blank: false)
        mobile(nullable: false, unique: true, blank: false)
        password(blank: false)
        lastName(nullable: true)
        address(nullable: true)
        identityHash(nullable: true)
        identityHashLastUpdate(nullable: true)
    }

    def beforeInsert (){
        this.password = this.password
        this.dateCreated = new Date()
    }


    def beforeUpdate(){
        this.password = this.password
        this.lastUpdated = new Date()
    }

    static mapping = {
        version(false)
    }

}
