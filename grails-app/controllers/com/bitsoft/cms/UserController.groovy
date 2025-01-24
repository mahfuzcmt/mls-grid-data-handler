package com.bitsoft.cms

import grails.converters.JSON

class UserController {

    UserService userService

    def index() {
        def response = userService.list(params)
        session.activeTab = "Users"
        [memberList: response.list, total:response.count]
    }

    def details(Integer id) {
        User response = userService.getById(id)
        session.activeTab = "Profile"
        if (!response){
            redirect(controller: "user", action: "index")
        }else{
            [user: response]
        }
    }

    def create() {
        [user: flash.redirectParams]
    }

    def save() {
        def response = userService.save(params)
        if (!response.isSuccess) {
            flash.redirectParams = response.model
            flash.message = AppUtil.infoMessage(g.message(code: "unable.to.save"), false)
            redirect(controller: "user", action: "create")
        }else{
            flash.message = AppUtil.infoMessage(g.message(code: "saved"))
            redirect(controller: "user", action: "index")
        }
    }

    def updatePassword() {
        def response = userService.getById(params.id)
        if (!response){
            flash.message = AppUtil.infoMessage(g.message(code: "invalid.entity"), false)
            redirect(controller: "user", action: "index")
        }

        else{
             response = userService.updatePassword(response, params)
            if (!response.isSuccess){
                flash.redirectParams = response.model
                flash.message = AppUtil.infoMessage(g.message(code: "unable.to.update"), false)
                redirect(controller: "user", action: "edit")
            }else{
                flash.message = AppUtil.infoMessage(g.message(code: "updated"))
                redirect(controller: "user", action: "index")
            }
        }
    }

    def edit(Integer id) {
        if (flash.redirectParams) {
            [user: flash.redirectParams]
        } else {
            def response = userService.getById(id)
            if (!response) {
                flash.message = AppUtil.infoMessage(g.message(code: "invalid.entity"), false)
                redirect(controller: "user", action: "index")
            } else {
                [user: response]
            }
        }
    }

    def update() {
        User user = userService.getById(params.id)
        if (!user){
            flash.message = AppUtil.infoMessage(g.message(code: "invalid.entity"), false)
            redirect(controller: "user", action: "index")
        }else{
            def response = userService.update(user, params)
            if (!response.isSuccess){
                flash.redirectParams = response.model
                flash.message = AppUtil.infoMessage(g.message(code: "unable.to.update"), false)
                redirect(controller: "user", action: "edit")
            }else{
                flash.message = AppUtil.infoMessage(g.message(code: "updated"))
                redirect(controller: "user", action: "index")
            }
        }
    }

    def delete(Integer id) {
        def response = userService.getById(id)
        if (!response){
            flash.message = AppUtil.infoMessage(g.message(code: "invalid.entity"), false)
            redirect(controller: "user", action: "index")
        }else{
            response = userService.delete(response)
            if (!response){
                flash.message = AppUtil.infoMessage(g.message(code: "unable.to.delete"), false)
            }else{
                flash.message = AppUtil.infoMessage(g.message(code: "deleted"))
            }
            redirect(controller: "user", action: "index")
        }
    }

    def userPermissions(){
        def permissions = userService.userPermissions(params)
        User user = userService.getById(params.userId)
        String userName = user.firstName + " " +user.lastName
        [permissions: permissions, userId: params.userId, userName: userName]
    }

    def userAccess(){
        def permissions = userService.userPermissions(params)
        [permissions: permissions, userId: params.userId]
    }

    def saveUserPermission(){
        def result = userService.saveUserPermission(params)
        render([success: result.isSuccess, message: "User Permission Updated"] as JSON)
    }


}
