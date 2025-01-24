/********************VARIABLE**************************/
var apiUrl = "http://localhost:52168";
var appUrl = "http://localhost:52168";
var staticUrl = "http://localhost:52168";
var offset = 220;
var duration = 500;
var monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sept", "Oct", "Nov", "Dec"];

var validImageExtensions = ["jpg", "jpeg", "bmp", "gif", "png"];

var units = ['', 'One ', 'Two ', 'Three ', 'Four ', 'Five ', 'Six ', 'Seven ', 'Eight ', 'Nine '];

var teens = ["Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen"];

var tens = ['', '', "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety"];

var scales = ["", "Thousand", "Lakh", "Million", "Crore", "Billion", "Trillion", "Quadrillion", "Quintillion", "Sextillion", "Septillion", "Octillion", "Nonillion"];

var stringConstructor = "azr".constructor;
var arrayConstructor = [].constructor;
var objectConstructor = ({}).constructor;


/*****************************INIT APP*****************************************************************/

$(function () {
    modalResize("my");
    modalResize("azr");
    MessageBox.init({
        "selector": "#side-alert"
    });
    ToastBox.init({
        "selector": "#toast-alert"
    });
    setInterval('updateClock()', 1000);
    getFixedFoltingButton();
    getRecordDisplay();

    $('.select2-select').select2({
        theme: "bootstrap",
        width: '100%'
    });

    $(".select2-select-tag").select2({
        theme: "bootstrap",
        multiple: true,
        tags: true,
        tokenSeparators: [',', ' '],
        width: '100%'
    });

    $('.dtp').datetimepicker({
        defaultDate: new Date().setHours(0, 0, 0, 0),
        format: 'MMM DD, YYYY'
    });

    $('.dtpEmpty').datetimepicker({
        format: 'MMM DD, YYYY'
    });

    $('.dtpMax').datetimepicker({
        defaultDate: new Date().setHours(0, 0, 0, 0),
        format: 'MMM DD, YYYY',
        maxDate: new Date().setHours(23, 59, 59, 999)
    });

    $('.dtpMin').datetimepicker({
        defaultDate: new Date().setHours(0, 0, 0, 0),
        format: 'MMM DD, YYYY',
        minDate: new Date().setHours(0, 0, 0, 0)
    });

    $('.dtpTime').datetimepicker({
        defaultDate: new Date(),
        format: 'LT'
    });

    dateRangeChanger({
        target: '.drpToday',
        start: moment().millisecond(0).second(0).minute(0).hour(0),//moment().subtract(29, 'days')
        end: moment(),
        format: 'MMM DD, YYYY'
    });
    dateRangeChangerNext({
        target: '.drpNext',
        start: moment().millisecond(0).second(0).minute(0).hour(0),//moment().subtract(29, 'days')
        end: moment(),
        format: 'MMM DD, YYYY'
    });
});


$(window).scroll(function () {
    if ($(this).scrollTop() > offset) {
        $('.crunchify-top').fadeIn(duration);
    } else {
        $('.crunchify-top').fadeOut(duration);
    }
});
$(document).on('click', '.crunchify-top', function (event) {
    event.preventDefault();
    $('html, body').animate({ scrollTop: 0 }, duration);
    return false;
});



/***************DATE & TIME***********************/
function changeDateRange(start, end) {
    $('.drp input[type="text"]').val(start.format("MMM DD, YYYY") + " - " + end.format("MMM DD, YYYY"));
}

function dateRangeChanger(options) {

    $(options.target).daterangepicker({
        startDate: options.start,
        endDate: options.end,
        //singleDatePicker: true,
        showDropdowns: true,
        minYear: 1971,
        //maxYear: parseInt(moment().format('YYYY')),
        //minDate: moment('2012-01-01'), maxDate: moment().endOf('year')
        ranges: {
            'Today': [moment(), moment()],
            'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
            'Last 7 Days': [moment().subtract(6, 'days'), moment()],
            'Last 30 Days': [moment().subtract(29, 'days'), moment()],
            'This Month': [moment().startOf('month'), moment().endOf('month')],
            'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')],
            //'Months': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')],
            'This Quarter': [moment().startOf('quarter'), moment().endOf('quarter')],
            'Last Quarter': [moment().subtract(1, 'quarter').startOf('quarter'), moment().subtract(1, 'quarter').endOf('quarter')],
            'This Year': [moment().startOf('year'), moment().subtract(1, 'month').endOf('month')],
            'Last Year': [moment().subtract(1, 'year').startOf('year'), moment().subtract(1, 'year').endOf('year')]
        }
    }, changeDateRange);

    changeDateRange(options.start, options.end);
}

function dateRangeChangerNext(options) {

    $(options.target).daterangepicker({
        startDate: options.start,
        endDate: options.end,
        //singleDatePicker: true,
        showDropdowns: true,
        minYear: 1971,
        //maxYear: parseInt(moment().format('YYYY')),
        //minDate: moment('2012-01-01'), maxDate: moment().endOf('year')
        ranges: {
            'Today': [moment(), moment()],
            'Tomorrow': [moment().add(1, 'days'), moment().add(1, 'days')],
            'Next 7 Days': [moment(), moment().add(6, 'days')],
            'Next 30 Days': [moment(), moment().add(29, 'days')],
            'This Month': [moment().startOf('month'), moment().endOf('month')],
            'Next Month': [moment().add(1, 'month').startOf('month'), moment().add(1, 'month').endOf('month')],
        }
    }, changeDateRange);

    changeDateRange(options.start, options.end);
}

/***************IMAGE & FILE***********************/

function getExtention(name) {
    var extension = name.substring(name.lastIndexOf('.') + 1).toLowerCase();
    return extension;
}
function validedImageExtention(name) {
    var extension = name.substring(name.lastIndexOf('.') + 1).toLowerCase();
    return $.inArray(extension, validImageExtensions) !== -1;
}
$(document).on('change', '.image-input input:file', function () {
    var prop = this.id.replace("File", "");
    previewImagePopover(prop + "Control");
    var img = $('<img/>', {
        id: 'dynamic',
        width: 250,
        height: 200
    });
    var file = this.files[0];
    var reader = new FileReader();
    reader.onload = function (e) {
        $(".image-input-title").text("Change");
        $("#" + prop + "Name").val(file.name);
        img.attr('src', e.target.result);
        $("#" + prop + "Control").attr("data-content", $(img)[0].outerHTML).popover("show");
    }
    reader.readAsDataURL(file);
});
function closePreviewImagePopover(control) {
    $(`#${control}`).popover('hide');
    $(`#${control}`).hover(
        function () {
            $(`#${control}`).popover('show');
        },
        function () {
            $(`#${control}`).popover('hide');
        }
    );
}
function previewImagePopover(control) {

    let closeBtn = $('<button/>', {
        type: "button",
        //text: 'x',
        html: '<i class="fa fa-times-circle"></i>',
        id: control + '-close-preview',
        style: 'font-size: initial;',
        onclick: 'closePreviewImagePopover("' + control + '")'
    });

    closeBtn.attr("class", "close pull-right");

    $(`#${control}`).popover({
        trigger: 'manual',
        html: true,
        title: "<strong>Preview</strong>" + $(closeBtn)[0].outerHTML,
        content: "There's no image",
        placement: 'auto'
    });
};
/*****************popover************************/
function closePopover(control) {
    $(`#${control}`).popover('hide');
    $(`#${control}`).hover(
        function () {
            $(`#${control}`).popover('show');
        },
        function () {
            $(`#${control}`).popover('hide');
        }
    );
}
function previewPopover(options) {
    if (!$(`#${options.control}`).data('popover')) {
        let closeBtn = $('<button/>',
            {
                type: "button",
                html: '<i class="fa fa-times-circle"></i>',
                id: options.control + '-close-popover',
                style: 'font-size: initial;',
                onclick: 'closePopover("' + options.control + '")'
            });

        closeBtn.attr("class", "close pull-right");

        $(`#${options.control}`).popover({
            trigger: options.trigger,
            html: true,
            title: `<strong>${options.header}</strong>` + $(closeBtn)[0].outerHTML,
            content: options.html,
            container: options.container,
            placement: options.placement
        }).triggerHandler(options.trigger);
    }
};

/*****************OOP************************/

