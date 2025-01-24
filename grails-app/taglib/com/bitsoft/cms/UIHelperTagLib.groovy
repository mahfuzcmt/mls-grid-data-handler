package com.bitsoft.cms

import grails.converters.JSON

import java.time.LocalDate
import java.time.LocalTime
import java.time.format.DateTimeFormatter

class UIHelperTagLib {

    static namespace = "UIHelper"

    AuthenticationService authenticationService

    UserService userService

    def renderErrorMessage = { attrs, body ->
        def model = attrs.model
        String fieldName = attrs.fieldName
        String errorMessage = attrs.errorMessage? g.message(code: attrs.errorMessage): g.message(code: "invalid.input")
        if (model && model.errors && model.errors.getFieldError(fieldName)){
            out << "<small class='form-text text-danger''><strong>${errorMessage}</strong></small>"
        }
    }

    def memberName = { attrs, body ->
        out << authenticationService.getUserName()
    }

    def userType = { attrs, body ->
        out << authenticationService.getUserType()
    }

    def userDetails = { attrs, body ->
        out << "/user/details?id=${authenticationService.getUser().id}"
    }

    def userId = { attrs, body ->
        out << "${authenticationService.getUser().id}"
    }


    def activeUsersListUI = { attrs, body ->
        def memberList = userService.list(params)
        memberList.list.each {user ->

            out << "<li id=\"active-user-li\">\n" +
                    "                    <a href=\"javascript:void(0);\">\n" +
                    "                        <div class=\"active-chat-user-image-container\">\n" +
                    "                            <img src=\"/assets/man-icon-person-logo-png-clipart.png\" class=\"active-chat-user-image\">\n" +
                    "                            <span class=\"icon-online\"></span>\n" +
                    "                        </div>\n" +
                    "                        <div class=\"menu-info\">\n" +
                    "                            <h4 class=\"control-sidebar-subheading\">\n" +
                    "${user.firstName} ${user.lastName}" +
                    "                            </h4>\n" +
                    "                            <p>\n" +
                    "                                ${user.mobile}" +
                    "                            </p>\n" +
                    "                        </div>\n" +
                    "                    </a>\n" +
                    "                </li>"

        }

    }

    def memberActionMenu = { attrs, body ->
        out << '<li class="nav-item dropdown show">'
        out << g.link(class:"nav-link dropdown-toggle", "data-toggle":"dropdown"){authenticationService.getUserName()}
        out << '<div class="dropdown-menu">'
        out << g.link(controller: "user", action: "details", id:"${authenticationService.getUser().id}", class: "dropdown-item"){g.message(code:"Profile")}
        out << g.link(controller: "user", action: "index", class: "dropdown-item"){g.message(code:"User List")}
        out << g.link(controller: "authentication", action: "logout", class: "dropdown-item"){g.message(code:"logout")}
        out << "</div></li>"
    }


    def systemServicesActionMenu = { attrs, body ->
        out << '<li class="nav-item dropdown show">'
        out << g.link(class:"nav-link dropdown-toggle", "data-toggle":"dropdown"){"SYSTEM SERVICE"}
        out << '<div class="dropdown-menu">'
        out << g.link(controller: "counter", action: "index", class: "dropdown-item"){g.message(code:"Counter")}
        out << g.link(controller: "authentication", action: "logout", class: "dropdown-item"){g.message(code:"Counter Man")}
        out << g.link(controller: "route", action: "index", class: "dropdown-item"){g.message(code:"Fares")}
        out << g.link(controller: "authentication", action: "logout", class: "dropdown-item"){g.message(code:"Driver")}
        out << g.link(controller: "authentication", action: "logout", class: "dropdown-item"){g.message(code:"Supervisor")}
        out << g.link(controller: "authentication", action: "logout", class: "dropdown-item"){g.message(code:"Trip")}
        out << "</div></li>"
    }


    def leftNavigation = { attrs, body ->
        List navigations = [
                [controller: "dashboard", action: "index", name: "dashboard"],
                [controller: "coachGroup", action: "index", name: "coach.group"],
                [controller: "coach", action: "index", name: "coach"],
        ]

        if(authenticationService.isAdministratorUser()){
            navigations.add([controller: "user", action: "index", name: "user"])
        }

        navigations.each { menu ->
            out << '<li class="list-group-item">'
            out << g.link(controller: menu.controller, action: menu.action) { g.message(code: menu.name, args: ['']) }
            out << '</li>'
        }
    }

    def seatPlan = { attrs, body ->
        String name = attrs.name ?: "seatPlan"
        String value = attrs.value ?: ""
        def select = [:]
        select["45AC"] = "45 Seat AC"
        select["51AC"] = "51 Seat AC"
        out << g.select(from: select, name: name, optionKey: "key", optionValue: "value", value: value, class:"form-control")
    }

    def status = { attrs, body ->
        String name = attrs.name ?: "status"
        String value = attrs.value ?: ""
        Map select = [:]
        if (attrs.select) {
            select = attrs.select
        } else {
            select.ACTIVE = "Active"
            select.INACTIVE = "Inactive"
        }
        out << g.select(from: select, name: name, optionKey: "key", optionValue: "value", value: value, class: "form-control ${attrs.clazz}")
    }

    def gender = { attrs, body ->
        String name = attrs.name ?: "sex"
        String value = attrs.value ?: ""
        String id = attrs.id ?: "customer-gender"
        def select = [:]
        select.male = "Male"
        select.female = "Female"
        out << g.select(from: select, name: name, optionKey: "key", optionValue: "value", value: value, class:"form-control", id: id)
    }


