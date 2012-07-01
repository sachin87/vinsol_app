jQuery ->
  if $('.pagination').length
    $(window).scroll ->
      url = $('.pagination .current').next().find("a").attr('href')
      if url && $(window).scrollTop() > $(document).height() - $(window).height() - 50
        $('.pagination').text("Fetching more products...")
        $.getScript(url)
    $(window).scroll()