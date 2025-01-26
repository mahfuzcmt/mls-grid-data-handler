package com.bitsoft.cms

class MlsJob {

    MlsService mlsService

    static triggers = {
        cron name: 'mlsFetchTrigger', cronExpression: '0 0 0/1 * * ?' // Every hour
    }

    def execute() {
        mlsService.fetchMLSData(null)
    }
}
