package com.bitsoft.cms


class MlsJob {

    def sessionRequired = false

    static long interval = 6000

    static triggers = {
        cron name: 'mlsJobTrigger', cronExpression: '0/10 * * * * ?' // Runs every 10 seconds
    }


    def execute() {
        try {
            Date trigDate = new Date(((long) (new Date().gmt().time / interval)) * interval)
            String trigTime = trigDate.format("HH-mm")
            String trigMinute = trigDate.format("mm")
            String trigDateTime = trigDate.format("yyyy-MM-dd-HH-mm")

            println("trigTime: $trigTime")
            println("trigMinute: $trigMinute")
            println("trigDateTime: $trigDateTime")
        } catch (Exception e) {
            log.error("Job execution failed: ", e)
        }
    }

}
