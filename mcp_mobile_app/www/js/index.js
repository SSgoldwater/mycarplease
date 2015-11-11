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
	console.log(data["first_name"])
      }
    })
  })
});

renderEmployeeName = function(data) {
  $('.employee-name').text(data["first_name"])
};
