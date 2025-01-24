// This is a manifest file that'll be compiled into application.js.
//
// Any JavaScript file within this directory can be referenced here using a relative path.
//
// You're free to add application-wide JavaScript to this file, but it's generally better
// to create separate JavaScript files as needed.
//
//= require jquery-3.3.1.min
//= require bootstrap
//= require popper.min
//= require jquery-confirm.min
//= require OBTS
//= require OBTS.message.box
//= require OBTS.ajax
//= require OBTS.init
//= require_self



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

        }
    });
}


var saveRecord = (arg, fromId) => {
    var $arg = $(arg);

    var saveFormId = fromId
    if (saveFormId !== undefined) {
        var $form = $(`.${saveFormId}`);
        jQuery.confirm({
            title: 'Confirmation!',
            content: 'Do you really want to save the information?',
            buttons: {
                confirm: {
                    text: 'Yes',
                    btnClass: 'btn-blue',
                    action: function () {
                        Spiner.show();
                        var isValidate = true;
                        if (isValidate) {
                            $form.find("input[type=text]").each(function() {
                                this.value = $.trim(this.value);
                            });
                            $form.ajaxFormSubmit();
                        } else {
                            $.each($form.validate().errorList,
                                function(key, value) {
                                    console.log("Elm " +value.element.id + ": "+value.message)
                                });
                            Spiner.hide();
                        }
                    }
                },
                cancel: {
                    text: 'No'
                }
            }
        });

    }

};

