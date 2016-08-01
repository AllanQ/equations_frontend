radio_click = ->
  $('#radio').change ->
    console.log($('input[name="type"]:checked', '#radio').val())
    if $('input[name="type"]:checked', '#radio').val() == 'linear'
      $('.progress-bar').css('width', 25 + '%')
    else
      $('.progress-bar').css('width', 20 + '%')
    $('#a').focus()  

$ (->
  radio_click()
)
