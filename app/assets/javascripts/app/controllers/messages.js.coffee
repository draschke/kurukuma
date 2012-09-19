$ = jQuery

class App.Messages extends Spine.Controller
  className: 'list'
    
  elements:
    '.items': 'items'
    'footer': 'footer'
    
  constructor: ->
    super
    
    @html JST['app/views/messages/list']()
    
    App.Message.bind 'fetch', =>
      @el.addClass('loading')
    
    App.Message.bind 'refresh', =>
      console.log(11)
      @el.removeClass('loading')
      @render(arguments...)
      
    App.Message.fetch()
    App.Message.refresh()
    
  render: (items = []) =>
    for item in items
      @items.append JST['app/views/messages/item'](item)
      

