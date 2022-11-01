#!/bin/bash
# This is meant as an extension to .bashrc/.zshrc/.<any>rc
#
# source this file in the main .xxxrc file
#
cat ${HOME}/.config/.bashrc.d/* > ${HOME}/.config/.bashrc.d.bundle
source ${HOME}/.config/.bashrc.d.bundle
