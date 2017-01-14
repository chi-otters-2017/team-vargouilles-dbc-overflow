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

  $("#new-comment-form-wrapper").on("click", "#reveal-comment-button", function(e){
    e.preventDefault();
    var $form = $(this.closest("form"));
    var url = $form.attr('action');
    var method = $form.attr('method');
    // debugger

    $.ajax({
      url: url,
      type: method,
    })
    .done(function(response) {
      $form.addClass('hidden');
      // debugger
      $("#new-comment-form-wrapper").html(response);
      console.log("success");
    });
    // .fail(function() {
    //   console.log("error");
    // })
    // .always(function() {
    //   console.log("complete");
    // });
  });

  $("#new-comment-form-wrapper").on("click", "#submit-comment-button", function(e){
    e.preventDefault();
    var $form = $(this.closest("form"));
    var url = $form.attr('action');
    var method = $form.attr('method');
    var comment_data = $form.serialize();

    $.ajax({
      url: url,
      type: method,
      data: comment_data,
    })
    .done(function(response) {
      console.log("success");
    })
    .fail(function() {
      console.log("error");
    })
    .always(function() {
      ;
    });

  })
});





