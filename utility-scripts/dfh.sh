#!/bin/bash
echo "Filesystem      Size  Used Avail Use% Mounted on"
df -h | grep "/dev/sd"
