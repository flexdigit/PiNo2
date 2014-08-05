#!/bin/bash
# löscht Dateien im /archive-Ordner
# die älter als 7 Tage sind.


find $HOME/Rasp_cam_mod/archive -mtime +7 -print -exec rm {} \; >> $HOME/Rasp_cam_mod/del_pics_older_7days.log
#find $HOME/Rasp_cam_mod/archive -mtime +7 -print >> $HOME/Rasp_cam_mod/del_pics_older_7days.log
