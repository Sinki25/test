cd /opt/datasunrise

./AppBackendService CLEAN_LOCAL_SETTINGS \
DICTIONARY_TYPE=$5 \
DICTIONARY_HOST=$6 \
DICTIONARY_PORT=$7 \
DICTIONARY_DB_NAME=$8 \
DICTIONARY_LOGIN=$9 \
DICTIONARY_PASS=${10} \
FIREWALL_SERVER_NAME=${11}'-'`hostname` \
FIREWALL_SERVER_HOST=`hostname` \
FIREWALL_SERVER_BACKEND_PORT=11000 \
FIREWALL_SERVER_CORE_PORT=11001 \
FIREWALL_SERVER_BACKEND_HTTPS=1 \
FIREWALL_SERVER_CORE_HTTPS=1

RETVAL=$?

if [ "$RETVAL" == "93" ]; then

./AppBackendService SET_ADMIN_PASSWORD=${12}

fi

echo $? >> /home/test.txt

echo "Exit code after dictionary configuration" >> /home/test.txt

./AppBackendService CHANGE_SETTINGS \
AuditDatabaseType=1 \
AuditDatabaseHost=$6 \
AuditDatabasePort=$7 \
AuditDatabaseName=${13} \
AuditLogin=$9 \
AuditPassword=${10} \

echo $? >> /home/test.txt

echo "Exit code after audit configuration" >> /home/test.txt

sudo service datasunrise start

echo "Datasunrise Suite was successfully started" >> /home/test.txt
