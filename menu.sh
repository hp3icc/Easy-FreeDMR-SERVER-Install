sudo cat > /bin/menu <<- "EOF"
#!/bin/bash
while : ; do
choix=$(whiptail --title "Raspbian Proyect HP3ICC EasyFreeDMR" --menu "move up or down with the keyboard arrows and select your option by pressing enter:" 23 56 13 \
1 " Edit FreeDMR Server " \
2 " Edit Interlink  " \
3 " Edit FDMR-Monitor  " \
4 " Edit Port HTTP  " \
5 " Parrot on  " \
6 " Parrot off  " \
7 " Restart FreeDMR Server  " \
8 " Restart FDMR-Monitor " \
9 " Menu update " 3>&1 1>&2 2>&3)
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
sudo nano /lib/systemd/system/http.server-fdmr.service  && systemctl daemon-reload && systemctl restart http.server-fdmr.service ;;
5)
sudo systemctl stop fdmrparrot.service && sudo systemctl start fdmrparrot.service && sudo systemctl enable fdmrparrot.service ;;
6)
sudo systemctl stop fdmrparrot.service &&  sudo systemctl disable fdmrparrot.service ;;
7)
sudo systemctl stop proxy.service && sudo systemctl start proxy.service && sudo systemctl enable proxy.service && sudo systemctl stop freedmr.service && sudo systemctl start freedmr.service && sudo systemctl enable freedmr.service ;;
8)
sudo systemctl stop fdmr_mon.service && sudo rm /opt/FDMR-Monitor/sysinfo/*.rrd && sh /opt/FDMR-Monitor/sysinfo/rrd-db.sh && cronedit.sh '*/5 * * * *' 'sh /opt/FDMR-Monitor/sysinfo/graph.sh' add && cronedit.sh '*/2 * * * *' 'sh /opt/FDMR-Monitor/sysinfo/cpu.sh' add && sudo systemctl enable fdmr_mon.service && sudo systemctl restart http.server-fdmr.service && sudo systemctl enable http.server-fdmr.service && sudo systemctl start fdmr_mon.service;;
9)
sh -c "$(curl -fsSL https://github.com/hp3icc/Easy-FreeDMR-SERVER-Install/raw/main/update.sh)";
esac
done
exit 0
EOF
###
chmod +x /bin/menu
ln -s /bin/menu /bin/MENU
