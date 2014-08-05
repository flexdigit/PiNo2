#!/bin/bash

# FTP
FTP_SERVER=flexdigit.cwsurf.de
FTP_USER=usr_ftp_216891
FTP_PW=gebuit00_Zaka2

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