var Spiner = (function () {
    "use strict";
    var opts = {
        lines: 13,
        length: 28,
        width: 14,
        radius: 42,
        scale: 1,
        corners: 1,
        color: '#000',
        opacity: 0.25,
        rotate: 0,
        direction: 1,
        speed: 1,
        trail: 60,
        fps: 20,
        zIndex: 2e9,
        className: 'spinner',
        top: '50%',
        left: '50%',
        shadow: false,
        hwaccel: false,
        position: 'absolute'
    };
    var result = {};
    var spin = new Spinner(opts);
    result.show = function () {
        $('#splash-page').show();
        $('#splash-page').after(spin.spin().el);
    }
    result.hide = function () {
        setTimeout(function () {
            spin.stop();
            $('#splash-page').hide();
        }, 10);
    }
    return result;
}());
var MessageBox = (function () {
    "use strict";
    var elem,
        hideHandler,
        that = {};

    that.init = function (options) {
        elem = $(options.selector);
    };
    that.show = function (text) {
        clearTimeout(hideHandler);
        elem.find("span").html(text);
        elem.delay(200).fadeIn().delay(1000).fadeOut();
    }
    return that;
}());
var ToastBox = (function () {
    "use strict";
    var elem,
        hideHandler,
        that = {};

    that.init = function (options) {
        elem = $(options.selector);
    };
    that.show = function (text) {
        clearTimeout(hideHandler);
        elem.find("p").html(text);
        elem.delay(200).fadeIn().delay(1000).fadeOut();
    }
    return that;
}());
var Timer = (function () {
    "use strict";
    var interval = null;
    var targetId;
    var redirectUrl;
    var redirectHandle = null;
    var timeInrerval = 1;
    var sessionTime = 0;
    var redirect = function () {
        sessionTime = (timeInrerval) * 1000;
        function resetRedirect() {
            if (redirectHandle) clearTimeout(redirectHandle);
            redirectHandle = setTimeout(function () {
                window.location.href = redirectUrl;
            }, sessionTime);
        }
        $.ajaxSetup({ complete: function () { resetRedirect(); } });
        resetRedirect();
    }
    var timer = function () {
        redirect();
        interval = setInterval(function () {
            var count = parseInt($(targetId).html());
            if (count !== 0) {
                $(targetId).html(count - 1);
            } else {
                clearInterval(interval);
            }
        }, 1000);

    };
    var refresh = function () {
        $(targetId).html("0");
        clearInterval(interval);
        clearTimeout(redirectHandle);
        $(targetId).html(timeInrerval);
        timer();
    }
    var result = {};
    result.init = function (url, targetTimer) {
        redirectUrl = url;
        targetId = "#" + targetTimer;
        timeInrerval = parseInt($(targetId).html());
        timer();
    }
    result.refresh = function (inrervalTime) {
        timeInrerval = parseInt(inrervalTime);
        refresh();
    }
    return result;
}());
function showMessage(msg) {
    //bootbox.alert({
    //    message: msg,
    //    callback: function () {
    //        MessageBox.show(msg);
    //    }
    //});
    MessageBox.show(msg);
    // ToastBox.show(msg);
}

/***************** Query String ******************************/

// query string: ?foo=lorem&bar=&baz
// var foo = getParameterByName('foo')
function getParameterByName(name, url) {
    if (!url) url = window.location.href;
    name = name.replace(/[\[\]]/g, '\\$&');
    var regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)'),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, ' '));
}
//params =json object
function makeUrl(params, baseUrl) {

    if (typeof (baseUrl) === 'undefined') {
        baseUrl = window.location.protocol + "//" + window.location.host + "/";
    }
    var queryStr = "";
    for (var key in params) {
        if (params.hasOwnProperty(key)) {
            if (queryStr !== "") {
                queryStr += "&";
            }
            queryStr += key + "=" + encodeURIComponent(params[key]);
        }
    }
    queryStr = queryStr.slice(0, -1);
    //var queryString = '?' + $.param(params);
    var url = baseUrl + "?" + queryStr;
    return url;
}
//var me = getUrlVars()["me"];
function getUrlVars() {
    let vars = {},
        hash;
    let hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
    for (let i = 0; i < hashes.length; i++) {
        hash = hashes[i].split('=');
        vars[hash[0]] = urldecode(hash[1]);//vars.push(hash[0]);
    }
    return vars;
}
function urldecode(str) {
    return decodeURIComponent((str + '').replace(/\+/g, '%20'));
}
/***************** LOCAL STORAGE ******************************/
function allStorageValue() {
    var values = [],
        keys = Object.keys(localStorage),
        i = keys.length;
    while (i--) {
        values.push(localStorage.getItem(keys[i]));
    }
    return values;
}
function allStorageObject() {
    var archive = {},
        keys = Object.keys(localStorage),
        i = keys.length;
    while (i--) {
        archive[keys[i]] = localStorage.getItem(keys[i]);
    }
    return archive;
}
function allStorageArray() {
    var archive = [],
        keys = Object.keys(localStorage),
        i = 0, key;
    for (; key = keys[i]; i++) {
        archive.push(key + '=' + localStorage.getItem(key));
    }
    return archive;
}
function clearAllStorage() {
    localStorage.clear();
}
function localStorageRemainSpace() {
    var limit = 1024 * 1024 * 5; // 5 MB
    var remSpace = limit - unescape(encodeURIComponent(JSON.stringify(localStorage))).length;
    return ((remSpace / 1024) / 1024);
}
function isStorageKeyExist(keyName) {
    return localStorage.getItem(keyName) !== null;
}
function saveStorage(keyName, model) {
    localStorage.setItem(keyName, JSON.stringify(model));
    return model;
}
function deleteStorage(keyName) {
    localStorage.removeItem(keyName);
}
function getStorage(keyName) {
    return JSON.parse(localStorage.getItem(keyName));
}


/*********************COOKIES*************************************/

function getCookie(name) {
    var value = "; " + document.cookie;
    var parts = value.split("; " + name + "=");
    if (parts.length == 2) return parts.pop().split(";").shift();
    return null;
}
function createCookie(name, value, days) {
    var expires = "";
    if (days) {
        var date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
        expires = "; expires=" + date.toUTCString();
    }
    document.cookie = name + "=" + value + expires + "; path=/";
}
function readCookie(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for (var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') c = c.substring(1, c.length);
        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length, c.length);
    }
    return null;
}
function readCookieToJson(name) {
    var value = readCookie(name);
    var obj = {};
    if (value != null) {
        var keyValues = value.split('&');
        keyValues.forEach(function (keyVlue) {
            var data = keyVlue.split('=');
            obj[data[0]] = data[1];
        });
        return obj;
    }
    return null;
}
function eraseCookie(name) {
    createCookie(name, "", -1);
}

function get_cookies_array() {

    var cookies = {};

    if (document.cookie && document.cookie != '') {
        var split = document.cookie.split(';');
        for (var i = 0; i < split.length; i++) {
            var name_value = split[i].split("=");
            name_value[0] = name_value[0].replace(/^ /, '');
            cookies[decodeURIComponent(name_value[0])] = decodeURIComponent(name_value[1]);
        }
    }

    return cookies;

}

function getAllCookieNames() {
    return Object.keys(get_cookies_array());
}
function getApiToken() {
    let apiKey = getAllCookieNames().find(s => s.includes("_API_"));
    return apiKey ? readCookie(apiKey): null;
}

/*********************MODAL*********************************/

