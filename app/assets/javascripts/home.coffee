radio_click = ->
  $('#radio').change ->
    $('#a').focus()
    calculate_progress()

fields_change = ->
  $('.input').keyup ->
    call_validate_and_calculate(@)
  $('.input').bind('keyup mouseup', ->
    call_validate_and_calculate(@)
  )
  $('.input').bind('keydown mouseup', ->
    call_validate_and_calculate(@)
  )

call_validate_and_calculate =(field) ->
  validate_input(field)
  calculate_progress()

validate_input =(field) ->
  $(field).parent().removeClass('has-error')
  $(field).next().addClass('hidden')
  value = $(field).val()
  if !value.match(/^(-?[1-9]+\d*|-?0)$/) ||
  ( $(field).attr('name') == 'a' && +value == 0 )
    $(field).parent().addClass('has-error')
    $(field).next().removeClass('hidden')
    $(field).next().children().text('Input with error')

calculate_progress = ->
  hide_all()
  a = $('#a').val()
  b = $('#b').val()
  c = $('#c').val()
  count_a = if bool_correct_input($('#a')) then 1 else 0
  count_b = if bool_correct_input($('#b')) then 1 else 0
  count_c = if bool_correct_input($('#c')) then 1 else 0
  count_res = if $('#result').text() == '' then 0 else 1
  type = $('input[name="type"]:checked', '#radio').val()
  if type == 'linear'
    $('#c-group').addClass('hidden')
    total = 45*(count_a + count_b) + 10*count_res
    if total >= 90
      display_liner_equation(a, b)
      send_form(type, a, b)
  else
    $('#c-group').removeClass('hidden')
    total = 30*(count_a + count_b + count_c) + 10*count_res
    if total >= 90
      display_quadratic_equation(a, b, c)
      send_form(type, a, b, c)
  $('.progress').removeClass('hidden')
  $('.progress-bar').css('width', total + '%')

hide_all = ->
  $('#equation').addClass('hidden')
  $('#quadratic_equation').addClass('hidden')
  $('#liner_equation').addClass('hidden')
  $('#result').addClass('hidden')
  $('#error').addClass('hidden')

bool_correct_input =(field) ->
  val = field.val()
  !(val == null || val == '' || field.parent().hasClass('has-error'))

display_liner_equation =(a, b) ->
  $('#liner_equation').removeClass('hidden')
  $('#li-a').text(a)
  $('#li-b').text(b)
  
display_quadratic_equation =(a, b, c) ->
  $('#quadratic_equation').removeClass('hidden')
  $('#quadr-a').text(a)
  $('#quadr-b').text(b)
  $('#quadr-c').text(c)  
  
send_form =(type, a, b, c = null) ->
  $.ajax('http://localhost:4567', {
    type: 'POST',
    dataType: 'json',
    contentType: 'application/json; charset=utf-8',
    data: JSON.stringify({ 'type': type, 'a': a, 'b': b, 'c': c }),
    success: (result) ->
      on_success(result)
    error: (jqXHR, textStatus, errorThrown) ->
      on_error(jqXHR)
  })
  $('#equation').removeClass('hidden')

on_success =(result) ->
  x1 = result.x1
  if x1.match(/error/i)
    show_error(x1)
  else
    x2 = result.x2
    if x2 == '' || x2 == null
      if x1.match(/^-?\d+.?\d*$/)
        if isStrInt(x1) then x1 = parseInt(x1)
        res = "x = #{x1}"
      else
        res = x1
    else
      if isStrInt(x1) then x1 = parseInt(x1)
      if isStrInt(x2) then x2 = parseInt(x2)
      res = "x1 = #{x1},<br>x2 = #{x2}"
    $('#result').removeClass('hidden')
    $('#result').html(res)
    $('.progress').addClass('hidden')

isStrInt =(str) ->
  parseFloat(str) % 1 == 0

on_error =(jqXHR) ->
  if jqXHR.status == 500
    err_text = 'Sorry. Service out of work. Internal Server Error. Try later'
  else
    err_text = 'Sorry. Error'
  show_error(err_text)

show_error =(text) ->
  $('#error').removeClass('hidden')
  $('#error-message').text(text)
  $('.progress').addClass('hidden')

$ (->
  calculate_progress()
  radio_click()
  fields_change()
)
