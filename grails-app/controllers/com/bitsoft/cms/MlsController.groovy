package com.bitsoft.cms

import grails.converters.JSON

class MlsController {

    MlsService mlsService

    def index() {
        [data: Listing.list(), total:Listing.count()]
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
        [user: mlsService.fetchMLSData()]
    }



}
