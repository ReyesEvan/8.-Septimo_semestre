# Overview first partial

- The Web 1.0 was content provider ─ The web 2.0 became service provider

Internet was created in waves:
1. First wave introduced the standards
2. Second wave introduced connectivity by using the protocol TCP/IP
3. Third wave introduced presentation by creating HTML and providing web pages

## Web 1.0

It was created after
- Webpages were static
- Users could not interact with the webpage
- Personal webpages were stored in server's filesystem, not in a database
- It was possible to generate dynamic websites with the use of CGI <!-- ? To check if true/>

**URL Syntax:** `protocol://host[:port]path[?query][#fragment]`

## Web 2.0
- Sites were now dynamic
- Were responsive to use
- Information flows now in both directions site owner <-> site user
- Sites developed APIs for usage through apps

## REST

Rest is all about resources
- How to manipulate them -> GET
- How to represent them in different ways -> XML

### Resource representations

- **Understandability:** Server and client must understand and utilize the representation form
- **Completeness:** The format should be able to represent simple and complex resources
- **Linkability:** Format should be able to represent linkage among resources

### REST/HTTP operations

| Method | Description                                                | Safe | Idempotent |
| ------ | ---------------------------------------------------------- | ---- | ---------- |
| GET    | Requests a specific representation of resource             | ✓    | ✓          |
| PUT    | Create or update a resource with a supplied representation | ✗    | ✓          |
| DELETE | Deletes the specified resource                             | ✗    | ✓          |
| POST   | Submits data to be processed                               | ✗    | ✗          |

**Idempotent** - es una operación que ejecutada `n` cantidad de veces el resultado no cambia

### Error code ranges

- **[100, 200)** -> Informational responses
- **[200, 300)** -> Successful responses
- **[300, 400)** -> Redirections
- **[400, 500)** -> Client errors
- **[500, 600)** -> Server errors

## Distributed architecture models

### Layers

- Presentation - offers operations to a client for interact with the system
- Application logic - determines what the system actually does
- Resource management - deals with the business logic data
