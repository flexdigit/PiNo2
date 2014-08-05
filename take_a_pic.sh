#!/bin/bash

WIDTH=640
HEIGHT=480


raspistill -w $WIDTH -h $HEIGHT -t 1 -o image.jpg
#raspistill -rot 180 -w $WIDTH -h $HEIGHT -t 1 -o image.jpg
