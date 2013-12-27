DOMAIN=$(echo $recipient|cut -d@ -f2)
BLISTUSER=$(pbsql "SELECT reject FROM wblist WHERE sender='$sender' AND rcpt='$recipient' AND blacklisted=1 AND enabled=1")
BLISTDOM=$(pbsql "SELECT reject FROM wblist WHERE sender='$sender' AND rcpt='$DOMAIN' AND blacklisted=1 AND enabled=1")
BLISTALL=$(pbsql "SELECT reject FROM wblist WHERE sender='$sender' AND rcpt='ALL' AND blacklisted=1 AND enabled=1")

DOMAINSENDER=$(echo $sender|cut -d@ -f2)
BLISTDOMU=$(pbsql "SELECT reject FROM wblist WHERE sender='$DOMAINSENDER' AND rcpt='$recipient' AND blacklisted=1 AND enabled=1")
BLISTDOMDOM=$(pbsql "SELECT reject FROM wblist WHERE sender='$DOMAINSENDER' AND rcpt='$DOMAIN' AND blacklisted=1 AND enabled=1")
BLISTDOMALL=$(pbsql "SELECT reject FROM wblist WHERE sender='$DOMAINSENDER' AND rcpt='ALL' AND blacklisted=1 AND enabled=1")
BLISTRCPT=$(pbsql "SELECT reject FROM wblist WHERE sender='ALL' AND rcpt='$recipient' AND blacklisted=1 AND enabled=1")

if [ -n "$BLISTUSER" ]; then
	reject "$BLISTUSER"
elif [ -n "$BLISTDOM" ]; then
	reject "$BLISTDOM"
elif [ -n "$BLISTALL" ]; then
	reject "$BLISTALL"
elif [ -n "$BLISTDOMU" ]; then
	reject "$BLISTDOMU"
elif [ -n "$BLISTDOMDOM" ]; then
	reject "$BLISTDOMDOM"
elif [ -n "$BLISTDOMALL" ]; then
	reject "$BLISTDOMALL"
elif [ -n "$BLISTRCPT" ]; then
	reject "$BLISTRCPT"
fi
