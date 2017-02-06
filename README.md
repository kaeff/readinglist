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
* [ ] Ebook conversion
* [ ] Send to kindle
* [ ] Curate articles in lists
* [ ] UI
* [ ] Deployment & CI
* [ ] Async processing

