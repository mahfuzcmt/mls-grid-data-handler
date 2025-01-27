package com.bitsoft.cms

import org.quartz.JobExecutionContext
import org.quartz.JobExecutionException

class MlsJob {

    static triggers = {
        simple name: 'mlsJobTrigger', startDelay: 1000, repeatInterval: 1000
        // Example cron trigger:
        // cron name: 'myCronTrigger', cronExpression: "0 0/5 * * * ?" // Every 5 minutes
    }

    def execute(JobExecutionContext context) throws JobExecutionException {
        try {
            println("Executing MlsJob at: ${new Date()}")
            // Your business logic here
        } catch (Exception e) {
            log.error("Job execution failed: ", e)
        }
    }
}
