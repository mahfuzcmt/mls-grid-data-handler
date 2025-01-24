var firstSeatLabel = 1;
var ticketTimer = null;
var holdingTime = 60;//sec
$(document).ready(function() {
    var seatMap = $('#seat-map');
    var ticketId = seatMap.attr("ticketid");
    var date = seatMap.attr("date");
    var rows = parseInt(seatMap.attr("rows"));
    var columns = parseInt(seatMap.attr("columns"));
    var price = parseFloat(seatMap.attr("price"));
    var extraSeatInLastRow = seatMap.attr("extraseatinlastrow");

    var rowsCharacters = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']
    var threeColumnsDesignV1 = ['A_AA','B_BB','C_CC','D_DD','E_EE','F_FF','G_GG','H_HH','I_II','J_JJ','K_KK','L_LL','M_MM','N_NN','O_OO','P_PP','Q_QQ','R_RR','S_SS','T_TT','U_UU','V_VV','W_WW','X_XX','Y_YY','Z_ZZ']
    var fourColumnsDesignV1 = ['AA_AA','BB_BB','CC_CC','DD_DD','EE_EE','FF_FF','GG_GG','HH_HH','II_II','JJ_JJ','KK_KK','LL_LL','MM_MM','NN_NN','OO_OO','PP_PP','QQ_QQ','RR_RR','SS_SS','TT_TT','UU_UU','VV_VV','WW_WW','XX_XX','YY_YY','ZZ_ZZ']

    var seatDesign = []
    var lastRow = rows - 1
    var lastRowChar = rowsCharacters[lastRow]
    if(columns == 3){
        seatDesign = threeColumnsDesignV1.slice(0, rows)
    }else if(columns == 4){
        seatDesign = fourColumnsDesignV1.slice(0, rows)
    }
    if((extraSeatInLastRow == "true")){
        console.log("extraSeatInLastRow")
        seatDesign[lastRow] = seatDesign[lastRow].replaceAll("_", lastRowChar)
    }

    var $cart = $('#cartTable'),
        $counter = $('#counter'),
        $total = $('#total'),
        $totalPaidAmountInput = $('.total-paid-amount'),
        sc = seatMap.seatCharts({

            map: seatDesign,

            seats: {
                A: {
                    price   : price,
                },
                B: {
                    price   : price,
                }  ,
                C: {
                    price   : price,
                },
                D: {
                    price   : price,
                },
                E: {
                    price   : price,
                },
                F: {
                    price   : price,
                }  ,
                G: {
                    price   : price,
                },
                H: {
                    price   : price,
                }  ,
                I: {
                    price   : price,
                },
                J: {
                    price   : price,
                }  ,
                K: {
                    price   : price,
                },
                L: {
                    price   : price,
                },
                M: {
                    price   : price,
                },
                N: {
                    price   : price,
                }  ,
                O: {
                    price   : price,
                },
                P: {
                    price   : price,
                },
                Q: {
                    price   : price,
                },
                R: {
                    price   : price,
                },
                S: {
                    price   : price,
                }  ,
                T: {
                    price   : price,
                },
                U: {
                    price   : price,
                },
                V: {
                    price   : price,
                },
                W: {
                    price   : price,
                },
                X: {
                    price   : price,
                }  ,
                Y: {
                    price   : price,
                },
                Z: {
                    price   : price,
                }
            },
            naming : {
                top : true,
                left : true,
                getLabel : function (character, row, column) {
                    if((extraSeatInLastRow == "true") && (character == lastRowChar)){
                        return character + column;
                    }
                    if(columns == 3 && column >= 3){
                        column = column - 1
                    }else if(columns == 4 && column >= 4){
                        column = column - 1
                    }
                    return character + column;
                },
            },
            legend : {
                node : $('#legend'),
                items : [
                    [ 'f', 'available', 'Available' ],
                    [ 'f', 'unavailable', 'Sold(M)'],
                    [ 'f', 'female-sold', 'Sold(F)'],
                    [ 'f', 'booked-female', 'Booked(F)'],
                    [ 'f', 'booked', 'Booked(M)'],
                    [ 'f', 'readytobook', 'Selected' ],
                ]
            },
            click: function () {
                var seatNode = this.node()
                if (this.status() == 'available' && !seatNode.is(".selected")) {
                    $('#customer-phoneNumber').focus();
                    $('<tr class="selected-book-seats-item">' +
                        '<td class="border-1 text-center font_detail"> <b>Seat# '+this.settings.label+'</b><a href="#" class="cancel-cart-item">cancel</a></td>' +
                        '<td class="selected-price-fare border-1 text-center font_detail">'+ this.data().price + '</td>' +
                        '</tr>')
                        .attr('id', 'cart-item-'+this.settings.id)
                        .attr('seatno', this.settings.id)
                        .data('seatId', this.settings.id)
                        .insertBefore($("#selected-seats-details-row"));



                    $counter.text(sc.find('selected').length + 1);
                    var totalTextDisplay = "TOTAL: "
                    var totalPrice = recalculateTotal(sc) + this.data().price
                    $total.text(totalTextDisplay +""+ totalPrice + " TK");
                    var totalPaidAmount = recalculateTotal(sc) + this.data().price
                    $('.total-amount-to-paid-to-calc').val(totalPaidAmount);
                    var totalPaidableAmount = totalPaidAmount - $(".booked-seat-discount-on-total").val()
                    $totalPaidAmountInput.val(totalPaidableAmount);
                    $totalPaidAmountInput.trigger("change");
                    $(".booked-seat-map-numbers").append('<input type="hidden" name="seatBooked" value="'+this.settings.id+'">')
                    $(".booked-seat-map-numbers").append('<input type="hidden" name="seatBookedForDisplay" value="'+ $("#"+this.settings.id).text() +'">')

                    console.log("callHoldTicket")
                    callHoldTicket(this.settings.id, false);

                    return 'selected';

                } else if (this.status() == 'selected') {

                    $counter.text(sc.find('selected').length-1);
                    var totalTextDisplay = "TOTAL: "
                    var totalPrice = recalculateTotal(sc) - this.data().price
                    $total.text(totalTextDisplay + totalPrice + " TK");
                    var totalPaidAmount = recalculateTotal(sc) - this.data().price
                    $('.total-amount-to-paid-to-calc').val(totalPaidAmount);

                    var totalPaidableAmount = totalPaidAmount - $(".booked-seat-discount-on-total").val()
                    $totalPaidAmountInput.val(totalPaidableAmount);
                    $totalPaidAmountInput.trigger("change");
                    $('#cart-item-'+this.settings.id).remove();

                    $(".booked-seat-map-numbers").find('input[value="'+this.settings.id+'"]').remove();
                    $(".booked-seat-map-numbers").find('input[value="'+$("#"+this.settings.id).text()+'"]').remove();
                    console.log("callHoldTicket")
                    callHoldTicket(this.settings.id, true);
                    return 'available';

                } else if (this.status() == 'unavailable') {
                    return 'unavailable';
                } else {
                    seatNode.removeClass("selected")
                    callHoldTicket(this.settings.id, true);
                    return this.style();
                }
            }
        });

    console.log("##### Seat Charts ######");

    $('#cartTable').on('click', '.cancel-cart-item', function () {
        //let's just trigger Click event on the appropriate seat, so we don't have to repeat the logic here
        sc.get($(this).parents(".selected-book-seats-item").data("seatId")).click();
    });

    var discountInput = $(".booked-seat-discount-on-total")
    discountInput.on("input", function (){
        var totalPaidAmount = $('.total-amount-to-paid-to-calc').val();
        var totalPaidableAmount = totalPaidAmount - discountInput.val()
        $totalPaidAmountInput.val(totalPaidableAmount);
        $totalPaidAmountInput.trigger("change");
    })

    console.log("zone replace start")

    var seatMap = $("#seat-map");
    console.log("soldseats")
    sc.get(seatMap.attr("soldseats").replaceAll("[[", "").replaceAll("]]", "").replaceAll("]", "").replaceAll("[", "").replaceAll(" ", "").split(",")).status('unavailable');

    console.log("femalesoldseats")
    sc.get(seatMap.attr("femalesoldseats").replaceAll("[[", "").replaceAll("]]", "").replaceAll("]", "").replaceAll("[", "").replaceAll(" ", "").split(",")).status('female-sold');

    console.log("bookedseats")
    sc.get(seatMap.attr("bookedseats").replaceAll("[[", "").replaceAll("]]", "").replaceAll("]", "").replaceAll("[", "").replaceAll(" ", "").split(",")).status('booked');

    console.log("femalebookedseats")
    sc.get(seatMap.attr("femalebookedseats").replaceAll("[[", "").replaceAll("]]", "").replaceAll("]", "").replaceAll("[", "").replaceAll(" ", "").split(",")).status('booked-female');

    console.log("selectedseats")
    var selectedSeats = seatMap.attr("selectedseats");

    if(selectedSeats){
        sc.get(selectedSeats.replaceAll("[[", "").replaceAll("]]", "").replaceAll("]", "").replaceAll("[", "").replaceAll(" ", "").split(",")).status('selected');
        sc.find('selected').each(function (seatId) {

            $('<tr class="selected-book-seats-item">' +
                '<td class="border-1 text-center font_detail"> <b>Seat# '+this.settings.label+'</b><a href="#" class="cancel-cart-item">cancel</a></td>' +
                '<td class="border-1 text-center font_detail">'+ this.data().price + '</td>' +
                '</tr>')
                .attr('id', 'cart-item-'+this.settings.id)
                .attr('seatno', this.settings.id)
                .data('seatId', this.settings.id)
                .insertBefore($("#selected-seats-details-row"));


        });
    }

    BSTS.ajax.call({
        url: BSTS.baseURL + "busTicket/bookedSeatDataList",
        data: {id: ticketId, date: date},
        success: function (resp) {
            console.log("bookedSeatDataList")

            var reservedTickets = resp.bookedSeatDataList
            $.each(reservedTickets,function() {
                console.log("reservedTickets")
                var ticket = this

                var seatNo =  ticket.seatNo;
                var ticketNo =  ticket.ticketNo;

                console.log("seatNo:"+seatNo)
                var seatDiv = $(`#${seatNo}`)
                var seatName = seatDiv.text()
                var name = ticket.passengerName;
                var gender = ticket.gender;
                var mobile = ticket.mobile;
                var pickfrom = ticket.pickFrom;
                var saleby =  ticket.saleBy;

                seatDiv.attr("name", seatName);
                seatDiv.attr("mobile", mobile);
                seatDiv.attr("pickfrom", pickfrom);
                seatDiv.attr("saleby", saleby);

                console.log("saleby")

                previewPopover({
                    control: seatNo,
                    html: $('<div class="popover-panel-wrapper-tol ticket-details-popover">' +
                        '<div class="arrow" style="left: 50%;"></div>' +
                        '<h6 class="popover-title '+ gender +'"><strong>'+ name +'</strong></h6>' +
                        '<div class="popover-content">' +
                        '<div class="table-responsive">' +
                        '<table class="table table-bordered">' +
                        '<tbody>'+
                        '<tr>' +
                        '<td class="poup-td">Phone</td>' +
                        '<td class="poup-td">' +
                        '<span class="btn-link" style="cursor: pointer;">' +
                        + mobile  +
                        '</span>' +
                        '</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<td class="poup-td">From</td>' +
                        '<td class="poup-td">'+ pickfrom +'</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<td class="poup-td">Sale By</td>' +
                        '<td class="poup-td">'+ saleby +'</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<td class="poup-td">Ticket No#</td>' +
                        '<td class="poup-td"><button onclick="renderTicketDetails('+ ticketNo +')" ticketno="'+ticketNo+'" type="button" ' +
                        'class="ticket-render-button-popover btn btn-primary btn-sm">'+ ticketNo +'</button></td>' +
                        '</tr>' +
                        '</tbody>' +
                        '</table>' +
                        '</div>' +
                        '</div>' +
                        '</div>'),
                    header: seatName,
                    container:"body",
                    placement: "auto",
                });

            });
        }
    });


    var ticketData = {}
    const tripId = $('#ScheduleId').val();
    ticketData.tripId = tripId
    if (tripId !== null || tripId !== '') {
        var form = $("#SearchScheduleFrom")
        var routeId = form.find("#RouteId").val()
        var date = form.find("#Date").val()
        ticketData.routeId = routeId
        ticketData.date = date
    }

    console.log("allHoldTickets PullRequest")
    console.log(ticketData)
    new PullRequest(BSTS.baseURL + "holdTicket/allHoldTickets", 100,
        ticketData).startPoll()

    $(".fromToStoppage").on('change', function (e) {

        showLoader()

        let $fts = $(this);
        let from = $fts.attr("id") === "fromStoppage" ? parseInt($fts.val()) : parseInt($('#fromStoppage').val());
        let to = $fts.attr("id") === "toStoppage" ? parseInt($fts.val()) : parseInt($('#toStoppage').val());
        let routeId = $("#route-id").val()
        changeStoppage(routeId, from, to, sc, rowsCharacters);
    })

    $("#toStoppage").trigger("change")

    $("#totalPaidAmount").change(function () {
        let totalAmount = $(this).val();
        $('#receivedFromCustomer').val(totalAmount);
        $("#DueAmount").val(0);
        $(".book-confirm-button").addClass("disabled");
        $(".sell-confirm").removeClass("disabled");

    });

    $("#unknownUserCheckBox").change(function () {
        console.log("unknownUserCheckBox");
        let isChecked = $(this).is(':checked');
        if (isChecked) {
            $('#customer-name').addClass('disabled');
            $('#customer-gender').addClass('disabled');
            $('#customer-phoneNumber').addClass('disabled');
            $('#customer-name').val('UNKNOWN');
            $('#customer-phoneNumber').val('01000000000');
        } else {
            $('#customer-name').removeClass('disabled');
            $('#customer-gender').removeClass('disabled');
            $('#customer-phoneNumber').val('');
            $('#customer-name').val('');
            $('#customer-phoneNumber').removeClass('disabled');
        }
    });

    $("#receivedFromCustomer").change(function () {
        var receivedAmount = parseFloat($(this).val())
        var totalAmount = parseFloat($("#totalPaidAmount").val())
        if (receivedAmount < totalAmount) {
            $("#DueAmount").val(totalAmount - receivedAmount);
            $(".book-confirm-button").removeClass("disabled");
            $(".sell-confirm").addClass("disabled");
        } else {
            $("#DueAmount").val(0);
            $(".book-confirm-button").addClass("disabled");
            $(".sell-confirm").removeClass("disabled");
        }
    });

});

