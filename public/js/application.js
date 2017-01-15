$(document).ready(function() {
  console.log('ready');
  $(".js").removeClass('hidden');
  $(".no-js").addClass('hidden');
  $("#new-question-request-wrapper").removeClass('hidden')
  $("#new-question-form-holder").hide();

  $(".font-creepster").on("click", function(e){
    e.preventDefault();
    $(this).toggleClass('spooky');


  })

  $("#nav-holder").on("click", "#login-link", function(e){
    e.preventDefault();
    $(this).addClass('hidden')
    $("#login-form-wrapper").removeClass('hidden')
  });

  $("#nav-holder").on("click", "#logout-link", function(e){
    e.preventDefault();
    $(this).closest("form").trigger("submit");
  });


  $("#new-question-request-wrapper").on("click", "#question-button", function(e){
    e.preventDefault();
    var $form = $(this)
    var url = $form.attr('action');
    var method = $form.attr('method');
    $.ajax({
      url: url,
      type: method
    })

    .done(function(response) {
      $("#new-question-form-holder").show();
      $("#new-question-form-holder").html(response);
      $('#question-button').hide();
    })
    .fail(function() {
      $form.trigger("submit");
    });
  });

  $('#new-question-form-holder').on("submit", "#new-question-input", function(e){
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
      $('#new-question-form-wrapper').remove();
    })
    .fail(function() {
      console.log("error");
    })
    .always(function() {
      console.log("complete");
    });
  });

  $(".new-comment-form-holder").on("click", "a", function(e){
    e.preventDefault();
    var $form = $(this.closest("form"));
    var url = $form.attr('action');
    var method = $form.attr('method');

    $.ajax({
      url: url,
      type: method,
    })
    .done(function(response) {
      $form.addClass('hidden');
      $(".new-comment-form-holder").html(response);
    })
    .fail(function() {
      $form.trigger("submit");
    });
  });

  $(".new-comment-form-holder").on("click", ".submit-comment-button", function(e){
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
      $form.closest(".comments-container").find("li").last().append(response)
    })
    .fail(function() {
      $form.trigger("submit");
    });
  });

  $(".tab-holder").on("click", ".sort-tab", function(e){
    e.preventDefault();
    $('.active').removeClass('active').addClass('tab-header');
    $(this).removeClass('tab-header').addClass('active');
    url = $(this).attr('href');

    $.ajax({
      url: url,
      type: 'get'
    })
    .done(function(response) {
      $(".question-container").replaceWith($(response).find(".question-container"));
      $(".current-sort-type").replaceWith($(response).find(".current-sort-type"));
    });
  });

});





