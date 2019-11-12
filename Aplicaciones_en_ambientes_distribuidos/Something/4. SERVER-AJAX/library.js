
/*-----------------------------------------------------------------------------
 * controller section
 *----------------------------------------------------------------------------*/

var express = require('express');
var app = express();
app.use('/', express.static(__dirname + '/public'));

var bodyParser = require('body-parser')
app.use(bodyParser.urlencoded({extended: true}));
app.use(bodyParser.json());

app.get('/', function(request, response) {
    response.redirect(301,'/books/list');
});

app.get('/books/list', function(request, response) {
    response.send( html_page(list()) );
});

app.get('/books/show', function(request, response) {
    response.send( html_page(showBook(request.query.id)) );
});

app.get('/books/show_subject', function(request, response) {
    response.send( html_page(showSubject(request.query.id)) );
});

app.route('/books/update')

   .get(function(request, response) {
        var id = request.query.id;
        
        response.send({ title: LIBRARY.getBook(id).getTitle(),
                        price: LIBRARY.getBook(id).getPrice(),
                        subject: LIBRARY.getSubjectIndex(LIBRARY.getBook(id).getSubject()),
                        description: LIBRARY.getBook(id).getDescription() });
    })

   .put(function(request, response) {
        response.send( update(request) );
    });

app.delete('/books/delete', function(request, response) {
    LIBRARY.remove( LIBRARY.getBook(request.query.id) );
    response.send( listBooks() );
});

app.listen(8080, function() { console.log("Running Express"); });

/*-----------------------------------------------------------------------------
 * model section
 *----------------------------------------------------------------------------*/

var LIBRARY = (function() {
    var box = {};
    var subjects = ['Physics', 'Mathematics', 'Chemistry', 'Psychology', 'Geography'];
    
    return {
        getSubjects: function() { return subjects; },
        getSubjectIndex: function( s ) { return subjects.indexOf(s); },
        getBook: function( i ) { return box[i]; },
        
        getPosition: function( id ) {
            var keys = Object.keys(box);
            
            for(var k = 0; k < keys.length; k++) {
                if(keys[k] === id) {
                   return { index: k, title: box[keys[k]].getTitle() };
                }
            }
            throw "INTERNAL ERROR: Book " + id + " does not exist!";
        },
        
        getBooks: function() {
            var list = [];
            var keys = Object.keys(box);
            
            for(var k = 0; k < keys.length; k++) {
                if(!isNaN( keys[k] )) { list.push(box[ keys[k] ]); }
            }
            return list;
        },
        
        add: function( b ) {
            if(box[b.getTitle()] === undefined) {
               box[b.getId()] = b;
               box[b.getTitle()] = b;
            } else {
               throw "This title already exists!";
            }
        },
               
        update: function( n, b ) { // si el título fue actualizado, actualiza "box"
            if(box[n] === undefined) {
               delete box[b.getTitle()];
               box[n] = b;
            }
        },
        
        remove: function( b ) {
            delete box[b.getId()];
            delete box[b.getTitle()];
        },
               
               test: function() { return box;}
    }
})();

var BOOK = (function(t, p, s, d) {
    BOOK.counter = (BOOK.counter || 1);
    var id = BOOK.counter;
    
    var title;
    var price;
    var subject;
    var description;
    var created_at;
    
    function initialize(t, p, s, d) {
        title = t;
        price = parseFloat(p);
        subject = LIBRARY.getSubjects().includes(s) ? s : null;
        description = d;
        created_at = new Date();
        if(isNaN(price)) { throw "Invalid price!"; }
        if(!title || title.length === 0) { throw "Invalid title!"; }
    }
    
    initialize(t, p, s, d);
    BOOK.counter ++; // sólo se incrementa si la inicialización tiene éxito
    
    return {
        getId: function() { return id; },
        getTitle: function() { return title; },
        getPrice: function() { return price; },
        getSubject: function() { return subject; },
        getDescription: function() { return description; },
        getCreatedAt: function() { return created_at; },
        updateBook: function(t, p, s, d) { LIBRARY.update(t,this); initialize(t, p, s, d); }
    }
});

/*-----------------------------------------------------------------------------
 * view section
 *----------------------------------------------------------------------------*/

function html_page( content )
{
    var HTML_expr = "<!DOCTYPE html><html><head>";
    
    HTML_expr += "<meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1'/>";
    HTML_expr += "<meta http-equiv='Content-Language' content='en-us'/>";
    HTML_expr += "<title>Library Info System</title>";
    HTML_expr += "<link type='text/css' rel='stylesheet' href='/library.css'>";
    HTML_expr += "<script src='/library.js'></script>";
    HTML_expr += "<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>";
    HTML_expr += "</head><body id='library' onLoad='registerEvents()'>";
    HTML_expr += "<div id='container'><div id='header'><h1>Library Info System</h1>";
    HTML_expr += "<h3>Implemented using JavaScript and Node</h3></div><div id='content'>";
    HTML_expr += content + "</div><div id='sidebar'></div></div></body></html>";
    
    return HTML_expr;
}

