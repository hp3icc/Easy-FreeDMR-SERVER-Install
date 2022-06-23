#!/bin/sh
echo Actualizando sistema 
apt-get update -y
apt-get upgrade -y
#########
apt-get install sudo -y
sudo apt-get purge needrestart -y
sudo apt-get install wget -y
sudo apt-get install git -y
sudo apt-get install screen -y
sudo apt-get install gcc -y
sudo apt-get install g++ -y
sudo apt-get install make -y
sudo apt-get install cmake -y
sudo apt-get install musl-dev -y
sudo apt-get install python2 -y

update-alternatives --install /usr/bin/python python /usr/bin/python3 1
#
sudo apt-get install rsyslog -y
sudo apt-get install logrotate -y
sudo apt-get install gpsd -y
sudo apt-get install qt4-qmake -y
sudo apt-get install libtool -y
sudo apt-get install autoconf -y
sudo apt-get install automake -y
sudo apt-get install python-pkg-resources -y
sudo apt-get install sox -y
sudo apt-get install git-core -y

sudo apt-get install chkconfig -y

sudo apt-get install libffi-dev -y
sudo apt-get install libssl-dev -y
sudo apt-get install cargo -y 
sudo apt-get install sed -y
sudo apt install python3-pip -y
sudo apt install python3-distutils -y
sudo apt install python3-dev -y
sudo apt install python3-websockets
sudo apt install python3-psutil

sudo apt install socket
sudo apt install threading
sudo apt install queue
sudo apt install sys
sudo apt install os
sudo apt install time
sudo apt install re
sudo apt install datetime
sudo apt install signal
sudo apt install datetime
sudo apt install bisect
sudo apt install struct
sudo apt install ansi2html
sudo apt install logrotate
sudo pip3 install ansi2html
sudo apt-get install python-pip -y
sudo apt-get install python-dev -y
sudo apt-get install rrdtool -y

##################
sudo cat > /opt/emq-ver <<- "EOF"
EMQ-VER:  20
EOF
#########
cd /home/
wget https://bootstrap.pypa.io/get-pip.py
sudo python3 get-pip.py
sudo cat > /home/requirements.txt <<- "EOF"
autobahn
jinja2==2.11.3
bitstring>=3.1.5
bitarray>=0.8.1
Twisted>=16.3.0
dmr_utils3>=0.1.19
configparser>=3.0.0
aprslib>=0.6.42
tinydb
pynmea2
maidenhead
requests
libscrc
flask
folium
mysql-connector
resettabletimer>=0.7.0
setproctitle

EOF
#
pip3 install setuptools wheel
pip3 install -r requirements.txt
sudo rm requirements.txt
sudo rm get-pip.py
#
mkdir /var/www
mkdir /var/www/html

mkdir /var/log/FreeDMR
sudo chmod +777 /var/log
sudo chmod +777 /var/log/*

#
sudo cat > /bin/menu-fdmr <<- "EOF"
#!/bin/bash
while : ; do
choix=$(whiptail --title "Raspbian Proyect HP3ICC Menu FreeDMR" --menu "Suba o Baje con las flechas del teclado y seleccione el numero de opcion:" 23 56 13 \
1 " Edit FreeDMR Server " \
2 " Edit Interlink  " \
3 " Edit FDMR-Monitor  " \
4 " Edit Port HTTP  " \
5 " Parrot on  " \
6 " Parrot off  " \
7 " Restart FreeDMR Server  " \
9 " Restart FDMR-Monitor " \
11 " Menu D-APRS " \
12 " Menu update " 3>&1 1>&2 2>&3)
exitstatus=$?
#on recupere ce choix
#exitstatus=$?
if [ $exitstatus = 0 ]; then
    echo "Your chosen option:" $choix
else
    echo "You chose cancel."; break;
fi
# case : action en fonction du choix
case $choix in
1)
sudo nano /opt/FreeDMR/config/FreeDMR.cfg ;;
2)
sudo nano /opt/FreeDMR/config/rules.py ;;
3)
sudo nano /opt/FDMR-Monitor/fdmr-mon.cfg ;;
4)
sudo nano /etc/apache2/ports.conf && systemctl restart apache2.service ;;
5)
sudo systemctl stop fdmrparrot.service && sudo systemctl start fdmrparrot.service && sudo systemctl enable fdmrparrot.service ;;
6)
sudo systemctl stop fdmrparrot.service &&  sudo systemctl disable fdmrparrot.service ;;
7)
sudo systemctl stop proxy.service && sudo systemctl start proxy.service && sudo systemctl enable proxy.service && sudo systemctl stop freedmr.service && sudo systemctl start freedmr.service && sudo systemctl enable freedmr.service ;;
9)
echo 123> /opt/FDMR-Monitor/data/123.json && sudo systemctl stop fdmr_mon.service && sudo rm /opt/FDMR-Monitor/data/*.json && sudo rm /opt/FDMR-Monitor/sysinfo/*.rrd && sh /opt/FDMR-Monitor/sysinfo/rrd-db.sh && cronedit.sh '*/5 * * * *' 'sh /opt/FDMR-Monitor/sysinfo/graph.sh' add && cronedit.sh '*/2 * * * *' 'sh /opt/FDMR-Monitor/sysinfo/cpu.sh' add && sudo systemctl enable fdmr_mon.service && sudo systemctl restart apache2.service && sudo systemctl enable apache2.service && sudo systemctl start fdmr_mon.service && cronedit.sh '0 3 * * *' 'rm /opt/FDMR-Monitor/data/*' add && cronedit.sh '5 3 * * *' 'systemctl restart fdmr_mon.service' add ;;
11)
menu-igate ;;
12)
menu-update;
esac
done
exit 0




EOF
###


sudo cat > /opt/obp.txt <<- "EOF"
#Coloque abajo su lista de obp


EOF
####
