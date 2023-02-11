#!/bin/sh
echo Actualizando sistema 
apt-get update 
# apt-get upgrade -y
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
#
if [ -d "/opt/FreeDMR" ];
then
   sudo rm /opt/FreeDMR/ -r
 #echo "found file"
else
 echo "file not found"

fi
if [ -d "/opt/FDMR-Monitor" ];
then
   sudo rm /opt/FDMR-Monitor/ -r
 #echo "found file"
else
 echo "file not found"

fi
if [ -d "/var/www" ];
then
   echo "found file"
else
 mkdir /var/www
 #echo "file not found"

fi
if [ -d "/var/www/fdmr" ];
then
   sudo rm /var/www/fdmr/ -r
 #echo "found file"
else
 echo "file not found"

fi
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
mkdir /var/www/fdmr

mkdir /var/log/FreeDMR
sudo chmod +777 /var/log
sudo chmod +777 /var/log/*

#
sh -c "$(curl -fsSL https://raw.githubusercontent.com/hp3icc/Easy-FreeDMR-SERVER-Install/main/menu.sh)"

########################
if [ -f "/opt/obp.txt" ]
then
   echo "found file"
else
  sudo cat > /opt/obp.txt <<- "EOF"
 
#Coloque abajo su lista de obp y peer

EOF
fi
######################
if [ -f "/opt/rules.txt" ]
then
   echo "found file"
else
 sudo cat > /opt/rules.txt <<- "EOF"
BRIDGES = {
 
 '9990': [ 
        {'SYSTEM': 'EchoTest',              'TS': 2, 'TGID': 9990, 'ACTIVE':True, 'TIMEOUT': 0, 'TO_TYPE': 'NONE', 'ON': [9990], 'OFF': [], 'RESET': []}, 
        ],
  
  
  
}
if __name__ == '__main__':
    from pprint import pprint
    pprint(BRIDGES)
  
 
EOF
fi
############
if [ -f "/opt/extra-1.sh" ]
then
  echo "found file"
else
  sudo cat > /opt/extra-1.sh <<- "EOF"
######################################################################
# Coloque en este archivo, cualquier instruccion shell adicional que # 
# quierre se realice al finalizar la actualizacion.                  #
######################################################################
 
  
EOF
# 
cp /opt/extra-1.sh /opt/extra-2.sh
cp /opt/extra-1.sh /opt/extra-3.sh
cp /opt/extra-1.sh /opt/extra-4.sh
cp /opt/extra-1.sh /opt/extra-5.sh
cp /opt/extra-1.sh /opt/extra-6.sh
fi
sudo chmod +x /opt/extra-*

###################
cat > /usr/local/bin/cronedit.sh <<- "EOF"
cronjob_editor () {
# usage: cronjob_editor '<interval>' '<command>' <add|remove>

if [[ -z "$1" ]] ;then printf " no interval specified\n" ;fi
if [[ -z "$2" ]] ;then printf " no command specified\n" ;fi
if [[ -z "$3" ]] ;then printf " no action specified\n" ;fi

if [[ "$3" == add ]] ;then
    # add cronjob, no duplication:
    ( sudo crontab -l | grep -v -F -w "$2" ; echo "$1 $2" ) | sudo crontab -
elif [[ "$3" == remove ]] ;then
    # remove cronjob:
    ( sudo crontab -l | grep -v -F -w "$2" ) | sudo crontab -
fi
}
cronjob_editor "$1" "$2" "$3"


EOF
sudo chmod +x /usr/local/bin/cronedit.sh

##############
cd /opt
git clone https://gitlab.hacknix.net/hacknix/FreeDMR.git
cd FreeDMR
mkdir config
sudo chmod +x /opt/FreeDMR/*.py
sudo cat > /opt/conf.txt <<- "EOF"
 

[D-APRS]
MODE: MASTER
ENABLED: True
REPEAT: False
MAX_PEERS: 1
EXPORT_AMBE: False
IP:
PORT: 52555
PASSPHRASE:
GROUP_HANGTIME: 0
USE_ACL: True
REG_ACL: DENY:1
SUB_ACL: DENY:1
TGID_TS1_ACL: PERMIT:ALL
TGID_TS2_ACL: PERMIT:ALL
DEFAULT_UA_TIMER: 10
SINGLE_MODE: False
VOICE_IDENT: False
TS1_STATIC:
TS2_STATIC:
DEFAULT_REFLECTOR: 0
ANNOUNCEMENT_LANGUAGE: es_ES
GENERATOR: 2
ALLOW_UNREG_ID: True
PROXY_CONTROL: False
OVERRIDE_IDENT_TG:

[EchoTest]
MODE: PEER
ENABLED: True
LOOSE: True
EXPORT_AMBE: False
IP: 
#127.0.0.1
PORT: 49060
MASTER_IP: 127.0.0.1
MASTER_PORT: 49061
PASSPHRASE: passw0rd
CALLSIGN: ECHOTEST
RADIO_ID: 9990
RX_FREQ: 449000000
TX_FREQ: 444000000
TX_POWER: 25
COLORCODE: 1
SLOTS: 3
LATITUDE: 38.0000
LONGITUDE: -095.0000
HEIGHT: 75
LOCATION: Local Parrot
DESCRIPTION: This is a cool repeater
URL: www.w1abc.org
SOFTWARE_ID: 20170620
PACKAGE_ID: MMDVM_HBlink
GROUP_HANGTIME: 3
OPTIONS:
#TS2=9990;DIAL=0;VOICE=0;TIMER=0
USE_ACL: True
SUB_ACL: DENY:1
TGID_TS1_ACL: DENY:ALL
TGID_TS2_ACL: PERMIT:9990
TS1_STATIC:
TS2_STATIC:9990
DEFAULT_REFLECTOR: 0
ANNOUNCEMENT_LANGUAGE: en_GB
GENERATOR: 0
DEFAULT_UA_TIMER: 999
SINGLE_MODE: True
VOICE_IDENT: False

EOF
##
sudo sed -i 's/ALLOW_NULL_PASSPHRASE: True/ALLOW_NULL_PASSPHRASE: False/' /opt/FreeDMR/FreeDMR-SAMPLE.cfg
sudo sed -i 's/PASSPHRASE:/PASSPHRASE: passw0rd/' /opt/FreeDMR/FreeDMR-SAMPLE.cfg
sudo sed -i 's/ALLOW_NULL_PASSPHRASE: passw0rd False/ALLOW_NULL_PASSPHRASE: False/' /opt/FreeDMR/FreeDMR-SAMPLE.cfg

cp /opt/FreeDMR/FreeDMR-SAMPLE.cfg /opt/
cd /opt/
cat FreeDMR-SAMPLE.cfg conf.txt obp.txt >> /opt/FreeDMR/config/FreeDMR.cfg
#sudo sed -i 's/REPORT_CLIENTS: 127.0.0.1/REPORT_CLIENTS: */' /opt/FreeDMR/config/FreeDMR.cfg
sudo sed -i 's/file-timed/console-timed/' /opt/FreeDMR/config/FreeDMR.cfg
sudo sed -i 's/INFO/DEBUG/' /opt/FreeDMR/config/FreeDMR.cfg
sudo sed -i 's/freedmr.log/\/var\/log\/FreeDMR\/FreeDMR.log/' /opt/FreeDMR/config/FreeDMR.cfg
sudo sed -i 's/ANNOUNCEMENT_LANGUAGE: en_GB/ANNOUNCEMENT_LANGUAGE: es_ES/' /opt/FreeDMR/config/FreeDMR.cfg
sudo sed -i 's/VOICE_IDENT: True/VOICE_IDENT: False/' /opt/FreeDMR/config/FreeDMR.cfg
sudo sed -i "s/TGID_URL:/#TGID_URL:/g"  /opt/FreeDMR/config/FreeDMR.cfg 
sed '37 a TGID_URL: https://freedmr.cymru/talkgroups/talkgroup_ids_json.php' -i /opt/FreeDMR/config/FreeDMR.cfg 
#sed '43 a TOPO_FILE: topography.json' -i /opt/FreeDMR/config/FreeDMR.cfg

