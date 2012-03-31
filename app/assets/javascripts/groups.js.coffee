jQuery ->
  $('div.group-card').hover ->
    $(@).find('a.delete-group').toggle()