function closeModal(modalPrefix) {
    var modalName = "myModal";
    if (typeof (modalPrefix) != 'undefined') {
        modalName = modalPrefix + 'Modal';
    }
    $('#' + modalName).modal('hide');
    $('body').removeClass('modal-open');
    $('.modal-backdrop').remove();
}
function createModalUsingHtml(html, page=1, modalPrefix="my") {
    var modalContent = 'myModalContent';
    var modalName = "myModal";
    if (typeof (modalPrefix) != 'undefined') {
        modalName = modalPrefix + 'Modal';
        modalContent = modalPrefix + 'ModalContent';
    }
    if (typeof (page) == 'undefined') {
        page = 1;
    }
    if ($('#' + modalName).hasClass('in')) {
        $('#' + modalName).modal('hide');
        $('body').removeClass('modal-open');
        $('.modal-backdrop').remove();
    }
    $('#' + modalContent).html(html);
    $('#' + modalName).modal('show');
    $('#page').val(page);
}
function createModal(url, page, modalPrefix) {
    var modalContent = 'myModalContent';
    var modalName = "myModal";
    if (typeof (modalPrefix) != 'undefined') {
        modalName = modalPrefix + 'Modal';
        modalContent = modalPrefix + 'ModalContent';
    }
    if (typeof (page) == 'undefined') {
        page = 1;
    }
    $.ajax({
        url: url,
        type: 'GET',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            $('#' + modalContent).html(data);
            $('#' + modalName).modal('show');
            $('#page').val(page);
        },
        error: function (data) {
            bootbox.alert('Error in creating records');
        }
    });
}
function deleteModal(url, redirectTo, msg, loadContainer = "mainContent") {
    if (typeof (msg) === 'undefined') {
        msg = "Do you want to De-Active this Record?";
    }
    bootbox.confirm({
        message: msg,
        buttons: {
            confirm: {
                label: 'Yes',
                className: 'btn-success'
            },
            cancel: {
                label: 'No',
                className: 'btn-danger'
            }
        },
        callback: function (result) {
            if (result) {
                $.ajax({
                    url: url,
                    type: 'POST',
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        showMessage("Record DeActivated successfully!!!");
                        let formType = $("#mainContent").attr("data-saveFormType");
                        if (formType==="Modal") {
                            $(`#${loadContainer}`).load(redirectTo);
                        } else {
                            window.location.href = redirectTo;

                        }
                    },
                    error: function (data) {
                        showMessage('Error in getting result');
                    }
                });
            }
        }
    });
}
function modalResize(modalPrefix) {
    var modalContent = 'myModalContent';
    var modalName = "myModal";
    if (typeof (modalPrefix) != 'undefined') {
        modalName = modalPrefix + 'Modal';
        modalContent = modalPrefix + 'ModalContent';
    }
    var modelId = `#${modalName}`;
    $(modelId).on('show.bs.modal', function () {
        var modalType = $($(this).find("[modal-type]")[0]).attr('modal-type');
        $(this).find('.modal-dialog').removeAttr("style");

        if (modalType === "auth") {
            $(modelId).css("margin-top", "100px");
        } else {
            $(modelId).css("margin-top", "");
        }
        if (modalType === "large") {
            $(this).find('.modal-dialog').css({
                width: '90%',
                height: 'auto',
                'overflow-y': 'auto',
                'max-height': '90%'
            });
        }
        if (modalType === "medium") {
            $(this).find('.modal-dialog').css({
                width: '70%',
                height: 'auto',
                'overflow-y': 'auto',
                'max-height': '70%'
            });
        }
        if ($(this).find('.select2-select').length > 0) {
            $('.select2-select').select2({
                theme: "bootstrap",
                width: '100%',
                dropdownParent: $(modelId)
            });
        }
        if ($(this).find('.dtp').length > 0) {
            $('.dtp').datetimepicker({
                defaultDate: new Date().setHours(0, 0, 0, 0),
                format: 'MMM DD, YYYY'
            });
        }
        if ($(this).find('.select2-select-tag').length > 0) {
            $(".select2-select-tag").select2({
                theme: "bootstrap",
                multiple: true,
                tags: true,
                tokenSeparators: [',', ' '],
                width: '100%'
            });
        }

        if ($(this).find('.dtpEmpty').length > 0) {
            $('.dtpEmpty').datetimepicker({
                format: 'MMM DD, YYYY'
            });
        }
        if ($(this).find('.dtpMax').length > 0) {
            $('.dtpMax').datetimepicker({
                defaultDate: new Date().setHours(0, 0, 0, 0),
                format: 'MMM DD, YYYY',
                maxDate: new Date().setHours(23, 59, 59, 999)
            });
        }
        if ($(this).find('.dtpMin').length > 0) {
            $('.dtpMin').datetimepicker({
                defaultDate: new Date().setHours(0, 0, 0, 0),
                format: 'MMM DD, YYYY',
                minDate: new Date().setHours(0, 0, 0, 0)
            });
        }
        if ($(this).find('.dtpTime').length > 0) {
            $('.dtpTime').datetimepicker({
                defaultDate: new Date(),
                format: 'LT'
            });
        }
        if ($(this).find('.drpToday').length > 0) {
            dateRangeChanger({
                target: '.drpToday',
                start: moment().millisecond(0).second(0).minute(0).hour(0),//moment().subtract(29, 'days')
                end: moment(),
                format: 'MMM DD, YYYY'
            });
        }

        //replaceThemeColor();
        //    $.validator.unobtrusive.parse("form");
    });
    $(modelId).on('hidden.bs.modal', function () {
        $(this).find('.modal-dialog').removeAttr("style");
        if ($(this).find('.select2-select').length > 0 && $(this).find('.select2-select').data('select2')) {
            $(this).find('.select2-select').select2('destroy');
        }
        if ($(this).find('.dtp').length > 0) {
            if ($('.dtp').data('DateTimePicker') !== undefined) {
                $('.dtp').data('DateTimePicker').destroy();
            }
        }
        $(`#${modalContent}`).html('');
    });
}

/*********************AJAX*************************************/

function loadLink(url, id) {
    if (typeof (id) === 'undefined') {
        $('#mainContent').load(url);
    } else {
        $('#' + id).load(url);
    }
}
function OnAjaxRequestSuccess(arg, header) {
    if (typeof (arg) !== 'undefined') {
        var urlArr = [];
        if (arg.pathname != undefined) {
            urlArr = arg.pathname.split('/');
            getRecordDisplay(arg.pathname);
        }
        if (arg.action != undefined) {
            urlArr = arg.action.split('/');
            getRecordDisplay(arg.action);
        }
        if (urlArr.length < 3) {
            $("#area-name").val("");
            $("#controller-name").val(urlArr[1]);
        } else {
            $("#area-name").val(urlArr[1]);
            $("#controller-name").val(urlArr[2]);
        }
        sortingTable("#dataTable", ".sortable");

    }
    if (typeof (header) !== 'undefined' & header !== 'nochange') {
        $('#PageHeader').html(header);
    } else if (header === 'nochange') {

    } else {
        if (typeof (arg) !== 'undefined') {
            var child = $(arg).children();
            if (child.length === 0) {
                $('#PageHeader').html($(arg).html());
            } else {
                $('#PageHeader').html($(child[1]).html());
            }
        }

    }
    getFixedFoltingButton();
    //replaceThemeColor();
}
function SubmitOnSuccess(result) {
    var prefix = $(this).attr('data-modalPrefix');
    var loadDiv = $(this).attr('data-load');
    var modalContent = 'myModalContent';
    var modalName = "myModal";
    if (typeof (prefix) != 'undefined') {
        modalName = prefix + 'Modal';
        modalContent = prefix + 'ModalContent';
    }
    if (result.treggerId) {
        if (typeof (prefix) != 'undefined') { closeModal(prefix); }
        showMessage(result.message);
        $("#" + result.treggerId).trigger(result.treggerEvent);
    } else if (result.loadUrl || result.openUrl || result.redirectUrl) {
        if (typeof (prefix) != 'undefined') { closeModal(prefix); }
        showMessage(result.message);
        if (result.loadUrl) { $('#' + result.position).load(result.loadUrl); }
        if (result.openUrl) { window.open(result.openUrl, '_blank').focus(); }
        if (result.redirectUrl) { window.location.href = result.redirectUrl; }
    } else {
        if (typeof (prefix) != 'undefined') {
            $('#' + modalContent).html(result);
            $('#' + modalName).modal('show');
        } else {
            if (typeof (loadDiv) != 'undefined') {
                $('#' + loadDiv).html(result);
            } else {
                $('#mainContent').html(result);
            }
        }

    }
}
function getRecordDisplay(url) {
    if (typeof (url) == 'undefined') {
        url = "#";
    }
    var create = $("#action-name");
    if (create) {
        var joiner = url.match(/&/) ? "&" : "?";

        $("#azr-search-form").attr('action', url);
        $("#show-active-only").attr('href', url);
        $("#show-all-records").attr('href', url + joiner + "showAll=True");
        $("#record-display").show();
    } else {
        $("#record-display").hide();
    }
}

