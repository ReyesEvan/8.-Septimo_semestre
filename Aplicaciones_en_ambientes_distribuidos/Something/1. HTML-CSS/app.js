var express = require('express');
var app = express();

app.use(express.static('public'));

app.get('/', function(request, response) {
  response.sendFile(__dirname + '/public/home.html');
});

app.get('/cities', function(request, response) {
  var cities = ['Caspiana', 'Indigo', 'Paradise'];
  response.send(cities);
});

app.get('/locations', function(request, response) {
  var cities = '<ul><li>Caspiana</li><li>Indigo</li><li>Paradise</li></ul>';
  response.redirect(301,'/cities');
});

app.listen(3000, function() {
  console.log("Running Express");  
});
