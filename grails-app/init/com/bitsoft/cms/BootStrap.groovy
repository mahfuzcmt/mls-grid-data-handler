package com.bitsoft.cms

import grails.core.DefaultGrailsApplication
import grails.gorm.multitenancy.Tenants
import org.grails.datastore.mapping.model.PersistentEntity


class BootStrap {

    DefaultGrailsApplication grailsApplication

    def init = { servletContext ->

        Collection<PersistentEntity> entities = grailsApplication.mappingContext.persistentEntities

        initializeDomain(entities)

//        Tenants.eachTenant{ String tenant ->
//            initializeDomain(entities)
//        }
    }


    def initializeDomain(def entities){
        entities.each { entity ->
            try {
                Class domainClass = entity.javaClass
                domainClass.initialize()
            } catch (MissingMethodException e) {
            }
        }
    }


    def destroy = {

    }
}
