# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
@ReplyPoller =
  poll: ->
    setTimeout @request, 10000

  request: ->
    $.get($('#replies').data('url'), after: $('.reply').last().data('id'))


jQuery ->
  if $('#replies').length > 0
    ReplyPoller.poll()