function callHoldTicket(seatNo = "", isSelected = false) {
    if (!seatNo) return;
    const tripId = $('#ScheduleId').val();
    if (tripId !== null || tripId !== ''){
        var form = $("#SearchScheduleFrom")
        var routeId = form.find("#RouteId").val()
        var date = form.find("#Date").val()
        var displayName = $(`#${seatNo}`).text()
        $.ajaxPOST(BSTS.baseURL + 'holdTicket/save',
            {
                "tripId": tripId,
                "routeId": routeId,
                "date": date,
                "seatNo": seatNo,
                "displayName": displayName,
                "isSelected": isSelected,
         });
    }

    if(!isSelected){
        setTimeout(function () {
            var selectedSeats = $(".seatCharts-seat.selected")
            clearHoldingTickets(selectedSeats, holdingTime * 1000);
        }, 2000);

    }
}


function changeStoppage(routeId, from, to, busSeatMap, rowsCharacters) {
    let scheduleId = $("#ScheduleId").val();
    BSTS.ajax.call({
        url: BSTS.baseURL + "busTicket/fareByFromToStoppage",
        data: {routeId: routeId, from: from, to: to, scheduleId: scheduleId},
        success: function (resp) {
            var seatFare = resp.seatFare
            var commission = resp.commission

            $.each(rowsCharacters, function() {
                busSeatMap.find(this).each(function () {
                    this.data().price = seatFare;
                });
             })

            $('.selected-price-fare').html(seatFare);
            $('#Fare').val(seatFare);
            $('.price').attr('data-price', seatFare);

            $('#commission').val(commission);

            $('.booked-seat-discount-on-total').val(0);

            var totalFare = recalculateTotal(busSeatMap)

            $('#receivedFromCustomer').val(totalFare);

            $('#total').text(totalFare).trigger('change');



            hideLoader()

        }
    });

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
            html: true,
            title: `<strong>${options.header}</strong>`,
            content: options.html,
            container: options.container,
            placement: options.placement,
            trigger: 'focus'
        })
    }
};

