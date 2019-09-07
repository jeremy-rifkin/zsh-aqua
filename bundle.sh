#!/bin/bash
[ -e bundle.tar.gz ] && rm -v bundle.tar.gz
tar -czf bundle.tar.gz lib themes aqua.zsh && echo "created new tarbal"
