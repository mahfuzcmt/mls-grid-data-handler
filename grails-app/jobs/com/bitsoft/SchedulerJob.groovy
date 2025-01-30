package com.bitsoft

import com.bitsoft.mls.Config
import com.bitsoft.mls.MlsService

class SchedulerJob {
    def sessionRequired = false
    MlsService mlsService

    static long interval = 1000 * 60 * 15

    static triggers = {
        simple startDelay: 2000 * 10, repeatInterval: interval
    }

    def execute() {
        if (Config.last().isCorn) {
            println("**********Faced Started @ ${new Date()}**********")
            mlsService.fetchMLSData(null)
            println("**********Faced Completed @ ${new Date()}**********")
        } else {
            println("**********isCorn off **********")
        }
    }
}