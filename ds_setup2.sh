cd /opt/datasunrise

./AppBackendService CLEAN_LOCAL_SETTINGS \
DICTIONARY_TYPE=$1 \
DICTIONARY_HOST=$2 \
DICTIONARY_PORT=$3 \
DICTIONARY_DB_NAME=$4 \
DICTIONARY_LOGIN=$5 \
DICTIONARY_PASS=$6 \
FIREWALL_SERVER_NAME=$7'-'`hostname` \
FIREWALL_SERVER_HOST=`hostname` \
FIREWALL_SERVER_BACKEND_PORT=11000 \
FIREWALL_SERVER_CORE_PORT=11001 \
FIREWALL_SERVER_BACKEND_HTTPS=1 \
FIREWALL_SERVER_CORE_HTTPS=1

RETVAL=$?

if [ "$RETVAL" == "93" ]; then

./AppBackendService SET_ADMIN_PASSWORD=$8

fi

echo $? >> /home/test.txt

echo "Exit code after dictionary configuration" >> /home/test.txt

./AppBackendService CHANGE_SETTINGS \
AuditDatabaseType=1 \
AuditDatabaseHost=$2 \
AuditDatabasePort=$3 \
AuditDatabaseName=$9 \
AuditLogin=$5 \
AuditPassword=$6 \

echo $? >> /home/test.txt

echo "Exit code after audit configuration" >> /home/test.txt

sudo service datasunrise start

echo "Datasunrise Suite was successfully started" >> /home/test.txt
