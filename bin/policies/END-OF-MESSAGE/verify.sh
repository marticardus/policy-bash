pbsql "UPDATE verify_info_mbox SET updated=$NOW, count=count+1 WHERE sender='$sender' AND recipient='$recipient' AND instance='$instance'"
pbsql "UPDATE verify_info_domains SET count_eod=count_eod+1 WHERE domain='$domain'"

