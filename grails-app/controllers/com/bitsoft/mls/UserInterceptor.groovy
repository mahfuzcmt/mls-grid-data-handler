package com.bitsoft.mls


class UserInterceptor {

    AuthenticationService authenticationService

    boolean before() {
        if (authenticationService.isAdministratorUser()){
            return true
        }
        flash.message = AppUtil.infoMessage("You are not Authorized for this Action.", false)
        redirect(uri: request.getHeader('referer'))
        return false
    }
}
