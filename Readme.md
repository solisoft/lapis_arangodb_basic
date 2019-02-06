# Lapis + ArangoDB

`docker-compose up --build`

For running only dev mode : `docker-compose up --build web`

It will launch the lapis instance + an arangoDB one

* To access ArangoDB UI : `http://localhost:8530` (root / password)

Create a `cms` database with an `objects` collection

* To access Lapis app (dev) : `http://localhost:8080`
* To access Lapis app (prod) : `http://localhost:9090`


## To compile any modification

Go into the docker instance :
`docker-compose run web bash` then run `moonc  **/*.moon` to compile `.moon` files.

Watch the folder for any file modification :
`moonc -w **/*.moon`

# Links

* [ArangoDB](https://arangodb.com)
* [Lapis](http://leafo.net/lapis/)

# Benchmarks

I used [weighttp](https://github.com/lighttpd/weighttp) for running some tests on my laptop. I was able to run 2000req/s without micro-caching.

9000req/s with a 0.2s micro-caching enabled.

`weighttp -n 10000 -c 100 -k -t 4 http://localhost:9090`