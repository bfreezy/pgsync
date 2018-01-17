#!/bin/bash

# Basic usage below
# Visit https://github.com/jacobherrington/pgsync for more options

echo 'Syncing schema only'
bundle exec pgsync --schema-only

echo 'Syncing tables'
bundle exec pgsync

