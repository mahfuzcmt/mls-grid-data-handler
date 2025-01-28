package com.bitsoft

import com.bitsoft.cms.MlsService

class SchedulerJob {
    def sessionRequired = false
    MlsService mlsService

    static long interval = 1000 * 60 * 5

    static triggers = {
        simple startDelay: 2000 * 10, repeatInterval: interval
    }

    def execute() {
        println("**********Faced Started @ ${new Date()}**********")
        mlsService.fetchMLSData(null)
        println("**********Faced Completed @ ${new Date()}**********")
    }
}