$(document).ready(function() {
  $("#outer").hide();
  $("#index-box").on("click", "#question-button", function(e){
    e.preventDefault();
    var url = $(this).attr('action');
    var method = $(this).attr('method');
    $.ajax({
      url: url,
      type: method
    })

    .done(function(response) {
      $("#outer").show();
      $("#outer").html(response);
      $('#question-button').hide();
    });
  });

  $('#index-box').on("submit", "#new-question-input", function(e){
    e.preventDefault();
    var url = $(this).attr('action');
    var method = $(this).attr('method');
    var data = $(this).serialize();

    $.ajax({
      url: url,
      type: method,
      data: data
    })
    .done(function(response) {
      console.log("success");

      $(".question-container").append(response);
      $('#question-button').show();
      $('#inner').remove();
    })
    .fail(function() {
      console.log("error");
    })
    .always(function() {
      console.log("complete");
    });
  });
});





