#!/bin/bash

export PORT=5100

cd ~/www/tasks
./bin/tasks stop || true
./bin/tasks start

