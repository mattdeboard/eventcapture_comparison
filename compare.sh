#!/bin/sh
RUNS=${1-10000}
PORT=${2-3000}

sudo -u postgres psql event -c "truncate eventlog"
sudo -u postgres psql event -c "vacuum analyze eventlog"
ab -n $RUNS -c 50 -T application/x-www-form-urlencoded -p benchmark/sample_post_data.txt -k http://localhost:$PORT/capture
