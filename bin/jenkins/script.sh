#!/bin/bash

# only on VM
unset XDG_RUNTIME_DIR

bundle install --with=test --path vendor/bundle

GENERATE_REPORTS=true RAILS_ENV=test bundle exec rake run_test
