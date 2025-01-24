
jQuery(document).ready(function () {

    jQuery('.delete-confirmation').confirm({
        title: 'Delete Confirmation!',
        content: 'Are you sure want to delete?'
    });

    jQuery('.card-body').on('click', '.add-new-number ', function () {
        var _this = jQuery(this);
        BSTS.ajax.call({
            url: BSTS.baseURL + "coachDetails/create",
            dataType: "html",
            success: function (content) {
                jQuery('.details-panel').append(content);
                _this.removeClass("add-new-number");
                _this.removeClass("btn-primary");
                _this.addClass("remove-number");
                _this.addClass("btn-danger");
                _this.find(".fas").removeClass("fa-plus-circle");
                _this.find(".fas").addClass("fa-trash");
            }
        });
    });

    jQuery('.card-body').on('click', '.remove-number', function () {
        var _this = jQuery(this),
            coachId = _this.attr("data-id");

        jQuery.confirm({
            title: 'Delete Confirmation!',
            content: 'Are you sure want to delete?',
            buttons: {
                confirm: {
                    text: 'Yes',
                    btnClass: 'btn-blue',
                    action: function () {
                        if(coachId !== undefined){
                            BSTS.ajax.call({
                                url: BSTS.baseURL + "coachDetails/delete/" + coachId,
                                success: function (content) {
                                    if(content.success === true){
                                        BSTS.messageBox.showMessage(true, content.info);
                                        _this.closest(".form-group").remove();
                                    }else{
                                        BSTS.messageBox.showMessage(false, content.info)
                                    }
                                }
                            });
                        }else{
                            _this.closest(".form-group").remove();
                        }
                    }
                },
                cancel: {
                    text: 'No'
                }
            }
        });

    });

});