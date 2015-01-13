#!/bin/bash
# Generiert eine index.htm-Seite
# Macht ein Bild
# ruft FTP-Script cwcity_FTP.sh auf

######################
# Generiere index.htm
######################
HTMLPAGE="/home/pi/Rasp_cam_mod/index.htm"
CLIENT_TCP="/home/pi/Perlen/clnt_TCP.pl"

echo "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">" > $HTMLPAGE
echo "<html>"                           >> $HTMLPAGE
echo "<head>"                           >> $HTMLPAGE
echo "<meta http-equiv=\"content-type\" content=\"text/html; charset=utf-8\">" >> $HTMLPAGE
echo "<title>Overview</title>"          >> $HTMLPAGE

echo "<style type="text/css">"          >> $HTMLPAGE
echo "*   {font-family: Courier; font-size:12; white-space:pre;}"          >> $HTMLPAGE
echo "</style>"          >> $HTMLPAGE

echo "</head>"                          >> $HTMLPAGE
echo "<body>"                           >> $HTMLPAGE
echo "Overview generated at"            >> $HTMLPAGE
date '+%a %Y-%m-%d %H:%M'               >> $HTMLPAGE
#echo "    <p></p>"                      >> $HTMLPAGE
echo ""                                 >> $HTMLPAGE
echo "    <img src="tempday.png"> <img src="tempweek.png">"         >> $HTMLPAGE
#echo "    <img src="tempweek.png">"		>> $HTMLPAGE
echo "    <img src="solarday.png"> <img src="solarweek.png">"		>> $HTMLPAGE
#echo "    <img src="solarweek.png">"    >> $HTMLPAGE
echo ""                                 >> $HTMLPAGE
echo "    <img src="image.jpg">"        >> $HTMLPAGE
echo "	  <p></p>"                      >> $HTMLPAGE

# Start Tabelle
#echo "<table border="1" frame="hsides" rules="all" style="font-family:Courier\; font-size:10\; white-space:pre\;" >" >> $HTMLPAGE
echo "<table border="1" frame="hsides" rules="all" >"					>> $HTMLPAGE

echo "<caption><bold>Raspi</bold></caption>"							>> $HTMLPAGE
echo "<tr>"                             >> $HTMLPAGE
echo "<th bgcolor="#99CC33">No #1<br> (info is \"served\")</th>"        >> $HTMLPAGE
echo "<th bgcolor="#99CC33">No #2</th>" >> $HTMLPAGE
echo "</tr>"                            >> $HTMLPAGE

# Zeilen uptime
echo "<tr>"                             >> $HTMLPAGE
echo "<td>"                             >> $HTMLPAGE
$CLIENT_TCP w | tr '\n' '#' | sed 's/#/<br>/g'      >> $HTMLPAGE
echo "</td>"                            >> $HTMLPAGE
echo "<td>"                             >> $HTMLPAGE
w | tr '\n' '#' | sed 's/#/<br>/g'      >> $HTMLPAGE
echo "</td>"                            >> $HTMLPAGE
echo "</tr>"                            >> $HTMLPAGE

# Zeilen df -h
echo "<tr>"                             >> $HTMLPAGE
echo "<td>"                             >> $HTMLPAGE
$CLIENT_TCP "df -h" | tr '\n' '#' | sed 's/#/<br>/g'>> $HTMLPAGE
echo "</td>"                            >> $HTMLPAGE
echo "<td>"                             >> $HTMLPAGE
df -h | tr '\n' '#' | sed 's/#/<br>/g'  >> $HTMLPAGE
echo "</td>"                            >> $HTMLPAGE
echo "</tr>"                            >> $HTMLPAGE

# Zeilen du -sh
echo "<tr>"                             >> $HTMLPAGE
echo "<td>"                             >> $HTMLPAGE
$CLIENT_TCP "du -sh /home/pi/"          >> $HTMLPAGE
echo "</td>"                            >> $HTMLPAGE
echo "<td>"                             >> $HTMLPAGE
du -sh /home/pi/                        >> $HTMLPAGE
echo "</td>"                            >> $HTMLPAGE
echo "</tr>"                            >> $HTMLPAGE

