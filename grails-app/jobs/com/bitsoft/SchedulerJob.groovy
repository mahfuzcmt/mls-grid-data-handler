package com.bitsoft

import com.bitsoft.mls.Config
import com.bitsoft.mls.Listing
import com.bitsoft.mls.MlsService

class SchedulerJob {
    def sessionRequired = false
    MlsService mlsService

    static long interval = 1000 * 60 * 15

    static triggers = {
        simple startDelay: 2000 * 10, repeatInterval: interval
    }

    def execute() {
        Config config = Config.last()
        if (!config) {
            println("********** Corn Config is not available **********")
            return
        }
        if (config && !config.isCorn) {
            println("********** Corn is Offed **********")
            return
        }
        if (config && config.isRunning) {
            println("********** Corn is Running **********")
            return
        }
        println("**********Faced Started @ ${new Date()}**********")
        mlsService.fetchMLSData(null)
        println("**********Faced Completed @ ${new Date()}**********")
        Listing lastListing = Listing.last() ?: null
        String lastImport = lastListing ? lastListing.modificationTimestamp : ""
        println("lastImport: ${lastImport}")
        if(lastImport){
            config.lastImport = lastImport
        }
        config.isRunning = false
        config.updated = new Date()
        config.merge()
        if(!config.errors){
            println("errors: ${config.errors}")
        }
    }
}