rm /opt/FreeDMR/conf.txt
cd /opt/FreeDMR/
mv loro.cfg /opt/FreeDMR/playback.cfg
sudo sed -i 's/54915/49061/' /opt/FreeDMR/playback.cfg
#sudo sed -i "121,129d" /opt/FreeDMR/playback.cfg
#
#sed '14 a VALIDATE_SERVER_IDS: True' -i /opt/FreeDMR/config/FreeDMR.cfg
#sed '105 a override_ident_tg:' -i /opt/FreeDMR/config/FreeDMR.cfg

#######lamp
sudo apt install mariadb-server php libapache2-mod-php php-zip php-mbstring php-cli php-common php-curl php-xml php-mysql -y

#sudo apt install apache2 -y
#systemctl restar apache2
#systemctl enable apache2
systemctl restart mariadb
systemctl enable mariadb
#sudo mysql_secure_installation  --host=localhost --port=3306
echo "DROP USER emqte1@localhost" | /usr/bin/mysql -u root
echo "DROP DATABASE selfcare" | /usr/bin/mysql -u root

newUser='emqte1'
newDbPassword=''
newDb='selfcare'
host=localhost
#host='%'

# MySQL 5.7 and earlier versions
#commands="CREATE DATABASE \`${newDb}\`;CREATE USER '${newUser}'@'${host}' IDENTIFIED BY '${newDbPassword}';GRANT USAGE ON *.* TO '${newUser}'@'${host}' IDENTIFIED BY '${newDbPassword}';GRANT ALL privileges ON \`${newDb}\`.* TO '${newUser}'@'${host}' IDENTIFIED BY '${newDbPassword}';FLUSH PRIVILEGES;"

