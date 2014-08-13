# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $(window).scroll ->
    url = $('.pagination .next_page').attr('href')
    if url && $(window).scrollTop() > $(document).height() - $(window).height() - 5
      $('.pagination').html("<img class='mid' src='/assets/ajax-loader.gif' alt='Loading...' title='Loading...' />")
      $.getScript(url)
  
