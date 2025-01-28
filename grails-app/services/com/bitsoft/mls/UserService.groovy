package com.bitsoft.mls

import grails.gorm.transactions.Transactional
import grails.web.servlet.mvc.GrailsParameterMap

@Transactional
class UserService {


    AuthenticationService authenticationService

    def save(GrailsParameterMap params) {
        User user = new User(params)
        def response = AppUtil.saveResponse(false, user)
        if (user.validate()) {
            user.save()
            if (!user.hasErrors()){
                response.isSuccess = true
            }
        }
        return response
    }

    def saveUserPermission(GrailsParameterMap params) {
        Long userId = params.userId.toLong()
        params.permission.each{
            UserPermission userPermission = UserPermission.findByPermissionKeyAndUserId(it.key, userId) ?:  new UserPermission()
            userPermission.permissionKey = it.key
            userPermission.permissionValue = it.value.toBoolean()
            userPermission.userId = userId
            userPermission.save()
        }
        return [isSuccess: true]
    }

    def userPermissions(GrailsParameterMap params) {
        return UserPermission.findAllByUserId(params.userId)
    }

    boolean userPermissionCheck(def permissionKey) {
        User user = authenticationService.getUser()
        if(user && user.userType == GlobalConfig.USER_TYPE.ADMINISTRATOR){
            return true
        }
        def userPermission = UserPermission.findByUserIdAndPermissionKey(user.id, permissionKey)
        return userPermission ? userPermission?.permissionValue : false
    }

    def update(User user, GrailsParameterMap params) {
        user.properties = params
        def response = AppUtil.saveResponse(false, user)
        if (user.validate()) {
            user.merge()
            if (!user.hasErrors()){
                response.isSuccess = true
            }
        }
        return response
    }


    def updatePassword(User user, GrailsParameterMap params) {
        user.properties = params
        def response = AppUtil.saveResponse(false, user)
        if (user.validate()) {
            user.save()
            if (!user.hasErrors()){
                response.isSuccess = true
            }
        }
        return response
    }


    User getById(Serializable id) {
        return User.get(id)
    }


    def list(GrailsParameterMap params) {
        params.max = params.max ?: GlobalConfig.itemsPerPage()
        List<User> memberList = User.createCriteria().list(params) {
            if (params?.colName && params?.colValue) {
                if(params.colName == "name"){
                    or {
                        like('firstName', "%" + params.colValue + "%")
                        like('lastName', "%" + params.colValue + "%")
                    }

                }else {
                    like(params.colName, "%" + params.colValue + "%")
                }

            }
            if (!params.sort) {
                order("id", "desc")
            }
        }
        return [list: memberList, count: memberList.totalCount]
    }

    def delete(User user) {
        try {
            user.delete()
        } catch (Exception e) {
            println(e.getMessage())
            return false
        }
        return true
    }
}
