#!/bin/bash

log_info () {
    printf "\r\033[2K  [\033[00;34mINFO\033[0m] $1\n"
}

log_success () {
    printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}
