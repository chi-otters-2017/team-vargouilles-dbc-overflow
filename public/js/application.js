$(document).ready(function() {
  $("#question-button").on("submit", function(e){
    e.preventDefault();
    $("#question-button").addClass('hidden');

    var url = $(this).attr('action');
    var method = $(this).attr('method');

    $.ajax({
      url: url,
      type: method
    })
    .done(function(response) {
      $(".container").append(response);
    });
    // .always(function() {
    // });
  });

  $("#index-box").on("submit", "#new-question-input", function(e){
    e.preventDefault();

    var $form = $("#new-question-input");
    var url = $form.attr('action');
    var method = $form.attr('method');
    var data = $form.serialize();

    $(this).trigger('reset');
    $("#new-question-form-wrapper").addClass('hidden');
    $("#question-button").removeClass('hidden');

    $.ajax({
      url: url,
      type: method,
      data: data
    })
    .done(function(response) {
      $(".question-container").append(response);
    });
    // .fail(function() {
    //   console.log("error");
    // })
   // .always(function() {
   //    $("#new-question-input").reset();
   //  });
  });
});
