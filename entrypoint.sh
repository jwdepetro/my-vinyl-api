#!/bin/sh

rake db:create
rake db:migrate
SD_LOG_LEVEL=1 rake swagger:docs

puma -C config/puma.rb