/**************************UTILITY******************************************/
function numberFormat (number, decimals=0, decPoint='.', thousandsSep='') { // eslint-disable-line camelcase

    number = (number + '').replace(/[^0-9+\-Ee.]/g, '')
    var n = !isFinite(+number) ? 0 : +number
    var prec = !isFinite(+decimals) ? 0 : Math.abs(decimals)
    var sep = (typeof thousandsSep === 'undefined') ? ',' : thousandsSep
    var dec = (typeof decPoint === 'undefined') ? '.' : decPoint
    var s = ''
    var toFixedFix = function (n, prec) {
        var k = Math.pow(10, prec)
        return '' + (Math.round(n * k) / k)
            .toFixed(prec)
    }
    // @todo: for IE parseFloat(0.55).toFixed(0) = 0;
    s = (prec ? toFixedFix(n, prec) : '' + Math.round(n)).split('.')
    if (s[0].length > 3) {
        s[0] = s[0].replace(/\B(?=(?:\d{3})+(?!\d))/g, sep)
    }
    if ((s[1] || '').length < prec) {
        s[1] = s[1] || ''
        s[1] += new Array(prec - s[1].length + 1).join('0')
    }
    return s.join(dec)
}
function removeDuplicate(arr, prop) {
    var newArr = [];
    var lookup = {};

    var i, j;
    for (i in arr) {
        if (arr.hasOwnProperty(i)) {
            lookup[arr[i][prop]] = arr[i];
        }
    }

    for (j in lookup) {
        if (lookup.hasOwnProperty(j)) {
            newArr.push(lookup[j]);
        }
    }

    return newArr;
};
function priceValidation(e, mrpArg) {
    onlyNonNegativeNumeric(e);
    var mrpValue = $(mrpArg).val();
    if (mrpValue === '') {
        $(mrpArg).val('0.00');
    }
}
function quantityValidation(e, qyArg) {
    if ($(qyArg).val() === '') {
        $(qyArg).val('1');
    }
    onlyInteger(e);
    //totalCalculate('#' + $(qyArg)[0].id);
}
function onlyNumeric(evt) {
    var theEvent = evt || window.event;
    var key = theEvent.keyCode || theEvent.which;
    var exclusions = [8, 46];
    if (exclusions.indexOf(key) > -1) {
        return;
    }
    key = String.fromCharCode(key);
    var regex = /[0-9]|\./;
    if (!regex.test(key)) {
        theEvent.returnValue = false;
        if (theEvent.preventDefault) theEvent.preventDefault();
    }
}
function isInt(value) {
    var x;
    if (isNaN(value)) {
        return false;
    }
    x = parseFloat(value);
    return (x | 0) === x;
}
function onlyInteger(e) {

    if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
        e.returnValue = false;
        if (e.preventDefault) e.preventDefault();
    };
    return true;
}
function onlyNonNegativeNumeric(evt) {
    var theEvent = evt || window.event;
    var key = theEvent.keyCode || theEvent.which;
    var exclusions = [8, 46];
    if (exclusions.indexOf(key) > -1) {
        return;
    }
    if (key === 45 || key === 189) theEvent.preventDefault();
    key = String.fromCharCode(key);
    var regex = /[0-9]|\./;
    if (!regex.test(key)) {
        theEvent.returnValue = false;
        if (theEvent.preventDefault) theEvent.preventDefault();
    }

}
function onlyAlphaNumeric(evt) {
    var theEvent = evt || window.event;
    var key = theEvent.keyCode || theEvent.which;
    var exclusions = [8, 46];
    if (exclusions.indexOf(key) > -1) {
        return;
    }
    key = String.fromCharCode(key);
    var regex = /^[a-z0-9]+$/i;
    if (!regex.test(key)) {
        theEvent.returnValue = false;
        if (theEvent.preventDefault) theEvent.preventDefault();
    }
}
function specialCharacterAlphaNumeric(evt) {
    var theEvent = evt || window.event;
    var key = theEvent.keyCode || theEvent.which;
    var exclusions = [8, 46];
    if (exclusions.indexOf(key) > -1) {
        return;
    }
    key = String.fromCharCode(key);
    var regex = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{8,}$/;
    if (!regex.test(key)) {
        theEvent.returnValue = false;
        if (theEvent.preventDefault) theEvent.preventDefault();
    }
}
function capitalizeFirstLetter(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
}

function whatIsIt(object) {
    if (object === null) {
        return "null";
    }else if (object === undefined) {
        return "undefined";
    } else if (object.constructor === stringConstructor) {
        return "String";
    } else if (object.constructor === arrayConstructor) {
        return "Array";
    } else if (object.constructor === objectConstructor) {
        return "Object";
    } else {
        return "Unknow";
    }
}

function distinct(value, index, self) {
    return self.indexOf(value) === index;
}


/*********************DATE TIME*********************************/

function toFriendlyDateTime(dateTime) {
    var delta = Math.round((+new Date - new Date(dateTime)) / 1000);

    var minute = 60,
        hour = minute * 60,
        day = hour * 24,
        week = day * 7;

    var fuzzy;

    if (delta < 30) {
        fuzzy = 'just now.';
    } else if (delta < minute) {
        fuzzy = delta + ' seconds ago.';
    } else if (delta < 2 * minute) {
        fuzzy = 'a minute ago.';
    } else if (delta < hour) {
        fuzzy = Math.floor(delta / minute) + ' minutes ago.';
    } else if (Math.floor(delta / hour) == 1) {
        fuzzy = '1 hour ago.';
    } else if (delta < day) {
        fuzzy = Math.floor(delta / hour) + ' hours ago.';
    } else if (delta < day * 2) {
        fuzzy = 'yesterday';
    } else {
        fuzzy = dateTime;
    }
    return fuzzy;
}
function getJsonDateToActualDate(jsonDate, serparator) {
    if (typeof (serparator) === "undefined") {
        serparator = '/';
    }
    if (!jsonDate) {
        return ''
    };
    var date = new Date(parseInt(jsonDate.substr(6)));
    var month = date.getMonth() + 1;
    var day = date.getDate();
    var year = date.getFullYear();
    var finaldate = day + serparator + month + serparator + year;
    return finaldate;
}
function updateClock() {
    var currentTime = new Date();
    var currentHours = currentTime.getHours();
    var currentMinutes = currentTime.getMinutes();
    var currentSeconds = currentTime.getSeconds();

    // Pad the minutes and seconds with leading zeros, if required
    currentMinutes = (currentMinutes < 10 ? "0" : "") + currentMinutes;
    currentSeconds = (currentSeconds < 10 ? "0" : "") + currentSeconds;

    // Choose either "AM" or "PM" as appropriate
    var timeOfDay = (currentHours < 12) ? "AM" : "PM";

    // Convert the hours component to 12-hour format if needed
    currentHours = (currentHours > 12) ? currentHours - 12 : currentHours;

    // Convert an hours component of "0" to "12"
    currentHours = (currentHours == 0) ? 12 : currentHours;

    // Compose the string for display
    var currentTimeString = currentHours + ":" + currentMinutes + ":" + currentSeconds + " " + timeOfDay;
    $("#clock").html(currentTimeString);
}

/*********************NUMBER TO WORD*********************************/

