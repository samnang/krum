jQuery ->
  $('.chosen').chosen()

  $container = $('.thumbnails')
  $container.imagesLoaded ->
    $container.masonry
      itemSelector : '.span4'

  $('a.submit-new-group').click ->
    $('#new-group-modal form')[0].reset()
    $('#new-group-modal').modal()

  $('#groups').on 'hover', '.group-card', ->
    $(@).find('a.delete-group').toggle()
