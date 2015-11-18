$(document).ready(function() {
  $( ".new_customer" ).submit(function( event ) {
    if ($('.phone').val().length != 10) {
      alert( "Mobile phone number must be 10 digits" );
      event.preventDefault();
    }
  })
});
