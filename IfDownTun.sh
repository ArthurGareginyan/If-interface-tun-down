#!/bin/sh
#################################################################
#   Name:        IfDownTun                                      #
#   Description: Check and start iinterface tun if it down      #
#   Author:      Arthur Gareginyan aka Berserkr                 #
#   Author URI:  http://mycyberuniverse.com/author.html         #
#   Email:       arthurgareginyan@gmail.com                     #
#   License:     GNU General Public License, version 3 (GPLv3)  #
#   License URI: http://www.gnu.org/licenses/gpl-3.0.html       #
#   Usage:       chmod +x IfDownTun.sh                          #
#   Run:         ./IfDownTun.sh                                 #
#################################################################
 
# The interface to test
DEVICE='tun'
#TEST_IFACE=`/sbin/ip link show dev $DEVICE >/dev/null 2>/dev/null`
 
# Check the availability of an interfac
/sbin/ip link show dev $DEVICE >/dev/null 2>/dev/null
 
# Raising of the interface tun if not raised
if [ "$?" = "1" ] ; then
        if [ ! -f /tmp/iface_tun.error ] ; then
            echo "$(date '+%F(%H:%M)') iface tun DOWN" >> /var/log/iface_tun.log
            touch /tmp/iface_tun.error
        fi
        killall gogoc ;
        service gogoc start ;
        sleep 10
 
        # Again checking and recording info in /var/log/iface_tun.log when success
        /sbin/ip link show dev $DEVICE >/dev/null 2>/dev/null
        if [ "$?" = "0" ] ; then
                echo "$(date '+%F(%H:%M)') iface tun UP" >> /var/log/iface_tun.log
                rm /tmp/iface_tun.error
                exit 0
        fi
fi
 
exit 0
