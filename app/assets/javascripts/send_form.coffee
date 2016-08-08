window.send_form =(type, a, b, c, url, authorization) ->
  type = $('input[name="type"]:checked', '#radio').val()
  a = $('#a').val()
  b = $('#b').val()
  c = $('#c').val()
  url = $('#url').val()
  authorization = $('#authorization').val()
  all_parms = { 'type': type, 'a': a, 'b': b, 'c': c }
  $.ajax url,
    headers: { 'Authorization': authorization },
    type: 'POST',
    dataType: 'json',
    contentType: 'application/json; charset=utf-8',
    data: JSON.stringify(all_parms),
    success: (result) ->
      on_success(result)
    error: (jqXHR, textStatus, errorThrown) ->
      on_error(jqXHR)
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
