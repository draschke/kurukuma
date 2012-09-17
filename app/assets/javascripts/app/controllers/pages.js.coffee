$ = jQuery

class App.Pages extends Spine.Controller
  className: 'list'
    
  elements:
    '.items': 'items'
    'footer': 'footer'
    
  constructor: ->
    super
    
    @html JST['app/views/pages/list']()
    
    App.Page.bind 'fetch', =>
      @el.addClass('loading')
    
    App.Page.bind 'refresh', =>
      @el.removeClass('loading')
      @render(arguments...)
	
    App.Page.fetch()
    
  render: (items = []) =>
    for item in items
      @items.append JST['app/views/pages/item'](item)
      

