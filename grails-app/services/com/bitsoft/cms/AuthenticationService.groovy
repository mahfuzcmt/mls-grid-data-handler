package com.bitsoft.cms

class AuthenticationService {

    private static final String AUTHORIZED = "AUTHORIZED"

    void setUserAuthorization(User user) {
        def authorization = [isLoggedIn: true, user: user]
        AppUtil.getAppSession()[AUTHORIZED] = authorization
    }

    boolean doLogin(String email, String password){
        User user = User.findByEmailAndPassword(email, password)
        if (user){
            setUserAuthorization(user)
            return true
        }
        return false
    }

    boolean isAuthenticated(){
        return true
        def authorization = AppUtil.getAppSession()[AUTHORIZED]
        if (authorization && authorization.isLoggedIn){
            return true
        }
        return false
    }


    User getUser(){
        def authorization = AppUtil.getAppSession()[AUTHORIZED]
        return authorization?.user
    }


    String getUserName(){
        User user = getUser()
        return "${user.firstName} ${user.lastName}"
    }

    String getUserType(){
        User user = getUser()
        return user.userType
    }

    boolean isAdministratorUser(){
        User user = getUser()
        if (user && user.userType == GlobalConfig.USER_TYPE.ADMINISTRATOR){
            return true
        }
        return false
    }

}
