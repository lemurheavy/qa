//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require gollum
//= require notifications
//= require turbolinks
//= require_self

$ ->
  # Header elements
  $("#flag-count").tooltip(
    placement: 'bottom'
  )

  # Intialize Gollum
  $.GollumEditor()

  $(".flag-link").live "ajax:success", (xhr, data, status) ->
    $(data).appendTo($("body")).modal(backdrop: true, show: true).bind('hidden', ->
      $(this).remove()
    ).find(".btn.secondary").click( (e) ->
      $(".modal").modal('hide')
      e.preventDefault()
    )

  $(".comment-link").live "ajax:success", (xhr, data, status) ->
    container = $(this).parent()
    $(this).remove()
    $(data).appendTo(container)

  $("#new_flag").live "ajax:success", (xhr, data, status) ->
    if data.status is "ok"
      $(".modal").modal('hide')
      pop = $(".flag-link").attr("title", "Thanks").attr("data-content", data.message).qaPopover()
    else
      $(".modal").modal('hide')
      pop = $(".flag-link").attr("title", "Whoops").attr("data-content", data.errors.flaggable[0]).qaPopover()

  $("#new_comment").live "ajax:success", (xhr, data, status) ->
    container = $(this).parent()
    $(this).remove()
    $(data).appendTo(container)

  # /***************/
  $(".vote-form").live "ajax:success", (xhr, data, status) ->
    if $.isEmptyObject(data.errors)
      if data.vote.value is 1
       active = $(this).find('.upvote .vote-active').removeClass('vote-active');
       $(this).find('.upvote .vote-inactive').removeClass('vote-inactive').addClass('vote-active');
       active.addClass('vote-inactive');
      else
       active = $(this).find('.downvote .vote-active').removeClass('vote-active');
       $(this).find('.downvote .vote-inactive').removeClass('vote-inactive').addClass('vote-active');
       active.addClass('vote-inactive'); 
    else
      # $(this).popover(data.errors.voteable[0]);

$.fn.qaPopover = (options) ->
  pop = this.popover(
    trigger: 'manual'
  ).popover('show').data('popover').$tip
  pop.click =>
    this.popover('hide')
  this

$.fn.fadeOutAndRemove = (speed) ->
  if speed == undefined
    speed = 'fast'
  return this.each ->
    $(this).fadeOut speed, ->
      $(this).remove();