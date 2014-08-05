#!/bin/bash
# Generiert ein Verzeichnis mit folgenden Namen:
# "archive_[Jahr-Monat-Tag]"

NAME="archive_"$(date '+%Y-%m-%d')

#echo $NAME

mkdir $NAME
