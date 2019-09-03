#!/bin/bash
[ -e bundle.tar.gz ] && rm -v bundle.tar.gz
tar -czvf bundle.tar.gz lib themes aqua.zsh
