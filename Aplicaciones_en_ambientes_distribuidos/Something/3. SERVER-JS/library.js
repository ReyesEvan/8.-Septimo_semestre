
/*-----------------------------------------------------------------------------
 * servidor web
 *----------------------------------------------------------------------------*/

var express = require('express');
var app = express();
var bodyParser = require('body-parser')

app.use(bodyParser.urlencoded({extended: true}));
app.use(bodyParser.json());


app.get('/', function(request, response) {
    response.redirect(301,'/books/list');
});

app.get('/library.css', function(request, response) {
    response.sendFile(__dirname + '/public/library.css');
});


app.route('/books/new')

   .get(function(request, response) {
        response.send( html_page(newBook()) );
    })

   .post(function(request, response) {
    
        LIBRARY.addBook( BOOK( request.body.books.title,
                               request.body.books.price,
                               LIBRARY.getSubjects()[request.body.books.subject],
                               request.body.books.description )
                       );
    
        response.redirect(301,'/books/list');
    });


app.get('/books/list', function(request, response) {
    response.send( html_page(listBooks()) );
});

app.get('/books/show', function(request, response) {
    response.send( html_page(showBook(request.query.id)) );
});


app.route('/books/edit')

   .get(function(request, response) {
        response.send( html_page(edit(request.query.id)) );
    })

   .post(function(request, response) {
    
        LIBRARY.getBooks()[ request.query.id ] =
    
                   BOOK( request.body.book.title,
                         request.body.book.price,
                         LIBRARY.getSubjects()[request.body.book.subject],
                         request.body.book.description );
    
        response.redirect(301,'/books/list');
    });


app.route('/books/delete')

   .get(function(request, response) {
        response.send( html_page(drop(request.query.id)) );
    })

   .post(function(request, response) {
         LIBRARY.getBooks().splice(request.query.id, 1);
         response.redirect(301,'/books/list');
    });

app.route('/test').get((req, res) => {
    res.send(html())
})


app.get('/books/show_subject', function(request, response) {
    response.send( html_page(showSubject(request.query.id)) );
});

app.listen(8080, function() {
    console.log("Running Express");
});

/*-----------------------------------------------------------------------------
 * esquema de datos
 *----------------------------------------------------------------------------*/

function html() {
    return "<head></head><body><h1>Heyyyy</h1></body>"
}

var LIBRARY = (function() {
 var books = [];
 var subjects = ['Physics', 'Mathematics', 'Chemistry', 'Psychology', 'Geography'];
 
 return {
    getBooks: function() { return books; },
    getSubjects: function() { return subjects; },
    getSubjectIndex: function( s ) { return subjects.indexOf(s); },
    addBook: function( b ) { books.push( b ); }
 }
})();

var BOOK = (function(t, p, s, d) {
 BOOK.counter = (++BOOK.counter || 1);
 
 var id = BOOK.counter;
 var title = t;
 var price = p;
 var subject = LIBRARY.getSubjects().includes(s) ? s : null;
 var description = d;
 var created_at = new Date();
 
 return {
    getId: function() { return id; },
    getTitle: function() { return title; },
    getPrice: function() { return price; },
    getSubject: function() { return subject; },
    getDescription: function() { return description; },
    getCreatedAt: function() { return created_at; }
 }
});

/*-----------------------------------------------------------------------------
 * generación de páginas 
 *----------------------------------------------------------------------------*/

function html_page( content )
{
    var HTML_expr = "<!DOCTYPE html><html><head>";
    
    HTML_expr += "<meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1' />";
    HTML_expr += "<meta http-equiv='Content-Language' content='en-us' />";
    HTML_expr += "<title>Library Info System</title>";
    HTML_expr += "<link type='text/css' rel='stylesheet' href='/library.css'>";
    HTML_expr += "</head><body id='library'><div id='container'><div id='header'>";
    HTML_expr += "<h1>Library Info System</h1>";
    HTML_expr += "<h3>Implemented using JavaScript and Node</h3></div><div id='content'>";
    HTML_expr += content + "</div><div id='sidebar'></div></div></body></html>";
    
    return HTML_expr;
}

function newBook()
{
    var HTML_expr = "<h1>Add new book</h1>";
    
    HTML_expr += "<form action='/books/new' accept-charset='UTF-8' method='post'>"; // NOTE POST to the server when click on sumbit
    HTML_expr += "<input name='utf8' type='hidden' value=''/>";
    HTML_expr += "<input type='hidden' name='authenticity_token' value='token'/>";
    HTML_expr += "<p><label for='book_title'>Title</label>:";
    HTML_expr += "<input type='text' name='books[title]' id='books_title'/></p>";
    HTML_expr += "<p><label for='book_price'>Price</label>:";
    HTML_expr += "<input type='text' name='books[price]' id='books_price'/></p>";
    HTML_expr += "<p><label for='book_subject'>Subject</label>:";
    HTML_expr += "<select name='books[subject]' id='books_subject'>";
    HTML_expr += "<option value=''>Please select</option>";
    
    for(var i = 0; i < LIBRARY.getSubjects().length; i++) {
        HTML_expr += "<option value='" + i + "'>" + LIBRARY.getSubjects()[i] + "</option>";
    }
    
    HTML_expr += "</select></p>";
    HTML_expr += "<p><label for='book_description'>Description</label><br/>";
    HTML_expr += "<textarea name='books[description]' id='books_description'></textarea></p>";
    HTML_expr += "<input type='submit' name='commit' value='Create'/></form>";
    
    return HTML_expr + "<a href='/books/list'>Back</a>";
}

