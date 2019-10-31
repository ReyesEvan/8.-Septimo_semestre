
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


function newBook()
{
    var HTML_expr = "<h1>Add new book</h1><form>";
    
    HTML_expr += "<p><label for='book_title'>Title</label>:";
    HTML_expr += "<input type='text' id='books_title'/></p>";
    HTML_expr += "<p><label for='book_price'>Price</label>:";
    HTML_expr += "<input type='text' id='books_price'/></p>";
    HTML_expr += "<p><label for='book_subject'>Subject</label>:";
    HTML_expr += "<select id='books_subject'>";
    HTML_expr += "<option value=''>Please select</option>";
    
    for(var i = 0; i < LIBRARY.getSubjects().length; i++) {
        HTML_expr += "<option value='" + i + "'>" + LIBRARY.getSubjects()[i] + "</option>";
    }
    
    HTML_expr += "</select></p>";
    HTML_expr += "<p><label for='book_description'>Description</label><br/>";
    HTML_expr += "<textarea id='books_description'></textarea></p>";
    HTML_expr += "<input type='button' onclick='createBook()' value='Create'/></form>";
    HTML_expr += "<p class='button' onclick='listBooks()'><u>Back</u></p>";
    
    document.getElementById("result").innerHTML = HTML_expr;
}


function createBook()
{
    var title = document.getElementById("books_title").value;
    var price = document.getElementById("books_price").value;
    var subject = document.getElementById("books_subject").value;
    var description = document.getElementById("books_description").value;
    
    LIBRARY.addBook(BOOK(title, price, LIBRARY.getSubjects()[subject], description));
    listBooks();
}


function listBooks()
{
    var HTML_expr = "<ul id = 'subjects'>";
    
    for(var i = 0; i < LIBRARY.getSubjects().length; i++) {
        HTML_expr += "<li><u class='button' onclick='showSubject(" + i + ")'>";
        HTML_expr += LIBRARY.getSubjects()[i] + "</u></li>";
    }
    
    HTML_expr += "</ul>";
    
    if( LIBRARY.getBooks().length === 0 ) {
        HTML_expr += "<p>There are not any books currently in the system.</p>";
        
    } else {
        HTML_expr += "<p>These are the current books in our system.</p>";
        HTML_expr += "<ul id='books'>";
        
        for(var i = 0; i < LIBRARY.getBooks().length; i++) {
            HTML_expr += "<li><u class='button' onclick='showBook(" + i + ")'>";
            HTML_expr += LIBRARY.getBooks()[i].getTitle();
            HTML_expr += "</u> <b class='button' onclick='edit(" + i + ")'><u>Edit</u></b> ";
            HTML_expr += "<b class='button' onclick='drop(" + i + ")'><u>Delete</u></b></li>";
        }
        HTML_expr += "</ul>";
    }
    
    HTML_expr += "<p class='button' onclick='newBook()'><u>Add new book</u></p>";
    document.getElementById("result").innerHTML = HTML_expr;
}


function showBook( j )
{
    var HTML_expr = "<h1>" + LIBRARY.getBooks()[j].getTitle() + "</h1>";
    
    HTML_expr += "<p><strong>Price: </strong>$";
    HTML_expr += LIBRARY.getBooks()[j].getPrice() + "<br/>";
    HTML_expr += "<strong>Subject: </strong>"
    HTML_expr += "<u class='button' onclick='showSubject(";
    HTML_expr += LIBRARY.getSubjectIndex(LIBRARY.getBooks()[j].getSubject());
    HTML_expr += ")'>" + LIBRARY.getBooks()[j].getSubject() + "</u><br/>";
    HTML_expr += "<strong>Created Date: </strong>";
    HTML_expr += LIBRARY.getBooks()[j].getCreatedAt() + "<br/></p>";
    HTML_expr += "<p>" + LIBRARY.getBooks()[j].getDescription() + "</p><hr/>";
    HTML_expr += "<p class='button' onclick='listBooks()'><u>Back</u></p>";
    
    document.getElementById("result").innerHTML = HTML_expr;
}