    def stoppage = { attrs, body ->
        String name = attrs.name ?: "fromStoppage"
        String value = attrs.value ?: ""
        def select = [:]
        select.dhaka = "Dhaka"
        select.kamalapur = "Kamalapur"
        select.tikatuli = "Tikatuli"
        select.kachpur = "Kachpur"
        select.hajiganj = "Hajiganj"
        out << g.select(from: select, name: name, optionKey: "key", optionValue: "value", value: value, class:"form-control")
    }

    def seatClass = { attrs, body ->
        String name = attrs.name ?: "seatClass"
        String value = attrs.value ?: ""
        def select = [:]
        select.ac = "AC"
        select.nonac = "Non AC"
        out << g.select(from: select, name: name, optionKey: "key", optionValue: "value", value: value, class:"form-control")
    }

    def parseTimeInFormat = { attrs, body ->
        String time = attrs.time ?: ""
        if(time){
            out << LocalTime.parse(time, DateTimeFormatter.ofPattern("HH:mm")).format("hh:mm a")
        }
    }

    def parseDateInFormat = { attrs, body ->
        String date = attrs.date ?: ""
        if(date){
            out << LocalDate.parse(date.split(" ")[0], DateTimeFormatter.ofPattern("yyyy-MM-dd")).toString()
        }
    }

    def getUserPermissionStatus = { attrs, body ->
        def permissionKey = attrs?.permissionKey ?: ""
        Long userId = attrs?.userId?.toLong() ?: ""
        def permissionValue = false
        if(permissionKey){
            UserPermission userPermission = UserPermission.findByPermissionKeyAndUserId(permissionKey, userId)
            if(userPermission){
                permissionValue = userPermission.permissionValue
                out << permissionValue.toString()
            }
        }
    }


    def appBaseURL = { attrs, body ->
        out << AppUtil.baseURL();
    }

    def domainSelect = { attrs, body ->
        Class domain = attrs.domain;
        if (!domain) {
            return
        }
        def multiple = attrs["multiple"]
        String key = attrs["key"] ?: "id"
        String text = attrs["text"] ?: "name"
        Map prependMap = attrs['prepend'] ?: null
        Map appendMap = attrs['append'] ?: null
        Map customAttrs = attrs['custom-attrs'] ?: null
        def value = attrs.value ?: ''
        def values = attrs.values ?: []
        if (value) {
            values.add(value)
        }

        Closure filter
        List sect = filter ? domain.createCriteria().list(filter) : domain.list()
        out << "<select ${multiple ? "multiple" : ""} class='${attrs["class"]}' ${attrs.name ? 'name="' + attrs.name + '"' : ''} ${attrs.id ? 'id="' + attrs.id + '"' : ''}"
        out << "${attrs.validation ? 'validation="' + attrs.validation + '"' : ''} ${attrs.disabled == 'true' ? 'disabled="true"' : ''}"
        out << " ${key != "id" ? 'select-key="' + key + '"' : ''} ${text != "name" ? 'select-text="' + text + '"' : ''} select-values='${values as JSON}'"
        if (customAttrs) {
            customAttrs.each {
                if (it.value) {
                    out << "${it.key}='${it.value}'"
                }
            }
        }
        out << ">"
        if (prependMap) {
            prependMap.each {
                out << "<option class='domain-prepend' value='${it.key}' ${it.key in values ? 'selected' : ''}>${it.value}</option>"
            }
        }

        def printChildren
        printChildren = { it ->
                def isMatched = multiple ? it[key] in values[0] : it[key] in values
                out << "<option value='${it[key]}' ${isMatched ? 'selected' : ''}>"
                out << it[text]
                out << "</option>"
        }

        sect.each {
            printChildren it
        }

        if (appendMap) {
            appendMap.each {
                out << "<option class='domain-append' value='${it.key}'>${it.value}</option>"
            }
        }
        out << "</select>"
    }


    def namedSelect = { attrs, body ->
        def keyMap = attrs.remove("key")
        List values = attrs.remove("values") ?: []
        if (attrs["value"]) {
            values.add(attrs.remove("value"))
        }
        Map prependMap = attrs['prepend'] ?: null
        Map appendMap = attrs['append'] ?: null
        Map customAttrs = attrs['custom-attrs'] ?: null
        String optionKey = attrs.optionKey ?: "key"
        String optionLabel = attrs.optionLabel ?: "label"
        out << "<select "
        attrs.each {
            if (it.key == "disabled" && it.value == "false") {
                return
            }
            out << "${it.key}=\"${it.value}\""
        }
        if (customAttrs) {
            customAttrs.each {
                if (it.value) {
                    out << "${it.key}='${it.value}'"
                }
            }
        }
        out << ">"
        if (prependMap) {
            prependMap.each {
                out << "<option value='${it.key}'>${g.message(code: it.value)}</option>"
            }
        }

        if (keyMap instanceof Map) {
            keyMap.each {
                out << "<option value='${it.key}' ${it.key in values ? "selected" : ""}>${g.message(code: it.value)}</option>"
            }
        } else if (keyMap instanceof List) {
            keyMap.each {
                if (it instanceof Map) {
                    out << "<option value='${it[optionKey]}' ${it[optionKey] in values ? "selected" : ""}>${g.message(code: it[optionLabel])}</option>"
                } else {
                    out << "<option value='${it}' ${it in values ? "selected" : ""}>${g.message(code: it)}</option>"
                }
            }
        }
        if (appendMap) {
            appendMap.each {
                out << "<option value='${it.key}'>${g.message(code: it.value)}</option>"
            }
        }
        out << "</select>"
    }


}
