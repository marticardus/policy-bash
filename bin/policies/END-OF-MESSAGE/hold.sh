## SELECT IF(count(*)>0,IF(retries<maxsends,'DUNNO','HOLD'),'DUNNO') FROM holdretries WHERE sender='test@acs.li'
if [ -f $POLICYCONF/policies/$POLICYNAME ] ; then
        source $POLICYCONF/policies/$POLICYNAME
else
	MAX=10
	REFRESH=3600
fi
NOW=$(date +%s)
REFRESH=$(echo "$NOW + $REFRESH"|bc)

RETRIES=$(pbsql "SELECT count FROM holdretries WHERE sender='$sender'")
if [ -z "$RETRIES" ]; then
	pbsql "INSERT INTO holdretries (sender,count,max,refresh) VALUES ('$sender',1,$MAX,$REFRESH)"
	dunno
else
	MAXUSER=$(pbsql "SELECT max FROM holdretries WHERE sender='$sender'")
	if [ $RETRIES -ge $MAXUSER ]; then
		pbsql "INSERT INTO holdmails (queue_id,sender,created) VALUES ('$queue_id','$sender',$NOW)"
		hold
	else
		pbsql "UPDATE holdretries SET count=count+1 WHERE sender='$sender'"
		dunno
	fi
fi
