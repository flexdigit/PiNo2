#!/bin/bash

# FTP
FTP_SERVER=flexdigit.cwsurf.de
FTP_USER=USER
FTP_PW=PW

#cd .

ftp -n -v $FTP_SERVER << EOT
user $FTP_USER $FTP_PW

bin
prompt

cd /htdocs
mput index.htm
mput image.jpg

cd /htdocs/scripts
mput *.sh

by
EOT
