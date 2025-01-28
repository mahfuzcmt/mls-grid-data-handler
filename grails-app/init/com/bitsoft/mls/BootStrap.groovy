package com.bitsoft.mls

import grails.core.DefaultGrailsApplication
import org.grails.datastore.mapping.model.PersistentEntity


class BootStrap {

    DefaultGrailsApplication grailsApplication
    def quartzScheduler

    def init = { servletContext ->

        Collection<PersistentEntity> entities = grailsApplication.mappingContext.persistentEntities
        quartzScheduler.start()
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
