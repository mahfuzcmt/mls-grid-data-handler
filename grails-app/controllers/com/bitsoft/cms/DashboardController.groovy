package com.bitsoft.cms

class DashboardController {

    def index() {
        def response = []
        session.activeTab = "DASHBOARD"

        [totalOrg: 2658, totalCases: 52365, thisMonthHearing: 105, totalCircle: 105]
    }
}
