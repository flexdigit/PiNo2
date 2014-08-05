#!/bin/bash

i=1
for File in $(ls *.jpg)
do
    #mv ${File} 000${i}.jpg
    mv ${File} image_${i}.jpg
    i=$((i+1));                 # Hochzählen
done
