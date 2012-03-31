jQuery ->
  $('a.submit-new-group').click ->
    $('#new-group-modal form')[0].reset()
    $('#new-group-modal').modal()
