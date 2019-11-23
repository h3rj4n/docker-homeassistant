#!/bin/bash

if [ "$1" == "" ]; then
    echo "Provide a version number"
    exit
fi

# Fetch the new remote data.
curl -O https://raw.githubusercontent.com/home-assistant/home-assistant/$1/requirements_all.txt
diff --side-by-side custom_require.txt requirements_all.txt  | grep -v ' >' | sed -r 's/[^\t]*\t*(.*)/\1/' | sed -r 's/^[ ]+\|\t//' > auto.txt
mv auto.txt custom_require.txt
