#!/bin/bash
#Module purpose
#==============
#
# Check the status of Zone A,b & C on Somfy Alarm System
#
#Implements
#==========
#
PATH=$PATH:/usr/bin/

if [[ $# != 1 ]]; then echo "Usage: $0 MONTEE/DESCENTE/STOP" ; exit 1; fi
if [[ $1 != "MONTEE" && $1 != "DESCENTE" && $1 != "STOP" ]]; then echo "Usage: $0 MONTEE/DESCENTE/STOP" ; exit 1; fi
if [[ $1 == "MONTEE" ]]; then button="btn_vol_up"; fi 
if [[ $1 == "DESCENTE" ]]; then button="btn_vol_down"; fi
if [[ $1 == "STOP" ]]; then button="btn_vol_stop"; fi
#

AuthentA1="<replace_by_somfy_card_value>"; AuthentB1="<replace_by_somfy_card_value>"; AuthentC1="<replace_by_somfy_card_value>"; AuthentD1="<replace_by_somfy_card_value>"; AuthentE1="<replace_by_somfy_card_value>"; AuthentF1="<replace_by_somfy_card_value>"; AuthentA2="<replace_by_somfy_card_value>"; AuthentB2="<replace_by_somfy_card_value>"; AuthentC2="<replace_by_somfy_card_value>"; AuthentD2="<replace_by_somfy_card_value>"; AuthentE2="<replace_by_somfy_card_value>"; AuthentF2="<replace_by_somfy_card_value>"; AuthentA3="<replace_by_somfy_card_value>"; AuthentB3="<replace_by_somfy_card_value>"; AuthentC3="<replace_by_somfy_card_value>"; AuthentD3="<replace_by_somfy_card_value>"; AuthentE3="<replace_by_somfy_card_value>"; AuthentF3="<replace_by_somfy_card_value>"; AuthentA4="<replace_by_somfy_card_value>"; AuthentB4="<replace_by_somfy_card_value>"; AuthentC4="<replace_by_somfy_card_value>"; AuthentD4="<replace_by_somfy_card_value>"; AuthentE4="<replace_by_somfy_card_value>"; AuthentF4="<replace_by_somfy_card_value>"; AuthentA5="<replace_by_somfy_card_value>"; AuthentB5="<replace_by_somfy_card_value>"; AuthentC5="<replace_by_somfy_card_value>"; AuthentD5="<replace_by_somfy_card_value>"; AuthentE5="<replace_by_somfy_card_value>"; AuthentF5="<replace_by_somfy_card_value>"



SPip="http://192.168.1.30:80/fr/" # IP Defaut: http://192.168.1.2/
SimpleSPip="http://192.168.1.30:80/" # IP Defaut: http://192.168.1.2/
SPpass=<user1id> 
#------------------------------------------------
fromSP=$(/usr/bin/wget -O - http://192.168.1.30:80 2>/dev/null | /usr/bin/perl -nle 's%.*<b>(.*?)</b>.*%$1% and print')


if  [ "$fromSP" = "(0x0902)" ]; then
        echo "Somfy Protexion Busy... Try Again Later"
	echo "Error Code="$fromSP
else
        key=$(eval /usr/bin/expr \$Authent$fromSP)
	varWget="login=u&password="$SPpass"&key="$key"&btn_login=Connexion"
	#echo $varWget
	varlogin=$SPip"m_login.htm"
	varmupilotage=$SPip"mu_pilotage.htm"
	varlogout=$SimpleSPip"m_logout.htm"
	#echo $varlogin" "$varmuetat" "$varlogout
	wget -O - --cookies=on --keep-session-cookies --save-cookies=cookie.txt --post-data "$varWget" $varlogin 2>/dev/null > /dev/null
	wget -O - --referer=$varlogin --cookies=on --load-cookies=cookie.txt --keep-session-cookies --save-cookies=cookie.txt $varmupilotage 2>/dev/null > temphtml
	wget -O - --referer=$varmupilotage --cookies=on --load-cookies=cookie.txt --keep-session-cookies --save-cookies=cookie.txt --post-data "${button}=$1" $varmupilotage 2>/dev/null > tempdescente
	wget -O - --referer=$varmupilotage --cookies=on --load-cookies=cookie.txt --keep-session-cookies --save-cookies=cookie.txt $varlogout 2>/dev/null > /dev/null
fi

