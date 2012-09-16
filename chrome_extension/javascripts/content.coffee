annot = $(document.body).annotator()
#annot.annotator('addPlugin', 'Filter')
annot.annotator('addPlugin', 'Tags')
annot.annotator('addPlugin', 'Store', {
  prefix: 'http://kurukuma.herokuapp.com/page',
  annotationData: {'uri': document.URL},
  loadFromSearch: {'limit': 20,'uri': document.URL}
});
annot.annotator('addPlugin', 'Twitter', {
  prefix: 'http://kurukuma.herokuapp.com/'
})

chrome.extension.onRequest.addListener((request, sender, sendResponse)->
  window.kurukuma_user_info = request.user_info
)
chrome.extension.sendRequest({name: "kurukuma"})
