# Lapis + ArangoDB

`docker-compose up --build`

It will launch the lapis instance + an arangoDB one

To access Lapis app : `http://localhost:8080`

To access ArangoDB UI : `http://localhost:8530`

# Links

[ArangoDB](https://arangodb.com)

[Lapis](http://leafo.net/lapis/)

# Benchmarks

I used `weighttp` fro running some tests on my laptop. I was able to run 2000req/s without micro-caching.

9000req/s with a 0.2s micro-caching enabled.