$(document).ready(function() {

    $("#saveBtnContainer").show();
    $("#save-continue-edit").hide();
    $("#save-continue-add").hide();

    if ($("#hasValue").val()) {
        $("#btnCommonSave").show();
    } else {
        $("#btnCommonSave").hide();
    }
});

var listOfNames = [
"chkFullAll", "chkListViewAll", "chkAddAll", "chkEditAll", "chkDeActiveAll", "chkDeleteAll", "chkDetailsAll",
"chkReportAll", "chkActiveAll"
];
    var listOfChildNames = $.filter(listOfNames, function (name) { return name !=="chkFullAll"; });
    var childClasses = `.${listOfChildNames.join(",.")}`;
    var childIds = `#${listOfChildNames.join(",#")}`;

    $('#userAccessTable>thead>tr>th>label>input[type=checkbox]').on('click',function() {
        var ckbId = this.id;
    var ckbVal = $(this).prop('checked');
        $(`.${ckbId}`).prop('checked', ckbVal);
    checkHeaderFullAccess(ckbId, ckbVal);
});

    $(".chkFullAll").on("click",function () {
        var ckbVal = $(this).prop('checked');
        $(this).closest('tr').find("input[type=checkbox]").each(function() {
        $(this).prop('checked', ckbVal);
    });
        var allChildCheck = $.map($("#userAccessTable").find("input[type=checkbox].chkFullAll"),function (input) {
            return $(input).prop('checked');
});
        var hasUnChecked = $.some(allChildCheck, function (item) { return item === false; });
    $(childIds).prop('checked', !hasUnChecked);
    $("#chkFullAll").prop('checked', !hasUnChecked);
});

    $(childClasses).on("click", function () {
        var classNames = $(this).attr('class').split(' ');
        var typeClassName = $.find(classNames, function (name) {return name.match(/^chk.*$/)});
    checkChildFullAccess(typeClassName);


    var full = $(this).closest('tr').find("input[type=checkbox].chkFullAll").get();
        var allChildCheck = $.map($(this).closest('tr').find("input[type=checkbox]:not(.chkFullAll)"),function (input) {
            return $(input).prop('checked');
});
        var hasUnChecked = $.some(allChildCheck, function (item) { return item === false; });
    $(full).prop('checked', !hasUnChecked);

    $("#chkFullAll").prop('checked', !checkFullAccess());

});

    function checkHeaderFullAccess(ckbHeaderId, ckbHeaderVal) {

        if (ckbHeaderId === "chkFullAll") {
        $("#userAccessTable").find("input[type=checkbox]").each(function () {
            $(this).prop('checked', ckbHeaderVal);
        });
    } else {
            if (ckbHeaderVal === false) {
        $("#chkFullAll").prop('checked', false);
    $(".chkFullAll").prop('checked', false);
}
            var allHeaderChildCheck = $.map($(childIds),function (input) {
                return $(input).prop('checked');
});
            var hasUnChecked = $.some(allHeaderChildCheck, function (item) { return item === false; });
    $("#chkFullAll").prop('checked', !hasUnChecked);
    $(".chkFullAll").prop('checked', !hasUnChecked);

}

}

    function checkFullAccess() {
        var allChildCheck = $.map($("#userAccessTable").find("input[type=checkbox].chkFullAll"),function (input) {
            return $(input).prop('checked');
});
        var hasUnChecked = $.some(allChildCheck, function (item) { return item === false; });
    return hasUnChecked;
}

    function checkChildFullAccess(childName) {
        var allChildCheck = $.map($("#userAccessTable").find(`input[type=checkbox].${childName}`),function (input) {
            return $(input).prop('checked');
});
        var hasUnChecked = $.some(allChildCheck, function (item) { return item === false; });
        $(`#${childName}`).prop('checked', !hasUnChecked);
}
