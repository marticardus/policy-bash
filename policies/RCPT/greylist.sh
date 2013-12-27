if [ -f $POLICYDIR/policies-conf/$POLICYNAME ] ; then
	source $POLICYDIR/policies-conf/$POLICYNAME
else
	INTERVAL=300
	NETMASK=3
fi
NOW=$(date +%s)
HOST=$(echo $client_address|cut -d. -f$NETMASK)
TIME=$(pbsql "SELECT created FROM greylist WHERE sender='$sender' AND recipient='$recipient' AND host='$HOST'")

if [ -z "$TIME" ]; then
	pbsql "INSERT INTO greylist (sender,recipient,host,created,count) VALUES ('$sender','$recipient','$HOST',$NOW,0)"
	defer "Greylist for $INTERVAL seconds"
else
	DIFF=$(echo "$NOW - $TIME"|bc)
	if [ $DIFF -gt $INTERVAL ]; then
		pbsql "UPDATE greylist SET count=count+1,updated=$NOW WHERE sender='$sender' AND recipient='$recipient' AND host='$HOST'"
		dunno
	else
		TTG=$(echo "$INTERVAL - $DIFF"|bc)
		defer "Greylist abuse! Wait $TTG seconds to resend"
	fi
fi
