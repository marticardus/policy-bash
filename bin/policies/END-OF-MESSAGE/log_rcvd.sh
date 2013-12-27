SQL="SELECT 'EXIST' AS QUERYTEST FROM log_rcvd WHERE sender='${sender}' AND rcpt='${recipient}'"
QUERYTEST=$(${MYSQL} "${SQL}"|grep -v QUERYTEST)
if [ $(echo ${QUERYTEST} |grep "EXIST"|wc -l) -gt 0 ]; then
	UPDATE=$(${MYSQL} "UPDATE log_rcvd SET count=count+1, updated=NOW() WHERE sender='$sender' AND rcpt='$recipient'")
else
	INSERT=$(${MYSQL} "INSERT INTO log_rcvd (sender, rcpt, count, created) VALUES ('$sender', '$recipient', 1, NOW()))")
fi
