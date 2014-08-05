#!/bin/bash

echo Packe alle Bilder in ein zip-File.
#zip /home/pi/Rasp_cam_mod/archive/archive.zip /home/pi/Rasp_cam_mod/archive/*.jpg
echo

echo Starte Kopiervorgang nach
echo georg@192.168.0.13:/home/georg/Rasp-Pis/No2/image_Auffanglager
echo
scp /home/pi/Rasp_cam_mod/archive/* georg@192.168.0.13:/home/georg/Rasp-Pis/No2/image_Auffanglager
echo
echo



# Hier muss ein if rein, dass die Daten nur gelöscht werden,
# wenn die Verbidung mit ssh ausgebaut werden konnte !!!!!!

#echo Lösche Images auf RPi No. 2.
#rm /home/pi/Rasp_cam_mod/archive/*
#echo
echo
echo Fertig und By.
echo

