# Test Results

I'm going to build on @nathanwdavis's original README here with my tests.


## Methods

We're comparing Go's built-in webserver to an "uberjar" generated by Leiningen.

To run the Go project:

``PGHOST=/var/run/postgresql GOPATH=$HOME go run eventcaptureserver.go``

To compile the uberjar:

``lein ring uberjar``

To execute the uberjar:

``java -jar target/eventcapture-0.1.0-STANDALONE-snapshot.jar``

I ran both of these concurrently. If port 3000 is unavailable, the uberjar will select the next available port, while the Go program will not. So I would start the Go version first, then the Java version.

I tested each using the shell script found in the root of this project:

Go: ``./compare.sh 100000 3000``

and

Clojure: ``./compare.sh 100000 3001``

This sends a total of 100000 requests to each server, 50 at a time, via Apache Benchmark.


## Results

### First Run

In the first run-through of the tests, Go significantly outperformed Clojure by about 1100 requests per minute:

Clojure 1st run:

```
Concurrency Level:      50
Time taken for tests:   31.994 seconds
Complete requests:      100000
Failed requests:        0
Write errors:           0
Keep-Alive requests:    100000
Total transferred:      16900000 bytes
Total body sent:        24000000
HTML transferred:       0 bytes
Requests per second:    3125.55 [#/sec] (mean)
Time per request:       15.997 [ms] (mean)
Time per request:       0.320 [ms] (mean, across all concurrent requests)
Transfer rate:          515.84 [Kbytes/sec] received
                        732.55 kb/s sent
                        1248.39 kb/s total

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.0      0       2
Processing:     2   16  22.2     10     815
Waiting:        2   16  22.2     10     815
Total:          2   16  22.3     10     816

Percentage of the requests served within a certain time (ms)
  50%     10
  66%     13
  75%     16
  80%     18
  90%     30
  95%     51
  98%     80
  99%    104
 100%    816 (longest request)
```

Go 1st run:

```
Server Software:
Server Hostname:        localhost
Server Port:            3000

Document Path:          /capture
Document Length:        0 bytes

Concurrency Level:      50
Time taken for tests:   21.211 seconds
Complete requests:      100000
Failed requests:        0
Write errors:           0
Keep-Alive requests:    100000
Total transferred:      14000000 bytes
Total body sent:        24000000
HTML transferred:       0 bytes
Requests per second:    4714.52 [#/sec] (mean)
Time per request:       10.606 [ms] (mean)
Time per request:       0.212 [ms] (mean, across all concurrent requests)
Transfer rate:          644.56 [Kbytes/sec] received
                        1104.97 kb/s sent
                        1749.53 kb/s total

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.0      0       1
Processing:     3   11   2.9     10      33
Waiting:        3   11   2.9     10      33
Total:          3   11   2.9     10      33

Percentage of the requests served within a certain time (ms)
  50%     10
  66%     11
  75%     12
  80%     13
  90%     14
  95%     16
  98%     18
  99%     19
 100%     33 (longest request)
```

### Second Run

However, due apparently to a topic I know nothing about, Java's JIT compiler requires warming. Usually it takes about 10000 runs for the compiler to make decisions about code optimizations.

This is borne out by further runs. Clojure catches up to and passes Go:

Clojure 2nd Run:

```
Server Software:        Jetty(7.x.y-SNAPSHOT)
Server Hostname:        localhost
Server Port:            3001

Document Path:          /capture
Document Length:        0 bytes

Concurrency Level:      50
Time taken for tests:   18.691 seconds
Complete requests:      100000
Failed requests:        0
Write errors:           0
Keep-Alive requests:    100000
Total transferred:      16900000 bytes
Total body sent:        24000000
HTML transferred:       0 bytes
Requests per second:    5350.24 [#/sec] (mean)
Time per request:       9.345 [ms] (mean)
Time per request:       0.187 [ms] (mean, across all concurrent requests)
Transfer rate:          883.00 [Kbytes/sec] received
                        1253.96 kb/s sent
                        2136.96 kb/s total

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.0      0       2
Processing:     2    9   5.0      9     106
Waiting:        2    9   5.0      9     106
Total:          2    9   5.0      9     106

Percentage of the requests served within a certain time (ms)
  50%      9
  66%     10
  75%     11
  80%     12
  90%     14
  95%     17
  98%     21
  99%     24
 100%    106 (longest request)
```

Go 2nd Run:

```
Server Software:
Server Hostname:        localhost
Server Port:            3000

Document Path:          /capture
Document Length:        0 bytes

Concurrency Level:      50
Time taken for tests:   21.194 seconds
Complete requests:      100000
Failed requests:        0
Write errors:           0
Keep-Alive requests:    100000
Total transferred:      14000000 bytes
Total body sent:        24000000
HTML transferred:       0 bytes
Requests per second:    4718.43 [#/sec] (mean)
Time per request:       10.597 [ms] (mean)
Time per request:       0.212 [ms] (mean, across all concurrent requests)
Transfer rate:          645.10 [Kbytes/sec] received
                        1105.88 kb/s sent
                        1750.98 kb/s total

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.0      0       2
Processing:     3   11   2.9     10      40
Waiting:        3   11   2.9     10      40
Total:          3   11   2.9     10      42

Percentage of the requests served within a certain time (ms)
  50%     10
  66%     11
  75%     12
  80%     13
  90%     14
  95%     16
  98%     18
  99%     19
 100%     42 (longest request)
 ```


## Original Testing

No uberjar, no JIT warming, 1000 requests through Apache Bench. Go blows Clojure away:

Clojure result:
```
Time taken for tests:   0.750 seconds
Complete requests:      1000
Failed requests:        0
Requests per second:    1334.06 [#/sec] (mean)

Percentage of the requests served within a certain time (ms)
  50%     20
  66%     27
  75%     36
  80%     46
  90%     82
  95%    123
  98%    200
  99%    249
 100%    321 (longest request)
```

Golang result:
```
Time taken for tests:   0.171 seconds
Complete requests:      1000
Failed requests:        0
Requests per second:    5845.49 [#/sec] (mean)

Percentage of the requests served within a certain time (ms)
  50%      8
  66%      9
  75%     10
  80%     11
  90%     12
  95%     13
  98%     14
  99%     14
 100%     17 (longest request)
```
