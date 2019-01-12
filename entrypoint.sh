#!/bin/sh

rake db:create
rake db:migrate
rake rswag:specs:swaggerize

puma -C config/puma.rb