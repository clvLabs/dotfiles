#!/bin/bash
yad --color --picker | tr -d '\n' | tr -d '#' | clipcp
