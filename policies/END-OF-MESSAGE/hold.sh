## SELECT IF(count(*)>0,IF(retries<maxsends,'DUNNO','HOLD'),'DUNNO') FROM holdretries WHERE sender='test@acs.li'
# DEFAULT MAX SENDS
MAX=2

QUERY_NUM_RETRYS="SELECT retries FROM holdretries WHERE sender='$sender'"
UPDATE_RETRYS="UPDATE holdretries SET retries=retries+1 WHERE sender='$sender'"
INSERT_RETRY="INSERT INTO holdretries VALUES ('$sender',1,$MAX)"
INSERT_QUEUE="INSERT INTO holdmails VALUES ('$queue_id','$sender',NOW())"

RETRYS=$($MYPFLOG "$QUERY_NUM_RETRYS")
if  [ -z "$RETRYS" ]; then
	$MYPFLOG "$INSERT_RETRY" >> /tmp/policy.log
	echo "action=DUNNO"
	echo ""
elif [ "$RETRYS" -gt 2 ]; then
	$MYPFLOG "$INSERT_QUEUE" >> /tmp/policy.log
	echo "action=HOLD"
	echo ""
else
	$MYPFLOG "$UPDATE_RETRYS" >> /tmp/policy.log
	echo "action=DUNNO"
	echo ""
fi
