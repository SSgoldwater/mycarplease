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
      }
    })
  });
  
  $('.new-car').on('click', function() {
    ticketNo = $('.ticket_no').val();
    space = $('.space').val();
    account = $('.location-name').text();

    var vehicle_params = {
      ticketNo: ticketNo,
      space: space,
      account: account,
    };
    
    console.log(vehicle_params);
    $.ajax({
      type: 'POST',
      url: 'http://mycarplease.herokuapp.com/api/v1/vehicles.json',
      data: vehicle_params,
      success: function(vehicle) {
        renderVehicle(vehicle)
      }
    })

  });

  $('.clockout-button').on('click', function() {
    $('.app-dash').hide();
    $('.app-home').show();
  });

  /*pollData()*/

});

renderEmployeeName = function(data) {
  $('.employee-name').text(data["employee"]["first_name"])
};

renderShiftLocation = function(data) {
  $('.location-name').text(data["account"]["name"])
};

renderVehicle = function(vehicle) {
  if (vehicle["status"] == "parked") {
    $('.all-vehicles-table').append(
      "<tr class=\"vehicle\" data-id=" 
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
  else if (vehicle["status"] == "transit") {
    $('.transit-vehicles-table').append(
      "<tr class=\"vehicle\" data-id=" 
      + vehicle["id"] 
      + "><td><h3>#" 
      + vehicle["ticket_no"] 
      + "</h3></td><td><h3>"
      + vehicle["space"] 
      + "</h3></td><td><h3>"
      + vehicle["color"] 
      + " "
      + vehicle["style"] 
      +"</h3></td><td class=\"return-button\"><button>Return</button></td></tr>"
    )
  }
};

/*
function pollData() {
  setInterval(fetchVehicles, 5000)
}
*/

function fetchVehicles() {
  var newestVehicleID = parseInt($('.vehicle').last().attr('data-id'));
  var account         = $('.location-name').text();
  $.ajax({
    type: 'GET',
    url:  'http://mycarplease.herokuapp.com/api/v1/vehicles.json',
    data: { account: account },
    success: function(vehicles) {
      console.log(vehicles);
      $('.vehicle-count').children('h3').text(vehicles.length + " vehicles total")
      $.each(vehicles, function(index, vehicle) {
	if(isNaN(newestVehicleID) || vehicle.id > newestVehicleID) {
	  renderVehicle(vehicle)
	}
      })
    },
  })
}
