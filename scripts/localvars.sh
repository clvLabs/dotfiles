#!/bin/bash
# diff set.sorted printenv.sorted | grep "<" | awk '{ print $2 }'
comm -23 <(set|sort) <(printenv|sort)
