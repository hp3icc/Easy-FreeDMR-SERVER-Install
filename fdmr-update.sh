cd /
variable=$(grep "SERVER_ID:" /opt/FreeDMR/config/FreeDMR.cfg | tail -c 5)
sudo systemctl stop freedmr.service
sudo systemctl stop proxy.service
rm -r /opt/FreeDMR
cd /opt
git clone https://gitlab.hacknix.net/hacknix/FreeDMR.git
cd FreeDMR
mkdir config
mkdir /var/log/FreeDMR
chmod +x /opt/FreeDMR/install.sh
./install.sh
sudo cat > /opt/conf.txt <<- "EOF"
  
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
sudo sed -i 's/file-timed/console-timed/' /opt/FreeDMR/config/FreeDMR.cfg
sudo sed -i 's/INFO/DEBUG/' /opt/FreeDMR/config/FreeDMR.cfg
sudo sed -i 's/freedmr.log/\/var\/log\/FreeDMR\/FreeDMR.log/' /opt/FreeDMR/config/FreeDMR.cfg
sudo sed -i 's/ANNOUNCEMENT_LANGUAGE: en_GB/ANNOUNCEMENT_LANGUAGE: es_ES/' /opt/FreeDMR/config/FreeDMR.cfg
sudo sed -i 's/VOICE_IDENT: True/VOICE_IDENT: False/' /opt/FreeDMR/config/FreeDMR.cfg
sudo sed -i "s/SERVER_ID: 0000/SERVER_ID: $variable/g"  /opt/FreeDMR/config/FreeDMR.cfg
#sudo sed -i 's/REPORT_CLIENTS: 127.0.0.1/REPORT_CLIENTS: */' /opt/FreeDMR/config/FreeDMR.cfg
sudo sed -i "s/TGID_URL:/#TGID_URL:/g"  /opt/FreeDMR/config/FreeDMR.cfg 
sed '37 a TGID_URL: https://freedmr.cymru/talkgroups/talkgroup_ids_json.php' -i /opt/FreeDMR/config/FreeDMR.cfg 
rm /opt/conf.txt
#rm /opt/obp.txt
cd /opt/FreeDMR/
mv loro.cfg /opt/FreeDMR/playback.cfg
sudo sed -i 's/54915/49061/' /opt/FreeDMR/playback.cfg
######
cat /opt/rules.txt >> /opt/FreeDMR/config/rules.py
sed '14 a VALIDATE_SERVER_IDS: True' -i /opt/FreeDMR/config/FreeDMR.cfg
sed '105 a override_ident_tg:' -i /opt/FreeDMR/config/FreeDMR.cfg
sudo rm /opt/FreeDMR/hotspot_proxy_v2.py
#sudo rm /opt/FreeDMR/proxy_db.*
cp /opt/FDMR-Monitor/proxy/* /opt/FreeDMR/ -r
#####################
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
#
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
ExecStart=/usr/bin/python3 /opt/FreeDMR/hotspot_proxy_v2.py

[Install]
WantedBy=multi-user.target

EOF
##
sudo sed -i "s/root/emqte1/g"  /opt/FreeDMR/hotspot_proxy_v2.py
sudo sed -i "s/test/selfcare/g"  /opt/FreeDMR/hotspot_proxy_v2.py
sudo sed -i "s/\/freedmr.cfg/\/config\/FreeDMR.cfg/g"  /opt/FreeDMR/hotspot_proxy_v2.py
sudo sed -i "s/test/selfcare/g"  /opt/FreeDMR/proxy_db.py
sudo sed -i "s/root/emqte1/g"  /opt/FreeDMR/proxy_db.py
#
sudo sed -i "s/root/emqte1/g"  /opt/FreeDMR/proxy.cfg
sudo sed -i "s/test/selfcare/g"  /opt/FreeDMR/proxy.cfg
###
sudo chmod +x /opt/FreeDMR/*.py
sudo chmod +x /opt/FreeDMR/config/*.py
rm /opt/FreeDMR-SAMPLE.cfg 
sudo chmod +x /opt/extra-1.sh
sudo sh /opt/extra-1.sh
sudo systemctl daemon-reload
sudo systemctl start proxy.service
sudo systemctl start freedmr.service
sudo systemctl restart fdmrparrot.service
# ExecStart=/usr/bin/python3 /opt/FreeDMR/bridge_master.py -c /opt/FreeDMR/config/FreeDMR.cfg -r /opt/FreeDMR/config/rules.py

# ExecStart=/usr/bin/python3 /opt/FreeDMR/playback.py -c /opt/FreeDMR/playback.cfg

# 	

cd /