function InWord(num) {
    if ((num = num.toString()).length > 9) return 'overflow';
    n = ('000000000' + num).substr(-9).match(/^(\d{2})(\d{2})(\d{2})(\d{1})(\d{2})$/);
    if (!n) return; var str = '';
    str += (n[1] != 0) ? (units[Number(n[1])] || tens[n[1][0]] + ' ' + units[n[1][1]]) + 'Crore ' : '';
    str += (n[2] != 0) ? (units[Number(n[2])] || tens[n[2][0]] + ' ' + units[n[2][1]]) + 'Lakh ' : '';
    str += (n[3] != 0) ? (units[Number(n[3])] || tens[n[3][0]] + ' ' + units[n[3][1]]) + 'Thousand ' : '';
    str += (n[4] != 0) ? (units[Number(n[4])] || tens[n[4][0]] + ' ' + units[n[4][1]]) + 'Hundred ' : '';
    str += (n[5] != 0) ? ((str != '') ? 'and ' : '') + (units[Number(n[5])] || tens[n[5][0]] + ' ' + units[n[5][1]]) + 'only ' : '';
    return str;
}
function numberToEnglish(n) {

    var string = n.toString(), start, end, chunks, chunksLen, chunk, ints, i, word, words, and = 'and';

    /* Is number zero? */
    if (parseInt(string) === 0) {
        return 'zero';
    }

    /* Split user arguemnt into 3 digit chunks from right to left */
    start = string.length;
    chunks = [];
    while (start > 0) {
        end = start;
        chunks.push(string.slice((start = Math.max(0, start - 3)), end));
    }

    /* Check if function has enough scale words to be able to stringify the user argument */
    chunksLen = chunks.length;
    if (chunksLen > scales.length) {
        return '';
    }

    /* Stringify each integer in each chunk */
    words = [];
    for (i = 0; i < chunksLen; i++) {

        chunk = parseInt(chunks[i]);

        if (chunk) {

            /* Split chunk into array of individual integers */
            ints = chunks[i].split('').reverse().map(parseFloat);

            /* If tens integer is 1, i.e. 10, then add 10 to units integer */
            if (ints[1] === 1) {
                ints[0] += 10;
            }

            /* Add scale word if chunk is not zero and array item exists */
            if ((word = scales[i])) {
                words.push(word);
            }

            /* Add unit word if array item exists */
            if ((word = units[ints[0]])) {
                words.push(word);
            }

            /* Add tens word if array item exists */
            if ((word = tens[ints[1]])) {
                words.push(word);
            }

            /* Add 'and' string after units or tens integer if: */
            if (ints[0] || ints[1]) {

                /* Chunk has a hundreds integer or chunk is the first of multiple chunks */
                if (ints[2] || !i && chunksLen) {
                    words.push(and);
                }

            }

            /* Add hundreds word if array item exists */
            if ((word = units[ints[2]])) {
                words.push(word + ' hundred');
            }

        }

    }
    return words.reverse().join(' ');

}
function convertMillion(num) {
    if (num >= 1000000) {
        return convertMillion(Math.floor(num / 1000000)) + " million " + convertThousand(num % 1000000);
    }
    else {
        return convertThousand(num);
    }
}
function convertThousand(num) {
    if (num >= 1000) {
        return convertHundred(Math.floor(num / 1000)) + " thousand " + convertHundred(num % 1000);
    }
    else {
        return convertHundred(num);
    }
}
function convertHundred(num) {
    if (num > 99) {
        return units[Math.floor(num / 100)] + " hundred " + convertTen(num % 100);
    }
    else {
        return convertTen(num);
    }
}
function convertTen(num) {
    if (num < 10) return units[num];
    else if (num >= 10 && num < 20) return teens[num - 10];
    else {
        return tens[Math.floor(num / 10)] + " " + units[num % 10];
    }
}
function convert(num) {
    if (num == 0) return "zero";
    else return convertMillion(num);
}

/*********************DIV******************************************/

function addRowInDiv(dynamicGroupId) {
    if (typeof (dynamicGroupId) === 'undefined') {
        dynamicGroupId = "#dynamicRowGroup";
    } else {
        dynamicGroupId = '#' + dynamicGroupId;
    }

    var $last = $(dynamicGroupId + ">div.dynamicRow:last");

    if ($last.length > 0) {
        if ($(dynamicGroupId).find('.select2-select').length > 0) {
            $('.select2-select').select2('destroy');
        }
        var name = $last.children().find('input,select')[0].name;
        var prePost = name.match(/([a-zA-Z]+?)(s\b|\b)/gi);
        var index = Number(name.replace(/[^0-9]/gi, '')) + 1;
        var prefix = prePost.length === 1 ? "" : prePost[0];

        var div = '<div class="row no-gap dynamicRow">' +
            ($last.html()
                .replace(/([A-Za-z])\w+[_]+[0-9]+/gi, prefix + '_' + index))
                .replace(/([A-Za-z])\w+\[[0-9]+\]/gi, prefix + '[' + index + ']') +
            '</div>';

        $last.after(div);
        if ($(dynamicGroupId).find('.select2-select').length > 0) {
            $('.select2-select').select2({
                theme: "bootstrap",
                width: '100%',
                dropdownParent: $("#myModal")
            });
        }
        $.each($(dynamicGroupId + ">div.dynamicRow:last").find('input,select'), function (i, item) {
            if (item.type === 'hidden' && item.id.match(/__Id$/)) {
                item.value = '0';
            }
            if (item.type === 'text') {
                item.value = '';
                item.defaultValue = '';
            }
            if (item.type === 'select') {
                $('#' + item.id + ' option').removeAttr('selected');
            }
        });
    }
}
function divReIndexing(dynamicGroupId) {
    if (typeof (dynamicGroupId) === 'undefined') {
        dynamicGroupId = "#dynamicRowGroup";
    } else {
        dynamicGroupId = '#' + dynamicGroupId;
    }
    if ($(dynamicGroupId).find('.select2-select').length > 0) {
        $('.select2-select').select2('destroy');
    }
    var divs = "";
    $.each($(dynamicGroupId + ">div.dynamicRow"), function (index, last) {
        var name = $(this).children().find('input,select')[0].name;
        var prePost = name.match(/([a-zA-Z]+?)(s\b|\b)/gi);
        var prefix = prePost.length === 1 ? "" : prePost[0];
        var div = '<div class="row no-gap dynamicRow">' +
            ($(last).html()
                .replace(/([A-Za-z])\w+[_]+[0-9]+/gi, prefix + '_' + index))
                .replace(/([A-Za-z])\w+\[[0-9]+\]/gi, prefix + '[' + index + ']') +
            '</div>';

        divs += div;
    });
    $("div.dynamicRow").remove();
    $(dynamicGroupId + ">div:first").after(divs);
    if ($(dynamicGroupId).find('.select2-select').length > 0) {
        $('.select2-select').select2({
            theme: "bootstrap",
            width: '100%',
            dropdownParent: $("#myModal")
        });
    }
}


function checkFillFields(idList) {
    const checksRadios = $(idList).find('input[type=checkbox], input[type=radio]');

    const inputs = $(idList).find('input,select,textarea')
        .not('input[type=checkbox],input[type=radio],input[type="submit"],input[type="button"],input[type="reset"]');

    const checked = checksRadios.filter(':checked');

    const filled = inputs.filter(function () {
        return $.trim($(this).val()).length > 0;
    });

    if (checked.length + filled.length === 0) {
        return false;
    }

    return true;
}

