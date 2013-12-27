DOMAIN=$(echo $recipient|cut -d@ -f2)
BLISTUSER=$($MYSQL "SELECT reject FROM wblist WHERE sender='$sender' AND rcpt='$recipient' AND blacklisted=1 AND enabled=1"|grep -v reject)
BLISTDOM=$($MYSQL "SELECT reject FROM wblist WHERE sender='$sender' AND rcpt='$DOMAIN' AND blacklisted=1 AND enabled=1"|grep -v reject)
BLISTALL=$($MYSQL "SELECT reject FROM wblist WHERE sender='$sender' AND rcpt='ALL' AND blacklisted=1 AND enabled=1"|grep -v reject)


DOMAINSENDER=$(echo $sender|cut -d@ -f2)
BLISTDOMU=$($MYSQL "SELECT reject FROM wblist WHERE sender='$DOMAINSENDER' AND rcpt='$recipient' AND blacklisted=1 AND enabled=1"|grep -v reject)
BLISTDOMDOM=$($MYSQL "SELECT reject FROM wblist WHERE sender='$DOMAINSENDER' AND rcpt='$DOMAIN' AND blacklisted=1 AND enabled=1"|grep -v reject)
BLISTDOMALL=$($MYSQL "SELECT reject FROM wblist WHERE sender='$DOMAINSENDER' AND rcpt='ALL' AND blacklisted=1 AND enabled=1"|grep -v reject)

BLISTRCPT=$(${MYSQL} "SELECT reject FROM wblist WHERE sender='ALL' AND rcpt='$recipient' AND blacklisted=1 AND enabled=1"|grep -v reject)

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
