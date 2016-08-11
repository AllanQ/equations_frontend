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
      compute_signature(type, a, b, c)
  else
    $('#c-group').removeClass('hidden')
    total = 30*(count_a + count_b + count_c) + 10*count_res
    if total >= 90
      display_quadratic_equation(a, b, c)
      compute_signature(type, a, b, c)
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
  multiplier_first(a)
  if b == '0' || b == '-0'
    $('.free-term-block').addClass('hidden')
  else
    free_term(b)
    $('.free-term-block').removeClass('hidden')

display_quadratic_equation =(a, b, c) ->
  $('#quadratic_equation').removeClass('hidden')
  multiplier_first(a)
  if b == '0' || b == '-0'
    $('.multiply2-block').addClass('hidden')
  else
    multiplier_second(b)
    $('.multiply2-block').removeClass('hidden')
  if c == '0' || c == '-0'
    $('.free-term-block').addClass('hidden')
  else
    free_term(c)
    $('.free-term-block').removeClass('hidden')

multiplier_first =(param) ->
  arr = multiplier(param, true)
  $('.mul1-sign').text(arr[0])
  $('.mul1').text(arr[1])
  $('.mul1-multiply').text(arr[2])

multiplier_second =(param) ->
  arr = multiplier(param, false)
  $('.mul2-sign').text(arr[0])
  $('.mul2').text(arr[1])
  $('.mul2-multiply').text(arr[2])

multiplier =(param, first) ->
  plus = if first then '' else '+'
  if param < 0
    if param == '-1'
      sign = '-'
      par_var = ''
      multiply = ''
    else
      sign = '-'
      par_var = -param
      multiply = '*'
  else
    if param == '1'
      sign = plus
      par_var = ''
      multiply = ''
    else
      sign = plus
      par_var = param
      multiply = '*'
  [sign, par_var, multiply]
  
free_term =(param) ->
  if param < 0
    $('.free-term-sign').text('-')
    $('.free-term').text(-param)
  else
    $('.free-term-sign').text('+')
    $('.free-term').text(param)

compute_signature =(type, a, b, c = null) ->
  $.ajax("/equations/auth", {
    type: 'GET',
    data: { eq_params: { 'type': type, 'a': a, 'b': b, 'c': c } }
  })

$ (->
  calculate_progress()
  radio_click()
  fields_change()
)
