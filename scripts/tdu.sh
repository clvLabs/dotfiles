#!/bin/zsh
# tdu: tree/du (disk usage)
tree --du -hF ${@} | grep -Pe "(/$|used)"
