progress_bar_initial_animate = ->
  $('.progress-bar').css('width', 25 + '%')
  $('#a').focus()

$ (->
  progress_bar_initial_animate()
)
