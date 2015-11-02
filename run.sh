#!/bin/sh
#
# Installs dotfiles.

source "$(dirname $0)"/logging.sh

dotfiles_root=$(pwd)/dotfiles
scripts_root=$(pwd)/scripts

# Copy over dotfiles.
for source in ${dotfiles_root}/*
do
    source_basename=$(basename $source)
    dest=$HOME/.${source_basename}

    log_success "+ ~/.${source_basename}"

    rm -rf ${dest}
    ln -s $source $dest
done

# Run the remaining setup scripts
for script in ${scripts_root}/*
do
    source $script
done
