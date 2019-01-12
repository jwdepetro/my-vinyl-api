#!/bin/sh

rake db:create
rake db:migrate

puma -C config/puma.rb