function edit( j )
{
    var HTML_expr = "<h1>Edit book detail</h1><form>";
    
    HTML_expr += "<p><label for='book_title'>Title</label>:";
    HTML_expr += "<input type='text' value='";
    HTML_expr += LIBRARY.getBooks()[j].getTitle() + "' id='books_title'/></p>";
    HTML_expr += "<p><label for='book_price'>Price</label>:";
    HTML_expr += "<input type='text' value='";
    HTML_expr += LIBRARY.getBooks()[j].getPrice() + "' id='books_price'/></p>";
    HTML_expr += "<p><label for='book_subject'>Subject</label>:";
    HTML_expr += "<select id='books_subject'>";
    
    for(var i = 0; i < LIBRARY.getSubjects().length; i++) {
        HTML_expr += "<option " + (LIBRARY.getBooks()[j].getSubject() !=
                                   LIBRARY.getSubjects()[i]
                                ? "value='" : "selected='selected' value='") + i + "'>";
        HTML_expr += LIBRARY.getSubjects()[i] + "</option>";
    }
    
    HTML_expr += "</select></p>";
    HTML_expr += "<p><label for='book_description'>Description</label><br/>";
    HTML_expr += "<textarea id='books_description'>";
    HTML_expr += LIBRARY.getBooks()[j].getDescription() + "</textarea></p>";
    HTML_expr += "<input type='button' onclick='saveBook(" + j + ")' value='Save'/></form>";
    HTML_expr += "<p class='button' onclick='listBooks()'><u>Back</u></p>";
    
    document.getElementById("result").innerHTML = HTML_expr;
}


function saveBook( j )
{
    var title = document.getElementById("books_title").value;
    var price = document.getElementById("books_price").value;
    var subject = document.getElementById("books_subject").value;
    var description = document.getElementById("books_description").value;
    
    LIBRARY.getBooks()[j] = BOOK(title, price, LIBRARY.getSubjects()[subject], description);
    listBooks();
}


function drop( j )
{
    var HTML_expr = "<h1>" + LIBRARY.getBooks()[j].getTitle() + "</h1>";
    
    HTML_expr += "<p><strong>Price: </strong>$";
    HTML_expr += LIBRARY.getBooks()[j].getPrice() + "<br/>";
    HTML_expr += "<strong>Subject: </strong>";
    HTML_expr += LIBRARY.getBooks()[j].getSubject() + "<br/>";
    HTML_expr += "<strong>Created Date: </strong>";
    HTML_expr += LIBRARY.getBooks()[j].getCreatedAt() + "<br/></p>";
    HTML_expr += "<p>" + LIBRARY.getBooks()[j].getDescription() + "</p><hr/>";
    HTML_expr += "<input type='button' onclick='deleteBook(" + j + ")' value='Delete'/>";
    HTML_expr += "<p class='button' onclick='listBooks()'><u>Back</u></p>";
    
    document.getElementById("result").innerHTML = HTML_expr;
}


function deleteBook( j )
{
    LIBRARY.getBooks().splice(j, 1);
    listBooks();
}


function showSubject( index )
{
    var HTML_expr = "<h1>" + LIBRARY.getSubjects()[index] + "</h1><ul>";
    
    for(var i = 0; i < LIBRARY.getBooks().length; i++) {
        if(LIBRARY.getBooks()[i].getSubject() == LIBRARY.getSubjects()[index]) {
            HTML_expr += "<li><u class='button' onclick='showBook(" + i + ")'>";
            HTML_expr += LIBRARY.getBooks()[i].getTitle() + "</u></li>";
        }
    }
    
    HTML_expr += "</ul><p class='button' onclick='listBooks()'><u>Back</u></p>";
    document.getElementById("result").innerHTML = HTML_expr;
}
