#!/bin/bash

db2 -t -v < queries.sql 2>&1 | tee loaddata.log