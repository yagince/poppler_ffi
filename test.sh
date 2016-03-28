#!/bin/bash

docker run \
       -t \
       -i \
       -v $(pwd):/poppler_ffi \
       yagince/poppler_ffi \
       /bin/bash -c "cd poppler_ffi && bundle install && bundle exec rspec"