function list()
{
    var HTML_expr = "<ul id='subjects'>";
    
    for(var i = 0; i < LIBRARY.getSubjects().length; i++) {
        HTML_expr += "<li><a href='/books/show_subject?id=" + i + "'>";
        HTML_expr += LIBRARY.getSubjects()[i] + "</a></li>";
    }
    
    HTML_expr += "</ul><div id='list'>" + listBooks();
    HTML_expr += "</div><br/><h1>Book description</h1>";
    HTML_expr += "<form><p><label for='book_title'>Title</label>:";
    HTML_expr += "<input type='text' name='book[title]' id='books_title'/></p>";
    HTML_expr += "<p><label for='book_price'>Price</label>:";
    HTML_expr += "<input type='text' name='book[price]' id='books_price'/></p>";
    HTML_expr += "<p><label for='book_subject'>Subject</label>:";
    HTML_expr += "<select name='book[subject]' id='books_subject'>";
    HTML_expr += "<option value=''>Please select</option>";
    
    for(var i = 0; i < LIBRARY.getSubjects().length; i++) {
        HTML_expr += "<option value='" + i + "'>" + LIBRARY.getSubjects()[i] + "</option>";
    }
    
    HTML_expr += "</select></p>";
    HTML_expr += "<p><label for='book_description'>Description</label><br/>";
    HTML_expr += "<textarea name='book[description]' id='books_description'></textarea></p>";
    HTML_expr += "<input type='button' value='Clear'/>";
    HTML_expr += "<input type='submit' value='Save description'/></form>";
    
    return HTML_expr;
}

function listBooks()
{
    var HTML_expr = "<ul id='books'>";
    var books = LIBRARY.getBooks();
    
    for(var i=0; i < books.length; i++) {
        HTML_expr += listBook(books[i]);
    }
    return HTML_expr + "</ul>";
}

function listBook( b )
{
    var HTML_expr = "<li><a href='/books/show?id=" + b.getId() + "'>" + b.getTitle() + "</a>";
    
    HTML_expr += " <u class='button' onclick='edit(" + b.getId() + ")'><b>Edit</b></u>";
    HTML_expr += " <u class='button' onclick='drop(" + b.getId() + ")'><b>Delete</b></u></li>";
    
    return HTML_expr;
}

function showBook( id )
{
    var HTML_expr = "<h1>" + LIBRARY.getBook(id).getTitle() + "</h1>";
    
    HTML_expr += "<p><strong>Price: </strong>$";
    HTML_expr += LIBRARY.getBook(id).getPrice() + "<br/>";
    HTML_expr += "<strong>Subject: </strong><a href='/books/show_subject?id=";
    HTML_expr += LIBRARY.getSubjectIndex(LIBRARY.getBook(id).getSubject()) + "'>";
    HTML_expr += LIBRARY.getBook(id).getSubject() + "</a><br/>";
    HTML_expr += "<strong>Created Date: </strong>";
    HTML_expr += LIBRARY.getBook(id).getCreatedAt() + "<br/></p>";
    HTML_expr += "<p>" + LIBRARY.getBook(id).getDescription() + "</p><hr/>";
    
    return HTML_expr + "<a href='/books/list'>Back</a>";
}

function showSubject( s )
{
    var HTML_expr = "<h1>" + LIBRARY.getSubjects()[s] + "</h1><ul>";
    var books = LIBRARY.getBooks();
    
    for(var i=0; i < books.length; i++) {
        if(books[i].getSubject() == LIBRARY.getSubjects()[s]) {
            HTML_expr += "<li><a href='/books/show?id=" + books[i].getId() + "'>";
            HTML_expr += books[i].getTitle() + "</a></li>";
        }
    }
    return HTML_expr + "</ul><a href='/books/list'>Back</a>";
}

function update( request )
{
    var t = request.body.book.title;
    var p = request.body.book.price;
    var s = LIBRARY.getSubjects()[request.body.book.subject];
    var d = request.body.book.description;
    
    if( request.query.id === "undefined" ) {
        LIBRARY.add(BOOK(t, p, s, d));
        return listBook(LIBRARY.getBook(t));
    } else {
        LIBRARY.getBook(request.query.id).updateBook(t, p, s, d);
        return LIBRARY.getPosition(request.query.id);
    }
}
