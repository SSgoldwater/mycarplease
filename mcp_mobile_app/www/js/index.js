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
      data: { location: $('.employee-location-selector').children(':checked').text(), 
              email:    $('.clock-in-field.email').val(),
              password: $('.clock-in-field.password').val()
      }, 

      success: function(data) {
        $('.app-home').hide(),	  
        $('.app-dash').show(),
        renderEmployeeName(data),
      	renderShiftLocation(data),
        renderVehicles(data)
      }
    })
  });

  $('.clockout-button').on('click', function() {
    $('.app-dash').hide();
    $('.app-home').show();
  });
});



renderEmployeeName = function(data) {
  $('.employee-name').text(data["employee"]["first_name"])
};

renderShiftLocation = function(data) {
  $('.location-name').text(data["location"]["name"])
};

renderVehicles = function(data) {
  $('.vehicle-count').children('h3').text(data["vehicles"].length + " vehicles total")
  console.log(data);
  $.each(data["vehicles"], function(vehicle, data) {
    console.log(vehicle);
    renderVehicle(data);
  })
};

renderVehicle = function(vehicle) {
  $('.all-vehicles-table').append(
    "<tr data-id=" 
    + vehicle["id"] 
    + "><td><h3>#" 
    + vehicle["ticket_no"] 
    + "</h3></td><td><h3>"
    + vehicle["space"] 
    + "</h3></td><td><h3>"
    + vehicle["color"] 
    + " "
    + vehicle["class"] 
    +"</h3></td><td class=\"pull-up-button\"><button>Pull Up</button></td></tr>"
    )
}
