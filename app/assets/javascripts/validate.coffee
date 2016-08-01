validate_input = ->
  $('.input').keyup ->
    $(@).parent().removeClass('has-error')
    $(@).next().addClass('hidden')
    unless @value.match(/^-?\d+$/)
      $(@).parent().addClass('has-error')
      $(@).next().removeClass('hidden')
      $(@).next().children().text('Input with error')
$ (->
  validate_input()
)
