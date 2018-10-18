# Lapis + ArangoDB

`docker-compose up --build`

For running only dev mode : `docker-compose up web --build`

It will launch the lapis instance + an arangoDB one

* To access ArangoDB UI : `http://localhost:8530`

Create a `cms` database with an `objects` collection

* To access Lapis app (dev) : `http://localhost:8080`
* To access Lapis app (prod) : `http://localhost:9090`


# Links

* [ArangoDB](https://arangodb.com)
* [Lapis](http://leafo.net/lapis/)

# Benchmarks

I used [weighttp](https://github.com/lighttpd/weighttp) for running some tests on my laptop. I was able to run 2000req/s without micro-caching.

9000req/s with a 0.2s micro-caching enabled.

`weighttp -n 10000 -c 100 -k -t 4 http://localhost:9090`