function PullRequest(url,seconds, data){
    console.log("PullRequest")
    var self = this;
    this.pollId = null;
    this.busy = false;
    this.data = null;
    //have a default that can be overridden with construction parameter
    this.url = BSTS.baseURL + "holdTicket/allHoldTickets";
    if(typeof(url) !== 'undefined' && url !== null){
        this.url = url;
    }

    //have a default that can be overridden with construction parameter
    this.seconds = 2000;
    if(typeof(seconds) !== 'undefined' && seconds !== null){
        this.seconds = seconds;
    }

    if(typeof(data) !== 'undefined' && data !== null){
        this.data = data;
    }


    this.startPoll = function(){
        this.pollId = setInterval(self.postAJAX,this.seconds);
        for (let i = 1; i < this.pollId; i++) {
            window.clearInterval(i);
        }
    };

    this.stopPoll = function(){
        clearInterval(this.pollId);
        this.pollId = null;
    };
    //to be called on polling completion - can be overridden if needed
    this.success = function(){
        self.busy = false;

    };

    this.postAJAX = function(){
        //check if we're in the middle of a request
        if(self.busy){
            return;
        }
        //we're not so set the busy flag
        self.busy = true;

        $.ajax({
            url: self.url,
            data: self.data,
            success: function(response) {
                var tickets = response.holdTickets
                unHoldingTickets(tickets)
                tickets.forEach(function (ticket) {
                    let seatNo = ticket.seatNo
                    let userId = ticket.userId
                    holdingTicket(seatNo, userId);
                });
                self.success()
            },
            dataType: "json",
            complete: function(response) {
                // we don't need to test here, because we're returning from runPoll
                // if we're not polling.
                // self.success(response)
            },
            error: function (response){
                self.busy = false;
            }
        });

        function holdingTicket(seatNo, userId) {
            let seatId = `#${seatNo}`;
            let loggedUserId = $(`#loggedUser`).val()
            if(userId == loggedUserId){
                if ($(seatId).hasClass("available")) {
                    $(seatId).removeClass("available");
                    $(seatId).addClass("selected");
                    $(seatId).addClass("user-other-client-selected");
                }
            }else {
                if ($(seatId).hasClass("available")) {
                    $(seatId).removeClass("available");
                    $(seatId).addClass("unavailable");
                    $(seatId).addClass("holding");
                }
            }
        }

        function unHoldingTickets(tickets) {
                let seatMap = `#seat-map`;
                var holdTickets = $(seatMap).find(".holding")
                var clientTickets = $(seatMap).find(".user-other-client-selected")


              $.each(holdTickets, function(key, value) {
                    var seat = $(this)
                    var holdSeat = seat.attr("id")
                    var hasInHoldsList = false
                    tickets.forEach(function (ticket) {
                        let seatNo = ticket.seatNo
                        if(holdSeat == seatNo){
                            hasInHoldsList = true
                        }
                    });
                    if(!hasInHoldsList){
                        seat.removeClass("unavailable")
                        seat.removeClass("holding")
                        seat.addClass("available");

                    }
                });

            $.each(clientTickets, function(key, value) {
                var seat = $(this)
                var holdSeat = seat.attr("id")
                var hasInHoldsList = false
                tickets.forEach(function (ticket) {
                    let seatNo = ticket.seatNo
                    if(holdSeat == seatNo){
                        hasInHoldsList = true
                    }
                });
                if(!hasInHoldsList){
                    clientTickets.removeClass("user-other-client-selected")
                    clientTickets.removeClass("selected")
                    clientTickets.addClass("available")
                }
            });



            }

    };
}
