class App.Message extends Spine.Model
  @configure 'Message', '_id', 'uri', 'text', 'twitter'
  @extend Spine.Model.Ajax
  
