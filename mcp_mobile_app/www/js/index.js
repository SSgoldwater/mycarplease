var app = {
  // Application Constructor
  initialize: function() {
    this.bindEvents();
  },
  // Bind Event Listeners
  //
  // Bind any events that are required on startup. Common events are:
  // 'load', 'deviceready', 'offline', and 'online'.
  bindEvents: function() {
    document.addEventListener('deviceready', this.onDeviceReady, false);
    
  },
  // deviceready Event Handler
  //
  // The scope of 'this' is the event. In order to call the 'receivedEvent'
  // function, we must explicitly call 'app.receivedEvent(...);'
  onDeviceReady: function() {
    app.receivedEvent('deviceready');
  },
  // Update DOM on a Received Event
  receivedEvent: function(id) {
    var parentElement = document.getElementById(id);
    var listeningElement = parentElement.querySelector('.listening');
    var receivedElement = parentElement.querySelector('.received');

    listeningElement.setAttribute('style', 'display:none;');
    receivedElement.setAttribute('style', 'display:block;');

    console.log('Received Event: ' + id);
  }

};

$(document).bind("mobileinit", function() {
  $.mobile.allowCrossDomainPages = true;
  $.support.cors = true
});

app.initialize();

$(document).ready(function() {

  $('.clock-in-button').on('click', function() {
    $.ajax({
      type: 'POST',
      url: 'http://mycarplease.herokuapp.com/api/v1/clockin',
      dataType: "json",
      data: { account: $('.employee-location-selector').children(':checked').text(), 
	email:    $('.clock-in-field.email').val(),
      password: $('.clock-in-field.password').val()
      }, 
      success: function(data) {
	$('.app-home').hide(),	  
	$('.app-dash').show(),
	renderEmployeeName(data),
	renderShiftLocation(data),
	fetchVehicles(data["vehicles"])
      },
      error: function() {
	if (!$('.app-home h3').hasClass('invalid-login')) { 
	  $('.app-home').append(
	    "<h3 class=\"invalid-login\">Invalid login credentials</h3>"
	  )
	}
      }
    })
  });

  $('.new-car').on('click', function() {
    ticketNo = $('.ticket_no').val();
    space = $('.space').val();
    account = $('.location-name').text();
    color = $('.vehicle-color').children(':checked').text()
    style = $('.vehicle-class').children(':checked').text()

    var vehicle_params = {
      ticketNo: ticketNo,
      space: space,
      account: account,
      color: color,
      style: style
    };

    $.ajax({
      type: 'POST',
      url: 'http://mycarplease.herokuapp.com/api/v1/vehicles.json',
      data: vehicle_params,
      success: function(vehicle) {
        $('.ticket_no').val("")
        $('.space').val("")
        $('.new-car').siblings().remove()
	renderVehicle(vehicle)
      },
      error: function() {
	$('.new-car').parents('td').append(
	  "<p class=\"invalid-vehicle\" style=\"margin\":\"0em\">Invalid<br>Vehicle Info</p>"
	).queue(function() {
	  $('.invalid-vehicle').fadeOut(2000)
	})
      }
    })
  });

  $('.clockout-button').on('click', function() {
    $('.app-dash').hide();
    $('.app-home').show();
    $('.transit-vehicles-table').html("");
    $('.all-vehicles-table').html("")
  });

  $('.all-vehicles-table').on('click', '.pull-up-button button', function() {
    var vehicleId = $(this).parents('.parked-vehicle').attr('data-id')
    $.ajax({
      type: 'POST',
      url: 'http://mycarplease.herokuapp.com/api/v1/vehicles/' + vehicleId + '/pull_up.json',
      success: function(vehicle) {
	renderVehicle(vehicle)
      }
    })
  });


  $('.transit-vehicles-table').on('click', '.quote-button', function() {
    var quote = $(this).siblings().children('.quote-time').val()
    var vehicleId = $(this).parents('.quote-vehicle').attr('data-id')
    var ticket = $(this).siblings().first().children('h3').text().replace('#','')
    console.log(quote)
    $.ajax({
      type: 'POST',
      url: 'http://mycarplease.herokuapp.com/api/v1/vehicles/' + vehicleId + '/give_quote.json',
      data: { quote: quote,
	ticket: ticket
      },
      success: function(response) {
	renderTransitVehicle(response);
      } 
    })
  });

  $('.transit-vehicles-table').on('click', '.return-button', function() {
    var vehicleId = $(this).parents('.transit-vehicle').attr('data-id')
    $.ajax({
      type: 'POST',
      url: 'http://mycarplease.herokuapp.com/api/v1/vehicles/' + vehicleId + '/return.json',
      success: function(vehicle) {
	renderVehicle(vehicle)
      }
    })
  });
  
  pollData()

});

renderEmployeeName = function(data) {
  $('.employee-name').text(data["employee"]["first_name"])
};

renderShiftLocation = function(data) {
  $('.location-name').text(data["account"]["name"])
};

