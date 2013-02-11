jQuery ->
  Page =
    init: ->
      $('.chosen').chosen()
      @show_public_submit_form()
      @toggle_delete_button()
      @arrange_layout()
      @endless_page()
    
    show_public_submit_form: ->
      $('a.submit-new-group').click ->
        $('#new-group-modal form')[0].reset()
        $('#new-group-modal').modal()

    toggle_delete_button: ->
      $('#groups').on 'hover', '.group-card', ->
        $(@).find('.action').toggle()

    arrange_layout: ->
      $container = $('.thumbnails')
      $container.imagesLoaded ->
        $container.masonry
          itemSelector : '.span4'

    endless_page: ->
      $container = $('.thumbnails')
      $container.infinitescroll
        navSelector: ".pagination"
        nextSelector: ".pagination .next a"
        itemSelector: ".span4"
        animate: true
        loading:
          finishedMsg: "<em>No more groups.</em>"
          img: "http://i.imgur.com/6RMhx.gif"
          msgText: ""
      , (new_elements) ->
        $new_elements = $(new_elements).css(opacity: 0)
        $new_elements.imagesLoaded ->
          $new_elements.animate opacity: 1
          $container.masonry "appended", $new_elements, true

  Page.init()
