DOMAIN=$(echo $recipient|cut -d@ -f2)
BLISTUSER=$(pbsql "SELECT 'OK' AS whitelisted FROM wblist WHERE sender='$sender' AND rcpt='$recipient' AND blacklisted!=1 AND enabled=1")
BLISTDOM=$(pbsql "SELECT 'OK' AS whitelisted FROM wblist WHERE sender='$sender' AND rcpt='$DOMAIN' AND blacklisted!=1 AND enabled=1)")
BLISTALL=$(pbsql "SELECT 'OK' AS whitelisted FROM wblist WHERE sender='$sender' AND rcpt='ALL' AND blacklisted!=1 AND enabled=1")


DOMAINSENDER=$(echo $sender|cut -d@ -f2)
BLISTDOMU=$(pbsql "SELECT 'OK' AS whitelisted FROM wblist WHERE sender='$DOMAINSENDER' AND rcpt='$recipient' AND blacklisted!=1 AND enabled=1")
BLISTDOMDOM=$(pbsql "SELECT 'OK' AS whitelisted FROM wblist WHERE sender='$DOMAINSENDER' AND rcpt='$DOMAIN' AND blacklisted!=1 AND enabled=1")
BLISTDOMALL=$(pbsql "SELECT 'OK' AS whitelisted FROM wblist WHERE sender='$DOMAINSENDER' AND rcpt='ALL' AND blacklisted!=1 AND enabled=1")

BLISTRCPT=$(pbsql "SELECT 'OK' AS whitelisted FROM wblist WHERE sender='ALL' AND rcpt='$recipient' AND blacklisted!=1 AND enabled=1")

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