/*********************TABLE******************************************/
function addRowInTable(tableId = 'dataTable') {
    if (typeof (tableId) === 'undefined') {
        tableId = '#dataTable';
    } else {
        tableId = '#' + tableId;
    }
    var $last = $(tableId + '>tbody>tr:last');

    if ($last.length > 0) {

        if ($(tableId).find('.select2-select').length > 0) {
            $('.select2-select').select2('destroy');
        }
        var name = $last.children().find('input,select')[0].name;
        var prePost = name.match(/([a-zA-Z]+?)(s\b|\b)/gi);
        var index = Number(name.replace(/[^0-9]/gi, '')) + 1;
        var prefix = prePost.length === 1 ? "" : prePost[0];

        var tr = '<tr>' +
            $last.html()
                .replace(/([A-Za-z])\w+[_]+[0-9]+/gi, prefix + '_' + index)
                .replace(/([A-Za-z])\w+\[[0-9]+\]/gi, prefix + '[' + index + ']') +
            '</tr>';

        $(tableId + ' tbody').append(tr);

        $.each($(tableId + '>tbody>tr:last').find('input,select'), function (index, item) {
            if (item.type === 'hidden' && item.id.match(/__Id$/)) {
                item.value = '0';
            }
            if (item.type === 'text') {
                item.value = '';
                item.defaultValue = '';
            }
            if (item.type === 'select') {
                $('#' + item.id + ' option').removeAttr('selected');
            }
        });
        var prefix = $(tableId).attr('data-modalPrefix');

        if ($(tableId).find('.select2-select').length > 0) {
            if (prefix == undefined) {
                $('.select2-select').select2({
                    theme: "bootstrap",
                    width: '100%'
                });
            } else {
                $('.select2-select').select2({
                    theme: "bootstrap",
                    width: '100%',
                    dropdownParent: $(`#${prefix}Modal`)
                });
            }
        }

    }
}
function removeRowInTable(arg) {
    var table = arg.parentNode.parentNode.parentNode.parentNode;
    var rowCount = $('#' + table.id + '>tbody>tr').length;
    if (rowCount > 1) {
        $(arg).parent().parent().remove();
        tableReIndexing(table.id);
    }
}
function tableLastIndex(tableId) {
    var last = $('#' + tableId + '>tbody>tr:last');
    var id = last.children().find('input,select')[0].id;
    var index = Number(id.replace(/([A-Za-z_])/gi, ''));
    return index;
}
function tableReIndexing(tableId) {
    if (typeof (tableId) === 'undefined') {
        tableId = '#dataTable';
    } else {
        tableId = '#' + tableId;
    }
    let trs = "";
    if ($(tableId).find('.select2-select').length > 0) {
        $('.select2-select').select2('destroy');
    }
    $.each($(tableId + '>tbody>tr'), function (index, last) {
        var name = $(this).children().find('input,select')[0].name;
        var prePost = name.match(/([a-zA-Z]+?)(s\b|\b)/gi);
        var prefix = prePost.length === 1 ? "" : prePost[0];

        let $updateTr = $(last);
        let serial = index + 1;
        $updateTr.find(".serial-number").html(serial);
        $updateTr.find(".orderable-element").val(serial);

        var tr = '<tr>' +
            $updateTr.html()
                .replace(/([A-Za-z])\w+[_]+[0-9]+/gi, prefix + '_' + index)
                .replace(/([A-Za-z])\w+\[[0-9]+\]/gi, prefix + '[' + index + ']') +
            '</tr>';
        trs += tr;
    });
    $(tableId + ' tbody').html('');
    $(tableId + ' tbody').append(trs);
    let prefix = $(tableId).attr('data-modalPrefix');
    if ($(tableId).find('.select2-select').length > 0) {
        if (prefix == undefined) {
            $('.select2-select').select2({
                theme: "bootstrap",
                width: '100%'
            });
        } else {
            $('.select2-select').select2({
                theme: "bootstrap",
                width: '100%',
                dropdownParent: $(`#${prefix}Modal`)
            });
        }
    }
}
function searchTable(result, tableId, trClass) {

    if (result) {
        var reg = new RegExp(result, 'i'); // case-insesitive
        $('#' + tableId + ' tbody').find('tr.' + trClass).each(function () {
            var $me = $(this);
            if ($me.children('td').text().match(reg)) {
                $me.show();
            } else {
                $me.hide();
            }
        });
        $('#' + tableId).removeHighlight();
        $('#' + tableId).highlight(result);
    } else {
        $('#' + tableId + ' tbody').find('tr').show();
        $('#' + tableId).removeHighlight();
    }
}
function sortingTable(tableId, columnIdList) {
    if (typeof (tableId) === 'undefined') {
        tableId = '#dataTable';
    } if (typeof (columnIdList) === 'undefined') {
        columnIdList = '.sortable';
    }
    var table = $(tableId);
    $(columnIdList)
        .append('<i class="fa fa-fw fa-sort"></i>')
        .each(function () {
            var th = $(this),
                thIndex = th.index(),
                inverse = false;
            var desc = true;
            th.click(function () {
                table.find('td').filter(function () {
                    return $(this).index() === thIndex;
                }).sortElements(function (a, b) {
                    return $.text([a]) > $.text([b]) ?
                        inverse ? -1 : 1
                        : inverse ? 1 : -1;
                }, function () {
                    return this.parentNode;
                });
                $(columnIdList).children('i').remove();
                $(columnIdList).append('<i class="fa fa-fw fa-sort"></i>');
                $(this).children('i').remove();
                if (desc) {
                    $(this).append('<i class="fa fa-fw fa-sort-desc"></i>');
                } else {
                    $(this).append('<i class="fa fa-fw fa-sort-asc"></i>');
                }
                desc = !desc;
                inverse = !inverse;
            });
        });
}
function sortingTableWithRowspan(tableId, columnIdList) {
    var inverse = false;
    var desc = true;
    $(columnIdList).append('<i class="fa fa-fw fa-sort"></i>');
    function sortColumn(index) {
        var trs = $(tableId + ' > tbody > tr'),
            nbRowspans = trs.first().children('[rowspan]').length,
            offset = trs.first().children('[rowspan]').last().offset().left;

        var tds = trs.children('[rowspan]').each(function () {
            $(this).data('row', $(this).parent().index());
            $(this).data('column', $(this).index());
            $(this).data('offset', $(this).offset().left);
        }).each(function () {
            if ($(this).data('offset') != offset)
                return;
            var rowMin = $(this).data('row'),
                rowMax = rowMin + parseInt($(this).attr('rowspan'));
            trs.slice(rowMin, rowMax).children().filter(function () {
                return $(this).index() == index + $(this).parent().children('[rowspan]').length - nbRowspans;
            }).sortElements(function (a, b) {
                a = convertToNum($(a).text());
                b = convertToNum($(b).text());
                return (
                    isNaN(a) || isNaN(b) ?
                        a > b : +a > +b
                ) ?
                    inverse ? -1 : 1 :
                    inverse ? 1 : -1;
            }, function () {
                return this.parentNode;
            });
        });
        var trs = $(tableId + ' > tbody > tr');
        tds.each(function () {
            if ($(this).parent().index() != $(this).data('row'))
                $(this).insertBefore(trs.eq($(this).data('row')).children().eq($(this).data('column')));
        });
        inverse = !inverse;
    }
    function convertToNum(str) {
        if (isNaN(str)) {
            var holder = "";
            for (i = 0; i < str.length; i++) {
                if (!isNaN(str.charAt(i))) {
                    holder += str.charAt(i);
                }
            }
            return holder;
        } else {
            return str;
        }
    }
    $(columnIdList).click(function () {
        sortColumn($(this).index());
        $(columnIdList).children('i').remove();
        $(columnIdList).append('<i class="fa fa-fw fa-sort"></i>');
        $(this).children('i').remove();
        if (desc) {
            $(this).append('<i class="fa fa-fw fa-sort-desc"></i>');
        } else {
            $(this).append('<i class="fa fa-fw fa-sort-asc"></i>');
        }
        desc = !desc;
    });
}
function exportTableToExcel(tableId) {
    var tabText = "<table border='2px'><tr>";
    var tab = document.getElementById(tableId);

    for (var j = 1; j < tab.rows.length; j++) {
        tabText = tabText + tab.rows[j].innerHTML + "</tr>";
    }

    tabText = tabText + "</table>";
    tabText = tabText.replace(/<A[^>]*>|<\/A>/g, "");//remove links
    tabText = tabText.replace(/<img[^>]*>/gi, ""); // remove images
    tabText = tabText.replace(/<input[^>]*>|<\/input>/gi, ""); // reomves input params

    var ua = window.navigator.userAgent;
    var msie = ua.indexOf("MSIE ");
    var sa;
    if (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./))  // If Internet Explorer
    {
        tab.append('<iframe id="txtArea" style="display:none"></iframe>');
        var txtArea = document.getElementById('txtArea');
        txtArea.document.open("txt/html", "replace");
        txtArea.document.write(tabText);
        txtArea.document.close();
        txtArea.focus();
        sa = txtArea.document.execCommand("SaveAs", true, "download.xls");
    }
    else
        sa = window.open('data:application/vnd.ms-excel,' + encodeURIComponent(tabText));

    return (sa);
}

/***********************RANDOM VALUE(captcha entry)*******************************************/

function drawCaptcha(id) {
    var a = Math.ceil(Math.random() * 10) + '';
    var b = Math.ceil(Math.random() * 10) + '';
    var c = Math.ceil(Math.random() * 10) + '';
    var d = Math.ceil(Math.random() * 10) + '';
    var e = Math.ceil(Math.random() * 10) + '';
    var f = Math.ceil(Math.random() * 10) + '';
    var g = Math.ceil(Math.random() * 10) + '';
    //  var code = a + ' ' + b + ' ' + ' ' + c + ' ' + d + ' ' + e + ' ' + f + ' ' + g;
    var code = a + '' + b + '' + '' + c + '' + d + '' + e + '' + f + '' + g;
    $("#" + id).val(code);
}
function validCaptcha(capture, input) {
    var str1 = ($("#" + id).val(capture)).split(' ').join('');
    var str2 = ($("#" + id).val(input)).split(' ').join('');
    if (str1 === str2) return true;
    return false;

}

