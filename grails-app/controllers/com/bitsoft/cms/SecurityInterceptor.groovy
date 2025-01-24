package com.bitsoft.cms


class SecurityInterceptor {

    AuthenticationService authenticationService

    SecurityInterceptor() {
        matchAll().excludes(controller: "authentication").excludes(controller: "website")
    }

    boolean before() {
        if (!authenticationService.isAuthenticated()) {
            redirect(controller: "authentication", action: "login")
            return false
        }
        return true
    }
}