function listBooks()
{
    var HTML_expr = "<ul id = 'subjects'>";
    
    for(var i = 0; i < LIBRARY.getSubjects().length; i++) {
        HTML_expr += "<li><a href='/books/show_subject?id=" + i + "'>";
        HTML_expr += LIBRARY.getSubjects()[i] + "</a></li>";
    }
    
    HTML_expr += "</ul>";
    
    if( LIBRARY.getBooks().length === 0 ) {
        HTML_expr += "<p>There are not any books currently in the system.</p>";
        
    } else {
        HTML_expr += "<p>These are the current books in our system.</p>";
        HTML_expr += "<ul id='books'>";
        
        for(var i = 0; i < LIBRARY.getBooks().length; i++) {
            HTML_expr += "<li><a href='/books/show?id=" + i + "'>";
            HTML_expr += LIBRARY.getBooks()[i].getTitle() + "</a>";
            HTML_expr += " <b><a href='/books/edit?id=" + i + "'>Edit</a></b>";
            HTML_expr += " <b><a href='/books/delete?id=" + i + "'>Delete</a></b></li>";
        }
        
        HTML_expr += "</ul>";
    }
    
    return HTML_expr + "<a href='/books/new'>Add new book</a>";
}

function showBook( j )
{
    var HTML_expr = "<h1>" + LIBRARY.getBooks()[j].getTitle() + "</h1>";
    
    HTML_expr += "<p><strong>Price: </strong>$";
    HTML_expr += LIBRARY.getBooks()[j].getPrice() + "<br/>";
    HTML_expr += "<strong>Subject: </strong><a href='/books/show_subject?id=";
    HTML_expr += LIBRARY.getSubjectIndex(LIBRARY.getBooks()[j].getSubject()) + "'>";
    HTML_expr += LIBRARY.getBooks()[j].getSubject() + "</a><br/>";
    HTML_expr += "<strong>Created Date: </strong>";
    HTML_expr += LIBRARY.getBooks()[j].getCreatedAt() + "<br/></p>";
    HTML_expr += "<p>" + LIBRARY.getBooks()[j].getDescription() + "</p><hr/>";
    
    return HTML_expr + "<a href='/books/list'>Back</a>";
}

function edit( j )
{
    var HTML_expr = "<h1>Edit book detail</h1>";
    
    HTML_expr += "<form action='/books/edit?id=" + j;
    HTML_expr += "' accept-charset='UTF-8' method='post'>";
    HTML_expr += "<input name='utf8' type='hidden' value=''/>";
    HTML_expr += "<input type='hidden' name='authenticity_token' value='token'/>";
    HTML_expr += "<p><label for='book_title'>Title</label>:";
    HTML_expr += "<input type='text' value='" + LIBRARY.getBooks()[j].getTitle();
    HTML_expr += "' name='book[title]' id='books_title'/></p>";
    HTML_expr += "<p><label for='book_price'>Price</label>:";
    HTML_expr += "<input type='text' value='" + LIBRARY.getBooks()[j].getPrice();
    HTML_expr += "' name='book[price]' id='books_price'/></p>";
    HTML_expr += "<p><label for='book_subject'>Subject</label>:";
    HTML_expr += "<select name='book[subject]' id='books_subject'>";
    
    for(var i = 0; i < LIBRARY.getSubjects().length; i++) {
        HTML_expr += "<option " + (LIBRARY.getBooks()[j].getSubject() !=
                                   LIBRARY.getSubjects()[i]
                                ? "value='" : "selected='selected' value='") + i + "'>";
        HTML_expr += LIBRARY.getSubjects()[i] + "</option>";
    }
    
    HTML_expr += "</select></p>";
    HTML_expr += "<p><label for='book_description'>Description</label><br/>";
    HTML_expr += "<textarea name='book[description]' id='books_description'>";
    HTML_expr += LIBRARY.getBooks()[j].getDescription() + "</textarea></p>";
    HTML_expr += "<input type='submit' name='commit' value='Save'/></form>";
    
    return HTML_expr + "<a href='/books/list'>Back</a>";
}

function drop( j )
{
    var HTML_expr = "<h1>" + LIBRARY.getBooks()[j].getTitle() + "</h1>";
    
    HTML_expr += "<form action='/books/delete?id=" + j;
    HTML_expr += "' accept-charset='UTF-8' method='post'>";
    HTML_expr += "<input name='utf8' type='hidden' value=''/>";
    HTML_expr += "<input type='hidden' name='authenticity_token' value='token'/>";
    HTML_expr += "<p><strong>Price: </strong>$";
    HTML_expr += LIBRARY.getBooks()[j].getPrice() + "<br/>";
    HTML_expr += "<strong>Subject: </strong>";
    HTML_expr += LIBRARY.getBooks()[j].getSubject() + "<br/>";
    HTML_expr += "<strong>Created Date: </strong>";
    HTML_expr += LIBRARY.getBooks()[j].getCreatedAt() + "<br/></p>";
    HTML_expr += "<p>" + LIBRARY.getBooks()[j].getDescription() + "</p><hr/>";
    HTML_expr += "<input type='submit' name='commit' value='Delete'/></form>";
    
    return HTML_expr + "<a href='/books/list'>Back</a>";
}

function showSubject( index )
{
    var HTML_expr = "<h1>" + LIBRARY.getSubjects()[index] + "</h1><ul>";
    
    for(var i = 0; i < LIBRARY.getBooks().length; i++) {
        if(LIBRARY.getBooks()[i].getSubject() == LIBRARY.getSubjects()[index]) {
            HTML_expr += "<li><a href='/books/show?id=" + i + "'>";
            HTML_expr += LIBRARY.getBooks()[i].getTitle() + "</a></li>";
        }
    }
    
    return HTML_expr + "</ul><a href='/books/list'>Back</a>";
}