/*******************************FORM****************************************************/
function getFixedFoltingButton() {

    var create = $("#action-name").val();
    if (create) {
        $("#fixed-button").show();
    } else {
        $("#fixed-button").hide();
    }
}
/*************************PAGING*********************************/
function redirectPagination(link, arg) {
    const url = link.replace(/pageSize=\d+/, "pageSize=" + arg.value);
    window.location.href = url;
}

function loadPagination(link, divId, arg) {
    const url = link.includes("PageSize") ? link.replace(/PageSize=\d+/, "PageSize=" + arg.value)
        : link.replace(/pageSize=\d+/, "pageSize=" + arg.value);
    loadLink(url, divId);
}

/*************************AUTH*********************************/
function getBaseUrl() {
    var getUrl = window.location;
    var baseUrl = getUrl.protocol + "//" + getUrl.host;
    return baseUrl;
}

function Logout() {
    //window.applicationCache.swapCache();
    localStorage.clear();
    history.go(-history.length);
    // $.connection.hub.stop();
    $('#logoutForm').submit();

}
function confirmBox(type) {
    var message = type
        ? `Do you really want to ${type} the information?`
        : "Do you really want to save the information?";

    bootbox.confirm({
        message: message,
        buttons: {
            confirm: {
                label: 'Yes',
                className: 'btn-success'
            },
            cancel: {
                label: 'No',
                className: 'btn-danger'
            }
        },
        callback: function (result) {
            return  result;
        }
    });
}

/*************************Load Template*********************************/

function renderTemplateStr(templateName, templateDir = "/Templates/Shared") {
    if (!renderTemplateStr.template_cache) {
        renderTemplateStr.template_cache = {};
    }
    if (!renderTemplateStr.template_cache[templateName]) {
        const templateUrl = templateDir + "/" + templateName + ".html";
        var templateString;
        $.ajax({
            url: templateUrl,
            method: 'GET',
            dataType: 'html',
            async: false,
            success: function (data) {
                templateString = data;
            }
        });
        renderTemplateStr.template_cache[templateName] = _.template(templateString);
    }

    return renderTemplateStr.template_cache[templateName];
}

function renderTemplate(templateName, templateData, templateDir = "/Templates/Shared") {
    if (!renderTemplate.template_cache) {
        renderTemplate.template_cache = {};
    }

    if (!renderTemplate.template_cache[templateName]) {
        //if (typeof (templateDir) === 'undefined') {
        //    templateDir = '/Templates';
        //}

        const  templateUrl = templateDir + "/" + templateName + ".html";

        var templateString;
        $.ajax({
            url: templateUrl,
            method: 'GET',
            dataType: 'html',
            async: false,
            success: function (data) {
                templateString = data;
            }
        });
        _.templateSettings = {
            evaluate: /\{\{(.+?)\}\}/g,
            interpolate: /\{\{=(.+?)\}\}/g,
            escape: /\{\{-(.+?)\}\}/g
        };

        renderTemplate.template_cache[templateName] = _.template(templateString);
    }

    return renderTemplate.template_cache[templateName](templateData);
}

/****************************copy/cut/pest To Clipboard***************************************/
function copyToClipboard(elem) {
    // create hidden text element, if it doesn't already exist
    var targetId = "_hiddenCopyText_";
    var isInput = elem.tagName === "INPUT" || elem.tagName === "TEXTAREA";
    var origSelectionStart, origSelectionEnd;
    if (isInput) {
        // can just use the original source element for the selection and copy
        target = elem;
        origSelectionStart = elem.selectionStart;
        origSelectionEnd = elem.selectionEnd;
    } else {
        // must use a temporary form element for the selection and copy
        target = document.getElementById(targetId);
        if (!target) {
            var target = document.createElement("textarea");
            target.style.position = "absolute";
            target.style.left = "-9999px";
            target.style.top = "0";
            target.id = targetId;
            document.body.appendChild(target);
        }
        target.textContent = elem.textContent.trim();
    }
    // select the content
    var currentFocus = document.activeElement;
    target.focus();
    target.setSelectionRange(0, target.value.length);

    // copy the selection
    var succeed;
    try {
        succeed = document.execCommand("copy");
    } catch (e) {
        succeed = false;
    }
    // restore original focus
    if (currentFocus && typeof currentFocus.focus === "function") {
        currentFocus.focus();
    }

    if (isInput) {
        // restore prior selection
        elem.setSelectionRange(origSelectionStart, origSelectionEnd);
    } else {
        // clear temporary content
        target.textContent = "";
    }
    return succeed;
}

function copyStrToClipboard(str) {
    // create hidden text element, if it doesn't already exist
    var targetId = "_hiddenCopyText_";
    var target = document.getElementById(targetId);
    if (!target) {
        target = document.createElement("textarea");
        target.style.position = "absolute";
        target.style.left = "-9999px";
        target.style.top = "0";
        target.id = targetId;
        document.body.appendChild(target);
    }
    target.textContent = str.trim();
    // select the content
    var currentFocus = document.activeElement;
    target.focus();
    target.setSelectionRange(0, target.value.length);

    // copy the selection
    var succeed;
    try {
        succeed = document.execCommand("copy");
    } catch (e) {
        succeed = false;
    }
    // restore original focus
    if (currentFocus && typeof currentFocus.focus === "function") {
        currentFocus.focus();
    }
    target.textContent = "";
    return succeed;
}

/****************************ES6 Extension***************************************/
//Array.prototype.unique = function () {
//    var a = this.concat();
//    for (var i = 0; i < a.length; ++i) {
//        for (var j = i + 1; j < a.length; ++j) {
//            if (a[i] === a[j]) {
//                a.splice(j--, 1);
//            }
//        }
//    }
//    return a;
//}
function make_base_auth(user, password) {
    var tok = user + ':' + password;
    var hash = btoa(tok);
    return "Basic " + hash;
}

/****************************JQUERY Extension***************************************/

$.extend(
    {
        redirectPost: function (action, json,target="",method="POST") {
            var form = '';
            for (var key in json) {
                if (json.hasOwnProperty(key)) {
                    form += `<input type="hidden" name="${key}" value="${json[key]}">`;
                }
            }
            target = target ? `target="${target}"` : "";
            var formHtml = `<form style="display: none;" ${target} action="${action}" method="${method}">${form}</form>`;

            $(formHtml).appendTo($(document.body)).submit();
        },
        ajaxGET: function (url, paramJSON = null) {
            var returnResult;
            var formObj = {
                type: 'GET',
                url: url,
                headers: {},
                async: false,
                dataType: 'json',
                beforeSend: function () {
                }
            };
            let token = getApiToken();
            if (token) {
                formObj.headers['Authorization'] = "Bearer " + token;
            }
            if (paramJSON) {
                formObj.data = paramJSON;
            }
            var $jqxhr = $.ajax(formObj).done(function (result) {
                returnResult= result;
            });
            $jqxhr.fail(function (jqXHR) {
                returnResult= jqXHR.responseText;
            });
            return returnResult;
        },
        ajaxPOST: function (url, paramJSON, contentType = "application/x-www-form-urlencoded; charset=UTF-8") {
            var returnResult;
            var formObj = {
                type: 'POST',
                url: url,
                headers: {},
                async: false,
                dataType: 'json',
                beforeSend: function () {
                }
            };
            let token = getApiToken();
            if (token) {
                formObj.headers['Authorization'] = "Bearer " + token;
            }

            formObj.contentType = contentType;// 'application/json; charset=utf-8';//
            if (contentType.includes("application/json")) {
                formObj.data = JSON.stringify(paramJSON);
            } else {
                formObj.data = paramJSON;
            }

            var $jqxhr = $.ajax(formObj).done(function (result) {
                returnResult= result;
            });
            $jqxhr.fail(function (jqXHR) {
                returnResult= jqXHR.responseText;
            });
            return returnResult;
        }
    });
