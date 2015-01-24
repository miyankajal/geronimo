jQuery -> 
if $('#infinite-scrolling').size() > 0
  $(window).on 'scroll', -> 
  more_ideas_url = $('.pagination .next_page a').attr('href')
  if more_ideas_url && $(window).scrollTop() > $(document).height() - $(window).height() - 60
    $('.pagination').html('<img src="/assets/ajax-loader.gif" alt="Loading..." title="Loading..." />')
    $.getScript more_ideas_url
  return
return