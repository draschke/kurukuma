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
