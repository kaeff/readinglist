# Readlist app

**This is a toy, not working**

A readability.com replacement to curate readinglists, create ebooks from
the scraped articles and send them to kindle.

## Proof of concept

Idea is to hack a PoC re-using as much as possible:

* Uses Firefox' [Readbility.js](https://github.com/mozilla/readability) via [readable-proxy](https://github.com/n1k0/readable-proxy/)
* Uses Calibre's
  [ebook-convert](https://manual.calibre-ebook.com/generated/en/ebook-convert.html) for ebook conversion via [node-calibre-api](https://github.com/denouche/node-calibre-api)
* Rails app for the curation UI and rendering the ebook as html (source
  for the ebook conversion)
* Docker compose to glue everything together

## Starting the app

Generate a rails secret token:
```
echo "SECRET_KEY_BASE=`rails secret`" >> rails.env
```


Start the app:
```
docker-compose up -d
```
The app is running on port 3000.

## ToDo

* [x] Basic dev setup
* [x] Scrape article
* [x] Ebook conversion
* [x] Download lists as ebook
* [ ] Send to kindle
* [ ] Curate articles in lists
* [ ] UI
* [ ] Deployment & CI
* [ ] Async processing
* [ ] Better traceability of downstream errors
  * Log scraper responses

## More ideas

* Create articles from RSS feeds

## Bugs
### Deal with errors from scraper

```
HTTP/1.1 500 Internal Server Error
Access-Control-Allow-Headers: Origin, Requested-With, Content-Type,
Accept
Access-Control-Allow-Origin: *
Connection: keep-alive
Content-Length: 57
Content-Type: application/json; charset=utf-8
Date: Tue, 07 Feb 2017 10:13:36 GMT
ETag: W/"39-L1GaNx8z7kKPaYYYZih4+A"
X-Powered-By: Express

{
    "error": {
        "message": "Empty result from Readability.js."
    }
}
```
Other messages:
* "Empty result from Readability.js."

## Scraper can't access original page

```
Error: Unable to access http://www.theroot.com/the-national-interest-all-money-ain-t-good-money-the-1791979266
    at /usr/readable-proxy/scrape.js:37:29
    at ChildProcess.exithandler (child_process.js:197:7)
    at emitTwo (events.js:106:13)
    at ChildProcess.emit (events.js:191:7)
    at maybeClose (internal/child_process.js:877:16)
    at Process.ChildProcess._handle.onexit
(internal/child_process.js:226:5)
Error: Unable to access httpbin.org/post
    at /usr/readable-proxy/scrape.js:37:29
    at ChildProcess.exithandler (child_process.js:197:7)
    at emitTwo (events.js:106:13)
    at ChildProcess.emit (events.js:191:7)
    at maybeClose (internal/child_process.js:877:16)
    at Process.ChildProcess._handle.onexit
(internal/child_process.js:226:5)
{ Error: Empty result from Readability.js.
    at /usr/readable-proxy/scrape.js:37:29
    at ChildProcess.exithandler (child_process.js:197:7)
    at emitTwo (events.js:106:13)
    at ChildProcess.emit (events.js:191:7)
    at maybeClose (internal/child_process.js:877:16)
    at Process.ChildProcess._handle.onexit
(internal/child_process.js:226:5)
  sourceHTML: '<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2
Final//EN"><html><head><title>405 Method Not
Allowed</title>\n</head><body><h1>Method Not Allowed</h1>\n<p>The method
is not allowed for the requested URL.</p>\n</body></html>',
  consoleLogs: [] }
```

## Cleanup result is empty

```
$ get "`dm
ip`:3001/api/get?url=http://www.theroot.com/the-national-interest-all-money-ain-t-good-money-the-1791979266&userAgent=Mozilla%2F5.0%20(Macintosh%3B%20Intel%20Mac%20OS%20X%2010_11_5)%20AppleWebKit%2F537.36%20(KHTML%2C%20like%20Gecko)%20Chrome%2F55.0.2883.95%20Safari%2F537.36"
HTTP/1.1 200 OK
Access-Control-Allow-Headers: Origin, Requested-With, Content-Type,
Accept
Access-Control-Allow-Origin: *
Connection: keep-alive
Content-Length: 849
Content-Type: application/json; charset=utf-8
Date: Tue, 07 Feb 2017 10:33:01 GMT
ETag: W/"351-9wwImqGkjUjo5g1COJE61g"
X-Powered-By: Express

{
    "byline": "Andre Perry ",
    "consoleLogs": [
        "FPO - setup failed: Can't find variable:
TBWidgetGawkerComments",
        ""
    ],
    "content": "",
    "dir": "",
    "excerpt": "Editor’s note: Once a month, the National Interest
column will tackle broader questions about what the country should do to
increase educational opportunities for black youths.",
    "isProbablyReaderable": true,
    "length": 0,
    "rawText": "",
    "title": "The National Interest: All Money Ain’t Good Money: The
Role of White Foundations in Social Justice Movements",
    "uri": {
        "host": "www.theroot.com",
        "pathBase": "http://www.theroot.com/",
        "prePath": "http://www.theroot.com",
        "scheme": "http",
        "spec":
"http://www.theroot.com/the-national-interest-all-money-ain-t-good-money-the-1791979266"
    },
    "userAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5)
AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.95
Safari/537.36"
}
```