# MySQL 8 and higher versions
commands="CREATE DATABASE \`${newDb}\`;CREATE USER '${newUser}'@'${host}' IDENTIFIED BY '${newDbPassword}';GRANT USAGE ON *.* TO '${newUser}'@'${host}';GRANT ALL ON \`${newDb}\`.* TO '${newUser}'@'${host}';FLUSH PRIVILEGES;"

#cho "${commands}" | /usr/bin/mysql -u root -p
echo "${commands}" | /usr/bin/mysql -u root
###########################################
#fdmr-monitor
cd /opt
sudo git clone https://github.com/yuvelq/FDMR-Monitor.git
cd FDMR-Monitor
sudo git checkout Self_Service
sudo sed -i 's/RELOAD_TIME = 15/RELOAD_TIME = 1/' /opt/FDMR-Monitor/fdmr-mon_SAMPLE.cfg
sudo sed -i 's/FREQUENCY = 10/FREQUENCY = 120/' /opt/FDMR-Monitor/fdmr-mon_SAMPLE.cfg
sudo chmod 644 /opt/FDMR-Monitor/fdmr-mon_SAMPLE.cfg
sed '33 a <!--' -i /opt/FDMR-Monitor/html/sysinfo.php
sed '35 a -->' -i /opt/FDMR-Monitor/html/sysinfo.php
####
sudo sed -i 's/localhost_2-day.png/localhost_1-day.png/' /opt/FDMR-Monitor/html/sysinfo.php
#sudo sed -i 's/var\/www\/html/opt\/FDMR-Monitor\/html/' cpu.sh
#sudo sed -i 's/var\/www\/html/opt\/FDMR-Monitor\/html/' graph.sh
sudo sed -i "s/HBMonv2/FDMR-Monitor/g"  /opt/FDMR-Monitor/sysinfo/*.sh


sudo chmod +x /opt/FDMR-Monitor/sysinfo/cpu.sh
sudo chmod +x /opt/FDMR-Monitor/sysinfo/graph.sh
sudo chmod +x /opt/FDMR-Monitor/sysinfo/rrd-db.sh
#
sudo cat > /opt/FDMR-Monitor/html/buttons.php <<- "EOF"
<!-- HBMonitor buttons HTML code -->
<a class="button" href="index.php">Home</a>
&nbsp;
<div class="dropdown">
  <button class="dropbtn">Links</button>
  <div class="dropdown-content">
&nbsp;
<a class="button" href="linkedsys.php">Linked Systems</a>
<a class="button" href="statictg.php">Static TG</a>
<a class="button" href="opb.php">OpenBridge</a>
&nbsp;
</div>
</div>
<div class="dropdown">
  <button class="dropbtn">Self Service</button>
  <div class="dropdown-content">
    <?php if(!PRIVATE_NETWORK){echo '<a class="button" href="selfservice.php">SelfService</a>';}?>
    <a class="button" href="login.php">Login</a>
    <?php 
    if(isset($_SESSION["auth"], $_SESSION["callsign"], $_SESSION["h_psswd"]) and $_SESSION["auth"]){
      echo '<a class="button" href="devices.php">Devices</a>';
    }
    ?>
  </div>
</div>
<div class="dropdown">
  <button class="dropbtn">Local Server</button>
  <div class="dropdown-content">
<a class="button" href="moni.php">&nbsp;Monitor&nbsp;</a>
&nbsp;
<a class="button" href="sysinfo.php">&nbsp;System Info&nbsp;</a>
&nbsp;
<a class="button" href="log.php">&nbsp;Lastheard&nbsp;</a>
&nbsp;
<a class="button" href="tgcount.php">&nbsp;TG Count&nbsp;</a>
&nbsp;
</div>
</div>
<div class="dropdown">
  <button class="dropbtn">FreeDMR</button>
  <div class="dropdown-content">
&nbsp;
<a class="button" href="http://www.freedmr.uk/index.php/why-use-freedmr/"target="_blank">&nbsp;Info FreeDMR&nbsp;</a>
&nbsp;
<a class="button" href="http://www.freedmr.uk/index.php/freedmr-servers/"target="_blank">&nbsp;Info Server&nbsp;</a>
&nbsp;
<a class="button" href="http://www.freedmr.uk/server_test.php"target="_blank">&nbsp;Status Server&nbsp;</a>
&nbsp;
<a class="button" href="http://www.freedmr.uk/index.php/world-wide-talk-groups/"target="_blank">&nbsp;World Wide Talk Groups&nbsp;</a>
&nbsp;
<a class="button" href="http://www.freedmr.uk/freedmr/option-calculator-b.php"target="_blank">&nbsp;Static TG Calculator&nbsp;</a>
&nbsp;
</div>
</div>
<!--
<a class="button" href="bridges.php">Bridges</a>
-->
<!-- Example of buttons dropdown HTML code -->
<!--
<div class="dropdown">
  <button class="dropbtn">Admin Area</button>
  <div class="dropdown-content">
    <a href="masters.php">Master&Peer</a>
    <a href="opb.php">OpenBridge</a>
    <a href="moni.php">Monitor</a>
  </div>
</div>
<div class="dropdown">
  <button class="dropbtn">Reflectors</button>
  <div class="dropdown-content">
    <a target='_blank' href="#">YSF Reflector</a>
    <a target='_blank' href="#">XLX950</a>
  </div>
</div>
-->
EOF

#

sudo systemctl daemon-reload

sudo chmod +x /opt/extra-2.sh
sudo sh /opt/extra-2.sh
sudo sed -i "s/root/emqte1/g"  /opt/FDMR-Monitor/fdmr-mon_SAMPLE.cfg
sudo sed -i "s/test/selfcare/g"  /opt/FDMR-Monitor/fdmr-mon_SAMPLE.cfg
sudo sed -i "s/PRIVATE_NETWORK = True/PRIVATE_NETWORK = False/g"  /opt/FDMR-Monitor/fdmr-mon_SAMPLE.cfg
sudo sed -i "s/TGID_URL =/#TGID_URL =/g"  /opt/FDMR-Monitor/fdmr-mon_SAMPLE.cfg
sed '63 a TGID_URL = https://freedmr.cymru/talkgroups/talkgroup_ids_json.php' -i /opt/FDMR-Monitor/fdmr-mon_SAMPLE.cfg
sed '64 a #TGID_URL = https://freedmr.cymru/talkgroups/talkgroup_ids_flags_json.php' -i /opt/FDMR-Monitor/fdmr-mon_SAMPLE.cfg
cd /opt/FDMR-Monitor/
sudo rm /opt/FDMR-Monitor/install.sh
wget https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/self/install.sh
sudo chmod +x /opt/FDMR-Monitor/install.sh
sudo chmod +x /opt/FDMR-Monitor/*.py
#
sh /opt/FDMR-Monitor/install.sh
sudo sh /opt/extra-2.sh
#####################
sudo sed -i "s/All rights reserved.<br>.*/All rights reserved.<br><a title=\"Raspbian Proyect by HP3ICC © <?php \$cdate=date(\"Y\"); if (\$cdate > \"2018\") {\$cdate=\"2018-\".date(\"Y\");} echo \$cdate; ?>\" target=\"_blank\" href=https:\/\/github.com\/hp3icc\/Easy-FreeDMR-SERVER-Install\/>Proyect: Easy-FreeDMR-SERVER-Install<\/a><br>/g" /var/www/fdmr/*.php
sudo sed -i "s/root/emqte1/g"  /opt/FreeDMR/hotspot_proxy_v2.py
sudo sed -i "s/test/selfcare/g"  /opt/FreeDMR/hotspot_proxy_v2.py
sudo sed -i "s/\/freedmr.cfg/\/config\/FreeDMR.cfg/g"  /opt/FreeDMR/hotspot_proxy_v2.py
sudo sed -i "s/test/selfcare/g"  /opt/FreeDMR/proxy_db.py
sudo sed -i "s/root/emqte1/g"  /opt/FreeDMR/proxy_db.py
#
sudo sed -i "s/root/emqte1/g"  /opt/FreeDMR/proxy.cfg
sudo sed -i "s/test/selfcare/g"  /opt/FreeDMR/proxy.cfg
#sudo sed -i "56,63d" /opt/FreeDMR/config/FreeDMR.cfg
#################

#sed '33 a <!--' -i /var/www/html/sysinfo.php
#sed '35 a -->' -i /var/www/html/sysinfo.php

cp -r /opt/FDMR-Monitor/sysinfo/ /var/www/fdmr/sysinfo/

#########
sudo cat > /opt/FreeDMR/config/rules.py <<- "EOF"
'''
THIS EXAMPLE WILL NOT WORK AS IT IS - YOU MUST SPECIFY YOUR OWN VALUES!!!

In FreeDMR, the rules file should be *empty* unless you have static routing required. Please see the 
documentation for more details.

This file is organized around the "Conference Bridges" that you wish to use. If you're a c-Bridge
person, think of these as "bridge groups". You might also liken them to a "reflector". If a particular
system is "ACTIVE" on a particular conference bridge, any traffid from that system will be sent
to any other system that is active on the bridge as well. This is not an "end to end" method, because
each system must independently be activated on the bridge.

The first level (e.g. "WORLDWIDE" or "STATEWIDE" in the examples) is the name of the conference
bridge. This is any arbitrary ASCII text string you want to use. Under each conference bridge
definition are the following items -- one line for each HBSystem as defined in the main HBlink
configuration file.

    * SYSTEM - The name of the sytem as listed in the main hblink configuration file (e.g. hblink.cfg)
        This MUST be the exact same name as in the main config file!!!
    * TS - Timeslot used for matching traffic to this confernce bridge
        XLX connections should *ALWAYS* use TS 2 only.
    * TGID - Talkgroup ID used for matching traffic to this conference bridge
        XLX connections should *ALWAYS* use TG 9 only.
    * ON and OFF are LISTS of Talkgroup IDs used to trigger this system off and on. Even if you
        only want one (as shown in the ON example), it has to be in list format. None can be
        handled with an empty list, such as " 'ON': [] ".
    * TO_TYPE is timeout type. If you want to use timers, ON means when it's turned on, it will
        turn off afer the timout period and OFF means it will turn back on after the timout
        period. If you don't want to use timers, set it to anything else, but 'NONE' might be
        a good value for documentation!
    * TIMOUT is a value in minutes for the timout timer. No, I won't make it 'seconds', so don't
        ask. Timers are performance "expense".
    * RESET is a list of Talkgroup IDs that, in addition to the ON and OFF lists will cause a running
        timer to be reset. This is useful   if you are using different TGIDs for voice traffic than
        triggering. If you are not, there is NO NEED to use this feature.
'''

BRIDGES = {

 '9990': [ 
	{'SYSTEM': 'EchoTest', 		'TS': 2, 'TGID': 9990, 'ACTIVE':True, 'TIMEOUT': 0, 'TO_TYPE': 'NONE', 'ON': [], 'OFF': [], 'RESET': []}, 

	],


}
if __name__ == '__main__':
    from pprint import pprint
    pprint(BRIDGES)

EOF
##########################

sudo cat > /lib/systemd/system/proxy.service <<- "EOF"
[Unit]
Description= Proxy Service 

After=multi-user.target


[Service]
User=root
Type=simple
Restart=always
RestartSec=3
StandardOutput=null
ExecStartPre=/bin/sh -c 'until ping -c1 noip.com; do sleep 1; done;'
#WorkingDirectory=/opt/FreeDMR
#ExecStart=/usr/bin/python3 /opt/FreeDMR/hotspot_proxy_v2.py
ExecStart=/usr/bin/python3 /opt/FreeDMR/hotspot_proxy_v2.py -c /opt/FreeDMR/proxy.cfg

[Install]
WantedBy=multi-user.target

EOF
#########
sudo cat > /lib/systemd/system/freedmr.service <<- "EOF"
[Unit]
Description=FreeDmr
After=multi-user.target

[Service]
User=root
Type=simple
Restart=always
RestartSec=3
StandardOutput=null
ExecStartPre=/bin/sh -c 'until ping -c1 noip.com; do sleep 1; done;'
ExecStart=/usr/bin/python3 /opt/FreeDMR/bridge_master.py -c /opt/FreeDMR/config/FreeDMR.cfg -r /opt/FreeDMR/config/rules.py

[Install]
WantedBy=multi-user.target

EOF
###
sudo cat > /lib/systemd/system/fdmrparrot.service <<- "EOF"
[Unit]

Description=Freedmr Parrot

After=network-online.target syslog.target

Wants=network-online.target

[Service]

StandardOutput=null

WorkingDirectory=/opt/FreeDMR

RestartSec=3

ExecStart=/usr/bin/python3 /opt/FreeDMR/playback.py -c /opt/FreeDMR/playback.cfg
#/usr/bin/python3 /opt/HBlink3/playback.py -c /opt/HBlink3/playback.cfg

Restart=on-abort

[Install]

WantedBy=multi-user.target

EOF
##############################

sudo systemctl stop rsyslog
sudo systemctl disable rsyslog
sudo systemctl disable systemd-networkd-wait-online.service
sudo systemctl disable dphys-swapfile-back.service
mv /lib/systemd/system/dphys-swapfile.service /lib/systemd/system/dphys-swapfile-back.service
rm /var/log/syslog*
rm /var/log/*.log*

(crontab -l; echo "* */1 * * * sync ; echo 3 > /proc/sys/vm/drop_caches >/dev/null 2>&1")|awk '!x[$0]++'|crontab -
sh -c "$(curl -fsSL https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/self/data-id-update.sh)"
data-id
#####
sudo update-rc.d dphys-swapfile remove
sudo chmod -x /etc/init.d/dphys-swapfile
sudo dphys-swapfile swapoff
sudo swapoff -a
sudo rm /var/swap
sudo dphys-swapfile uninstall
cd /etc/
sudo sed -i 's/CONF_SWAPSIZE=100/CONF_SWAPSIZE=0/' dphys-swapfile
cd /
##################
sudo systemctl daemon-reload
systemctl start freedmr.service
systemctl enable freedmr.service
systemctl start proxy.service
systemctl enable proxy.service
systemctl start fdmrparrot.service
systemctl enable fdmrparrot.service
#################
if [ -f "/opt/FDMR-Monitor/sysinfo/tempC.rrd" ]
then
  rm /opt/FDMR-Monitor/sysinfo/*.rrd
elif
  [ -f "/opt/FDMR-Monitor/sysinfo/load.rrd" ]
then
  rm /opt/FDMR-Monitor/sysinfo/*.rrd
elif
  [ -f "/opt/FDMR-Monitor/sysinfo/hdd.rrd" ]
then
  rm /opt/FDMR-Monitor/sysinfo/*.rrd
fi

sh /opt/FDMR-Monitor/sysinfo/rrd-db.sh
######################
(crontab -l; echo "*/5 * * * * sh /opt/FDMR-Monitor/sysinfo/graph.sh")|awk '!x[$0]++'|crontab -
(crontab -l; echo "*/2 * * * * sh /opt/FDMR-Monitor/sysinfo/cpu.sh")|awk '!x[$0]++'|crontab -
(crontab -l; echo "* */24 * * * data-id")|awk '!x[$0]++'|crontab -

sudo systemctl enable fdmr_mon.service
#sudo systemctl restart apache2.service
#sudo systemctl enable apache2.service
sudo systemctl start fdmr_mon.service
sudo systemctl restart http.server-fdmr.service
sudo systemctl enable http.server-fdmr.service
chmod +x /bin/menu*
chmod +x /bin/MENU
history -c && history -w
menu
#####