renderVehicle = function(vehicle) {
  if (vehicle["status"] == "parked") {
    if( $('.all-vehicles-table').children('[data-id=\"' + vehicle.id + '\"]').length == 0 ) {
      $('.all-vehicles-table').append(
	  "<tr class=\"parked-vehicle\" data-id=" 
	  + vehicle["id"] 
	  + "><td><h3>#" 
	  + vehicle["ticket_no"] 
	  + "</h3></td><td><h3>"
	  + vehicle["space"] 
	  + "</h3></td><td><h3>"
	  + vehicle["color"] 
	  + " "
	  + vehicle["style"] 
	  +"</h3></td><td class=\"pull-up-button\"><button>Pull Up</button></td></tr>"
	  )
  }
  } 
  else if (vehicle["status"] == "needs_quote") {
    $('.parked-vehicle[data-id=\"' + vehicle.id + '\"]').remove();
    if($('.transit-vehicles-table').children('[data-id=\"' + vehicle.id + '\"]').length == 0) {
      cordova.plugins.notification.local.schedule({
	id: 1,
	text: "You have a customer waiting for a quote.",
      });
      $('.transit-vehicles-table').prepend(
	  "<tr class=\"quote-vehicle vehicle\" data-id=" 
	  + vehicle["id"] 
	  + "><td><h3>#" 
	  + vehicle["ticket_no"] 
	  + "</h3></td><td><h3>"
	  + vehicle["space"] 
	  + "</h3></td><td><h3>"
	  + vehicle["color"] 
	  + " "
	  + vehicle["style"] 
	  +"</h3></td><td><input class=\"quote-time\" type=\"text\"></td><td class=\"quote-button\"><button>Quote</button></td></tr>"
	  )
  }
  }
  else if (vehicle["status"] == "transit") {
    $('.quote-vehicle[data-id=\"' + vehicle.id + '\"]').remove();
    if($('.transit-vehicles-table').children('[data-id=\"' + vehicle.id + '\"]').length == 0) {
      $('[data-id=\"' + vehicle.id + '\"]').remove();
      $('.transit-vehicles-table').append(
	  "<tr class=\"transit-vehicle vehicle\" data-id=" 
	  + vehicle["id"] 
	  + "><td><h3>#" 
	  + vehicle["ticket_no"] 
	  + "</h3></td><td><h3>"
	  + vehicle["space"] 
	  + "</h3></td><td><h3>"
	  + vehicle["color"] 
	  + " "
	  + vehicle["style"] 
	  + "</h3></td><td class=\"return-button\"><button>Return</button></td></tr>"
      )
    }
  }
  else if (vehicle["status"] == "returned") {
    $('.transit-vehicle[data-id=\"' + vehicle.id + '\"]').remove();
  }
};


function pollData() {
  setInterval(fetchVehicles, 5000)
}


function fetchVehicles() {
  if ($('.app-home').css('display') == 'none') {
    var newestVehicleID = parseInt($('.vehicle').last().attr('data-id'));
    var account         = $('.location-name').text();
    $.ajax({
      type: 'GET',
      url:  'http://mycarplease.herokuapp.com/api/v1/vehicles.json',
      data: { account: account },
      success: function(vehicles) {
	console.log(vehicles);
	var needsQuoteCount = vehicles.filter(function(vehicle) {
	  return vehicle["status"] =="needs_quote"
	})
	var inTransitCount = vehicles.filter(function(vehicle) {
	  return vehicle["status"] =="transit"
	})
	var parkedCount = vehicles.filter(function(vehicle) {
	  return vehicle["status"] =="parked"
	})

	$('.needs-quote-count').text(needsQuoteCount.length + " customers waiting for a quote.")
	$('.in-transit-count').text(inTransitCount.length + " vehicles in transit")
	$('.parked-vehicles').text(parkedCount.length + " vehicles parked")

	$.each(vehicles, function(index, vehicle) {
	  renderVehicle(vehicle)
	})
      },
    })
  }
}

function renderTransitVehicle(response) {
  var quote = response["quote"];
  var vehicle = response["vehicle"];
    $('.quote-vehicle[data-id=\"' + vehicle.id + '\"]').remove();
    if($('.transit-vehicles-table').children('[data-id=\"' + vehicle.id + '\"]').length == 0) {
      $('[data-id=\"' + vehicle.id + '\"]').remove();
      $('.transit-vehicles-table').append(
	  "<tr class=\"transit-vehicle vehicle\" data-id=" 
	  + vehicle["id"] 
	  + "><td><h3>#" 
	  + vehicle["ticket_no"] 
	  + "</h3></td><td><h3>"
	  + vehicle["space"] 
	  + "</h3></td><td><h3>"
	  + vehicle["color"] 
	  + " "
	  + vehicle["style"] 
	  + "</h3></td><td><div class=\"timer\" data-timer-id=\"" + vehicle.id + "\">"
	  + quote 
	  + ":00</div></td><td class=\"return-button\"><button>Return</button></td></tr>"
      )
      new Timer(vehicle.id);
    }
}

var Timer = function() {
  setInterval(function(arguments) {
    this.timer = ($('.transit-vehicles-table').children().children().children('[data-timer-id=\"' + arguments[0] + '\"]')).html();
    timer = this.timer.split(':');
    var minutes = parseInt(timer[0], 10);
    var seconds = parseInt(timer[1], 10);
    seconds -= 1;
    if (minutes < 0) return clearInterval(this.timer);
    if (minutes < 10 && minutes.length != 2) minutes = '0' + minutes;
    if (seconds < 0 && minutes != 0) {
      minutes -= 1;
      seconds = 59;
    }
    else if (seconds < 10 && length.seconds != 2) seconds = '0' + seconds;
      ($('.transit-vehicles-table').children().children().children('[data-timer-id=\"' + arguments[0] + '\"]')).html(minutes + ':' + seconds);
    if (minutes == 0 && seconds == 0)
    clearInterval(timer);
  }, 1000, arguments);
}
