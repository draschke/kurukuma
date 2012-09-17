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
      @el.removeClass('loading')
      @render(arguments...)
	
    App.Message.fetch()
    
  render: (items = []) =>
    for item in items
      @items.append JST['app/views/messages/item'](item)
      

