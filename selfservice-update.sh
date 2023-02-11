#!/bin/sh
if [ -f "/var/www/html/tgcount.php" ];
then
   sudo systemctl stop apache2
 #echo "found file"
else
 echo "file not found"

fi
if [ -f "/var/www/html/tgcount.php" ];
then
   sudo systemctl disable apache2
 #echo "found file"
else
 echo "file not found"

fi
if [ -f "/var/www/html/tgcount.php" ];
then
   sudo rm /var/www/html/* -r
 #echo "found file"
else
 echo "file not found"

fi
if [ -d "/var/www/fdmr" ];
then
   sudo rm /var/www/fdmr/ -r
 #echo "found file"
else
 echo "file not found"

fi
sudo systemctl stop fdmr_mon.service
sudo systemctl stop proxy.service
sudo systemctl stop http.server-fdmr.service
sudo rm -r /opt/FDMR-Monitor/
#
cd /opt
sudo git clone https://github.com/hp3icc/FDMR-Monitor.git
cd FDMR-Monitor
sudo git checkout Self_Service
sudo chmod +x install.sh

sudo sed -i 's/RELOAD_TIME = 15/RELOAD_TIME = 1/' /opt/FDMR-Monitor/fdmr-mon_SAMPLE.cfg
#sudo cp utils/logrotate/fdmr_mon /etc/logrotate.d/
rm /etc/logrotate.d/fdmr_mon
rm /lib/systemd/system/fdmr_mon.service
#sudo cp utils/systemd/fdmr_mon.service /lib/systemd/system/
sudo sed -i 's/FREQUENCY = 10/FREQUENCY = 120/' /opt/FDMR-Monitor/fdmr-mon_SAMPLE.cfg
sudo chmod 644 /opt/FDMR-Monitor/fdmr-mon_SAMPLE.cfg
sed '33 a <!--' -i /opt/FDMR-Monitor/html/sysinfo.php
sed '35 a -->' -i /opt/FDMR-Monitor/html/sysinfo.php
####
sudo sed -i "s/www\/html/www\/fdmr/g" /opt/FDMR-Monitor/html/*.*
sudo sed -i "s/www\/html/www\/fdmr/g" /opt/FDMR-Monitor/sysinfo/*.*
####
sudo sed -i 's/localhost_2-day.png/localhost_1-day.png/' /opt/FDMR-Monitor/html/sysinfo.php
sudo sed -i "s/HBMonv2/FDMR-Monitor/g"  /opt/FDMR-Monitor/sysinfo/*.sh
sudo chmod +x /opt/FDMR-Monitor/sysinfo/cpu.sh
sudo chmod +x /opt/FDMR-Monitor/sysinfo/graph.sh
sudo chmod +x /opt/FDMR-Monitor/sysinfo/rrd-db.sh

#sudo chmod +x /opt/FDMR-Monitor/updateTGIDS.sh
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
sudo chmod +x /opt/extra-2.sh
sudo sh /opt/extra-2.sh
sudo sed -i "s/root/emqte1/g"  /opt/FDMR-Monitor/fdmr-mon_SAMPLE.cfg
sudo sed -i "s/test/selfcare/g"  /opt/FDMR-Monitor/fdmr-mon_SAMPLE.cfg
sudo sed -i "s/PRIVATE_NETWORK = True/PRIVATE_NETWORK = False/g"  /opt/FDMR-Monitor/fdmr-mon_SAMPLE.cfg
sudo sed -i "s/TGID_URL =/#TGID_URL =/g"  /opt/FDMR-Monitor/fdmr-mon_SAMPLE.cfg
sed '63 a TGID_URL = https://freedmr.cymru/talkgroups/talkgroup_ids_json.php' -i /opt/FDMR-Monitor/fdmr-mon_SAMPLE.cfg
sed '64 a #TGID_URL = https://freedmr.cymru/talkgroups/talkgroup_ids_flags_json.php' -i /opt/FDMR-Monitor/fdmr-mon_SAMPLE.cfg
sudo rm /opt/FDMR-Monitor/data/*
cd /opt/FDMR-Monitor/
sudo rm /opt/FDMR-Monitor/install.sh
wget https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/self/install.sh
chmod +x /opt/FDMR-Monitor/install.sh
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
#################
#sh /opt/FDMR-Monitor/sysinfo/rrd-db.sh
#rm /opt/FDMR-Monitor/sysinfo/*.rrd 
sh /opt/FDMR-Monitor/sysinfo/rrd-db.sh
#sed '33 a <!--' -i /var/www/html/sysinfo.php
#sed '35 a -->' -i /var/www/html/sysinfo.php

cp -r /opt/FDMR-Monitor/sysinfo/ /var/fdmr/html/sysinfo/
sh -c "$(curl -fsSL https://raw.githubusercontent.com/hp3icc/Easy-FreeDMR-SERVER-Install/main/menu.sh)"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/hp3icc/emq-TE1ws/main/self/data-id-update.sh)"
data-id
#sudo rm mon.db
#sudo python3 mon_db.py
sudo systemctl daemon-reload	
sudo systemctl start proxy.service
sudo systemctl start fdmr_mon.service
sudo systemctl enable fdmr_mon.service
sudo systemctl start http.server-fdmr.service
sudo systemctl enable http.server-fdmr.service
