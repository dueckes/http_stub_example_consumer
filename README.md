http_stub_example_consumer
--------------------------

An example of a UI that consumes a HTTP API that is virtualized via [http_stub](https://github.com/MYOB-Technology/http_stub)

### Status
[![Build Status](https://travis-ci.org/MYOB-Technology/http_stub_example_consumer.png)](https://travis-ci.org/MYOB-Technology/http_stub_example_consumer)
[![Code Climate](https://codeclimate.com/github/MYOB-Technology/http_stub_example_consumer/badges/gpa.svg)](https://codeclimate.com/github/MYOB-Technology/http_stub_example_consumer)
[![Test Coverage](https://codeclimate.com/github/MYOB-Technology/http_stub_example_consumer/badges/coverage.svg)](https://codeclimate.com/github/MYOB-Technology/http_stub_example_consumer/coverage)
[![Dependency Status](https://gemnasium.com/MYOB-Technology/http_stub_example_consumer.png)](https://gemnasium.com/MYOB-Technology/http_stub_example_consumer)

### Running the Consumer
- Install [Docker](https://www.docker.com/)
- `docker build -t http_stub_example_consumer .`
- `docker run -d -p 3000:3000 http_stub_example_consumer`
- Producer is available on ```http://localhost:3000```

### How do I experiment with it?
Run terminal: `docker run -it -p 3000:3000 -v ~/work/http_stub_example_consumer:/root/app http_stub_example_consumer /bin/sh`
