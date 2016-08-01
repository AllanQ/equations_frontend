next_field = ->
  $('#inputform').on('keydown', 'input', (e)->
    if e.which == 13
      index = parseFloat($(@).attr('dataindex'))
      value = $(@).val()
      unless value == null || value == ''
        $('[dataindex="' + (index + 1).toString() + '"]').focus()
  )

$ (->
  next_field()
)