function renderTicketDetails(ticketNo){
    console.log("render Ticket No:" + ticketNo);
    var templateScheduleDate = $("#dtp_Date [name=Date]").length ? $("#dtp_Date [name=Date]").val() : $("#templateScheduleDate").val()
    $.ajax({
        url: BSTS.baseURL + 'busTicketAdvance/bookingPanel',
        method: 'GET',
        dataType: 'html',
        async: false,
        data:{id: $('#templateSeatId').val(), date: templateScheduleDate, ticketNo: ticketNo},
        success: function (data) {
            var bookingPanel = data;
            $("#advance-ticket-book-ui-body").html(bookingPanel);
        }
    });
}

function recalculateTotal(sc) {
    var total = 0;

    //basically find every selected seat and sum its price
    sc.find('selected').each(function () {
        total += this.data().price;
    });
    $('.total-amount-to-paid-to-calc').val(total)
    $('.total-paid-amount').val(total -  $(".booked-seat-discount-on-total").val());
    return total;
}

function stopTicketTimer() {
    if (ticketTimer) {
        clearTimeout(ticketTimer)
        ticketTimer = null;
    }
}

function clearHoldingTickets(selectedTickets, sessionTime) {
    stopTicketTimer();
    if (selectedTickets.length > 0) {
        let holding = selectedTickets
        if (holding.length > 0) {
            ticketTimer = setTimeout(function () {
                $.each(holding,function() {
                    var seat = $(this)
                    if(seat.is(".selected")){
                        var seatNo = seat.attr("id")
                        callHoldTicket(seatNo, true);
                        seat.trigger("click");
                    }

                });
            }, sessionTime);
        }
    }
}

function clearHoldingTicketsNow(selectedTickets) {
    stopTicketTimer();
    if (selectedTickets.length > 0) {
        let holding = selectedTickets
        if (holding.length > 0) {
            $.each(holding,function() {
                var seat = $(this)
                if(seat.is(".selected")){
                    var seatNo = seat.attr("id")
                    callHoldTicket(seatNo, true);
                }
            });
        }
    }
}


function showLoader(){
    $(".overlay.show").remove();
    $("body").append(" <div class=\"overlay show\">\n" +
        "      <div class=\"spanner show\">\n" +
        "      <div class=\"loader\"></div>\n" +
        "   </div>");
}

function hideLoader(){
    $("body").find(".overlay.show").remove();
}
