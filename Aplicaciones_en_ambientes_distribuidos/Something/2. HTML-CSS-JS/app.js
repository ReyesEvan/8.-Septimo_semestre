var express = require('express');
var app = express();

app.use(express.static('public'));

app.get('/', function(request, response) {
  response.sendFile(__dirname + '/public/library.html');
});

app.get('/books', function(request, response) {
  response.redirect(301,'/');
});

app.listen(3000, function() {
  console.log("Running Express");  
});
