#!/bin/sh
dir=$HOME
editor=nano
[ -z "$1" ] && exit 1
$editor $dir/$1
chmod u+x $dir/$1
#$dir/$1