$.fn.extend(
    {
        highlight : function (c) {
            function e(b, c) {
                var d = 0;
                if (3 == b.nodeType) {
                    var a = b.data.toUpperCase().indexOf(c),
                        a = a - (b.data.substr(0, a).toUpperCase().length - b.data.substr(0, a).length);
                    if (0 <= a) {
                        d = document.createElement("span");
                        d.className = "highlight";
                        a = b.splitText(a);
                        a.splitText(c.length);
                        var f = a.cloneNode(!0);
                        d.appendChild(f);
                        a.parentNode.replaceChild(d, a);
                        d = 1;
                    }
                } else if (1 == b.nodeType && b.childNodes && !/(script|style)/i.test(b.tagName)
                ) for (a = 0; a < b.childNodes.length; ++a) a += e(b.childNodes[a], c);
                return d;
            }

            return this.length && c && c.length ? this.each(function () { e(this, c.toUpperCase()) }) : this;
        },
        removeHighlight : function () {
            return this.find("span.highlight")
                .each(function () {
                    this.parentNode.firstChild.nodeName;
                    with (this.parentNode) replaceChild(this.firstChild, this), normalize();
                })
                .end();
        },
        formToJSON: function() {
            var form = {};
            $("input,select,textarea", this).each(function() {
                var self = $(this);
                var name = self.attr('name');
                if (!form[name]) {
                    form[name] = self.val();
                }
            });
            return form;
        },
        copyToClipboard:function () {
            var $temp = $("<input>");
            $("body").append($temp);
            $temp.val($(this).text()).select();
            document.execCommand("copy");
            $temp.remove();
        },
        trackChanges: function () {
            $("input,select,textarea", this).change(function () {
                $(this.form).data("changed", true);
            });
        },
        isChanged: function () {
            return this.data("changed");
        },
        cascadingDropDown:function (url) {
            var $target = $(this);
            var selected = $target.attr('data-selected');
            $.getJSON(url, function (result) {
                $target.empty();
                $target.append('<option value>' + "--Select--" + '</option>');
                $.each(result, function (i, item) {
                    $target.append($("<option>").text(item.Text).val(item.Value));
                    if (selected) {
                        $target.find('option[value="' + selected + '"]').attr("selected", "selected");
                    }
                });
                $target.removeClass("disabled");
            });
            return false;
        },
        checkedtrueFalseRadio: function () {
            let $target = $(this);
        },
        makeDropDown: function (jsonOrUrl, optionText = "", selected="") {
            let $target = $(this);
            selected = selected == "" ? $target.attr('data-selected') : selected;
            $target.empty();
            let json = [];
            switch (whatIsIt(jsonOrUrl)) {
                case "Array":
                    json = jsonOrUrl;
                    break;
                case "String":
                    json = $.ajaxGET(jsonOrUrl);
                    break;
                case "Object":
                    json.push(jsonOrUrl);
                    break;
                default:
                    json = [];
            }

            if (optionText) {
                $target.append($("<option>",
                    {
                        value: '',
                        text: optionText,
                        selected: true
                    }));
            }
            $.each(json,function(i, item) {
                $target.append($("<option>",
                    {
                        value: item.Value,
                        text: item.Text,
                        selected: selected ? item.Value === selected : item.Selected
                    }));
            });
            $target.removeClass("disabled");
        },
        validateForm: function () {
            var $form = $(this);
            var objects = $form.find('input,select,textarea');
            objects.each(function (index, objField) {
                if (objField.type !== "button" && objField.type !== "hidden" && objField.type !== "submit") {

                    $("#" + objField.id).css("style");
                    var isRequired = objField.getAttribute('data-val')
                        ? objField.getAttribute('data-val').toLowerCase()
                        : "";
                    if (isRequired === "true" && !objField.value) {
                        objField.style.borderColor = "red";
                    } else {
                        objField.style.borderColor = "#d2d6de";
                    }
                }
            });
        },
        ajaxFormSubmit: function (contentType = "application/x-www-form-urlencoded; charset=UTF-8") {
            var $form = $(this);
            var formType = $("#saveButtonType").val();
            var prefix = $form.attr('data-modalPrefix');
            var loadDiv = $form.attr('data-load');
            var modalContent = '#myModalContent';
            var modalName = "#myModal";

            if (formType === "Modal") {
                prefix = prefix != undefined ? prefix : "my";
                modalName = `#${prefix}Modal`;
                modalContent = `#${prefix}ModalContent`;
            } else {
                loadDiv = loadDiv != undefined ? `#${loadDiv}` : "#mainContent";
            }

            var forgeryToken = $('input[name="__RequestVerificationToken"]').val();

            var formObj = {
                type: 'POST',
                url: $form.attr('action'),
                headers: {},
                async: false,
                dataType: 'json',
                beforeSend: function () {
                    Spiner.show();
                }
            };

            let $fileContent = $form.find("input[type=file]");

            if ($fileContent.length > 0) {
                var fd = new FormData();
                $.each($fileContent, function (key, input) {
                    fd.append(input.name, $("#" + input.id).get(0).files[0]);
                });
                var otherData = $form.serializeArray();
                $.each(otherData, function (key, input) {
                    fd.append(input.name, input.value);
                });

                formObj.processData = false;
                formObj.contentType = false;
                formObj.data = fd;
            } else {
                let jsonData = JSON.parse(JSON.stringify($form.serializeArray()));
                formObj.contentType = contentType;
                if (contentType.includes("application/json")) {
                    formObj.headers['RequestVerificationToken'] = forgeryToken;
                    formObj.data = JSON.stringify(jsonData);
                } else {
                    jsonData.__RequestVerificationToken = forgeryToken;
                    formObj.data = jsonData;
                }
            }

            setTimeout(function () {
                var $jqxhr = $.ajax(formObj).done(function (result) {
                    if (result == undefined) {
                        return;
                    }
                    if (formType === "Modal") {
                        $(modalContent).html(result);
                        $(modalName).modal('show');

                    } else {
                        BSTS.messageBox.showMessage(true, result.message);
                        $(modalName).modal('hide');
                    }
                    Spiner.hide();
                });
                $jqxhr.fail(function (jqXHR) {

                    if (jqXHR.status !== 500 && jqXHR.status !== 404) {
                        if (formType === "Modal") {
                            $(modalContent).html(jqXHR.responseText);
                            $(modalName).modal('show');
                        } else {
                            $(loadDiv).html(jqXHR.responseText);
                        }
                    }
                    Spiner.hide();
                });

            }, 10);
        },
        newTabFormSubmit: function (action = '', method = "POST") {
            var $form = $(this);
            action = action ? action : $form.attr('action');
            var formField = '';
            $.each($form.serializeArray(), function (input) {
                formField += `<input type="hidden" name="${input.name}" value="${input.value}">`;
            });

            let formHtml = `<form style="display: none;" target='_blank' action="${action}" method="${method}">${formField}</form>`;

            $(formHtml).appendTo($(document.body)).submit();
        },
        openWithSubmit: function (action='') {
            let $form = $(this);
            if (typeof (action) === 'undefined' || action==='') {
                action = $form.attr('action');
            }
            var form = document.createElement("form");

            form.setAttribute("method", "POST");
            form.setAttribute("action", action);
            form.setAttribute("target", "formresult");

            var otherData = $form.serializeArray();

            $.each(otherData, function (key, input) {
                var hiddenField = document.createElement("input");
                hiddenField.setAttribute("name", input.name);
                hiddenField.setAttribute("value", input.value);
                form.appendChild(hiddenField);
            });
            form.style.display = 'none';
            document.body.appendChild(form);
            window.open(action, 'formresult');
            form.submit();

        },
        isFormFilled: function () {
            var $form = $(this);
            let checksRadios = $form.find(':checkbox, :radio'),
                inputs = $form.find(':input').not(checksRadios).not('[type="submit"],[type="button"],[type="reset"]');

            const checked = checksRadios.filter(':checked');
            const filled = inputs.filter(function () {
                return $.trim($(this).val()).length > 0;
            });

            if(checked.length + filled.length === 0) {
                return false;
            }

            return true;
        }


    });

//REMOVE LIST
function openWithSubmit(valueForm, action) {
    if (typeof (valueForm) === 'undefined') {
        valueForm = "ReportForm";
    }
    if (typeof (action) === 'undefined') {
        action = $('#' + valueForm).attr('action');;
    }
    var form = document.createElement("form");

    form.setAttribute("method", "post");
    form.setAttribute("action", action);
    form.setAttribute("target", "formresult");

    var otherData = $('#' + valueForm).serializeArray();

    $.each(otherData, function (key, input) {
        var hiddenField = document.createElement("input");
        hiddenField.setAttribute("name", input.name);
        hiddenField.setAttribute("value", input.value);
        form.appendChild(hiddenField);
    });
    form.style.display = 'none';
    document.body.appendChild(form);
    window.open(action, 'formresult');
    form.submit();

}
