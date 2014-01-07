if [ -f $POLICYCONF/policies/$POLICYNAME ] ; then
	source $POLICYCONF/policies/$POLICYNAME
else
	MAXBOUNCE=2
fi

NOW=$(date +%s)
domain=$(echo $recipient|cut -d@ -f2)

SPAMMER=$(pbsql "SELECT IF(count_rcpt>count_eod+$MAXBOUNCE,'spammer','') FROM verify_info_domains WHERE domain='$domain'")
if [ "$SPAMMER" = "spammer" ]; then
	warn "Aquest usuari sembla que fa spam"
fi
pbsql "INSERT INTO verify_info_mbox (sender,recipient,count,instance,created) VALUES ('$sender','$recipient',0,'$instance',$NOW)"
pbsql "INSERT INTO verify_info_domains (domain,count_rcpt,count_eod) VALUES ('$domain',1,0) ON DUPLICATE KEY UPDATE count_rcpt=count_rcpt+1"

