#!/bin/bash

dir=$PWD

if [[ $dir != *.aliases/fetch* ]];
then
  dir=$(dirname "$0")
fi

file=$dir"/fetch"
ln -s $file /usr/local/bin/fetch

