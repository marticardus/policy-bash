DOMAIN=$(echo $recipient|cut -d@ -f2)
BLISTUSER=$($MYSQL "SELECT 'OK' AS whitelisted FROM wblist WHERE sender='$sender' AND rcpt='$recipient' AND blacklisted!=1 AND enabled=1"|grep -v whitelisted)
BLISTDOM=$($MYSQL "SELECT 'OK' AS whitelisted FROM wblist WHERE sender='$sender' AND rcpt='$DOMAIN' AND blacklisted!=1 AND enabled=1)"|grep -v whitelisted)
BLISTALL=$($MYSQL "SELECT 'OK' AS whitelisted FROM wblist WHERE sender='$sender' AND rcpt='ALL' AND blacklisted!=1 AND enabled=1"|grep -v whitelisted)


DOMAINSENDER=$(echo $sender|cut -d@ -f2)
BLISTDOMU=$($MYSQL "SELECT 'OK' AS whitelisted FROM wblist WHERE sender='$DOMAINSENDER' AND rcpt='$recipient' AND blacklisted!=1 AND enabled=1"|grep -v whitelisted)
BLISTDOMDOM=$($MYSQL "SELECT 'OK' AS whitelisted FROM wblist WHERE sender='$DOMAINSENDER' AND rcpt='$DOMAIN' AND blacklisted!=1 AND enabled=1"|grep -v whitelisted)
BLISTDOMALL=$($MYSQL "SELECT 'OK' AS whitelisted FROM wblist WHERE sender='$DOMAINSENDER' AND rcpt='ALL' AND blacklisted!=1 AND enabled=1"|grep -v whitelisted)

BLISTRCPT=$(${MYSQL} "SELECT 'OK' AS whitelisted FROM wblist WHERE sender='ALL' AND rcpt='$recipient' AND blacklisted!=1 AND enabled=1"|grep -v whitelisted)

if [ -n "$BLISTUSER" ]; then
	accept
elif [ -n "$BLISTDOM" ]; then
	accept
elif [ -n "$BLISTALL" ]; then
	accept
elif [ -n "$BLISTDOMU" ]; then
	accept
elif [ -n "$BLISTDOMDOM" ]; then
	accept
elif [ -n "$BLISTDOMALL" ]; then
	accept
elif [ -n "$BLISTRCPT" ]; then
	accept
fi