# vcgencmd-Befehle
echo "<tr>"                             >> $HTMLPAGE
echo "<td>"                             >> $HTMLPAGE
$CLIENT_TCP "vcgencmd measure_temp"     >> $HTMLPAGE
$CLIENT_TCP "vcgencmd measure_volts"    >> $HTMLPAGE
$CLIENT_TCP "vcgencmd measure_clock arm">> $HTMLPAGE
$CLIENT_TCP "vcgencmd measure_clock core"           >> $HTMLPAGE
echo "</td>"                            >> $HTMLPAGE
echo "<td>"                             >> $HTMLPAGE
vcgencmd measure_temp			>> $HTMLPAGE
vcgencmd measure_volts			>> $HTMLPAGE
vcgencmd measure_clock arm		>> $HTMLPAGE
vcgencmd measure_clock core		>> $HTMLPAGE
echo "</td>"                            >> $HTMLPAGE
echo "</tr>"                            >> $HTMLPAGE

echo "</table>"                         >> $HTMLPAGE
# Ende Tabelle
echo ""                                 >> $HTMLPAGE
echo ""                                 >> $HTMLPAGE
echo ""                                 >> $HTMLPAGE
echo ""                                 >> $HTMLPAGE
echo "</body>"                          >> $HTMLPAGE
echo "</html>"                          >> $HTMLPAGE


#vcgencmd measure_temp					>> $HTMLPAGE
#vcgencmd measure_volts					>> $HTMLPAGE
#vcgencmd measure_clock arm				>> $HTMLPAGE


######################################
# 
# Skript ausführen um Bild (Auflösung 640x480 --> 240 kB)
# zu machen
cd /home/pi/Rasp_cam_mod/
./take_a_pic.sh
#/home/pi/Rasp_cam_mod//take_a_pic.sh

######################################
#
# Bild kopieren und in Kopie (die noch gleich heisst wie Original) Schrift einfügen
# "-resize 70%" verkleinert das Bild ein wenig --> zu klein...
COPYRIGHT="© $(/bin/date +%Y) flexdigit | `date "+%a %Y-%m-%d | %H:%M"`"
FONT="/usr/share/fonts/truetype/ttf-dejavu/DejaVuSans.ttf"
#FONT="/usr/share/fonts/truetype/freefont/FreeMono.ttf"
#FONT="/usr/share/fonts/truetype/ttf-dejavu/FreeSerif.ttf"

#convert image.jpg -resize 640 -font $FONT -fill white -pointsize 10 -annotate 0x0+230+460 "$COPYRIGHT" image.jpg
#convert image.jpg -resize 70% -font $FONT -fill white -pointsize 10 -annotate 0x0+230+460 "$COPYRIGHT" image.jpg
convert image.jpg -font $FONT -fill white -pointsize 10 -annotate 0x0+230+460 "$COPYRIGHT" image.jpg

######################################
#
# Bild kopieren und mit Datum und Uhrzeit versehen
#
so=`date "+%Y%m%d_%H%M"`
#cp image.jpg /home/pi/Rasp_cam_mod/archive/image_$so.jpg


######################################
#
# FTP-Skripte ausführen um Bild und index.htm auf www.cwcity.de zu laden
#
cd /home/pi/Rasp_cam_mod/
./cwcity_FTP.sh


date "+%Y.%m.%d | %H:%M:%S"

# fuer crontab
# */5 * * * * $HOME/temperature/generiere_Grafik.sh >> $HOME/temperature/generiere_Grafik.log 2>&1
# echo '*/5 * * * * $HOME/Rasp_cam_mod/gen_Page_Pic.sh >> $HOME/Rasp_cam_mod/gen_Page_Pic.log 2>&1' | crontab -
