package com.bitsoft.cms

class SettingsController {

    UserService userService

    def index() {
        def response = userService.list(params)
        session.activeTab = "settings"
        [settings: [text: "Settings"]]
    }

}
