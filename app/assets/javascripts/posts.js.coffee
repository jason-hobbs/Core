# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
@ReplyPoller =
  poll: ->
    setTimeout @request, 5000

  request: ->
    $.get($('#replies').data('url'))


jQuery ->
  if $('#replies').length > 0
    ReplyPoller.poll()
