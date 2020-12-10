file_to_execute="./$1"

$file_to_execute $2 $3 

wget -O DataSunrise_Suite.linux.64bit.run $4

echo "DS download OK" >> /home/test.txt

chmod +x DataSunrise_Suite.linux.64bit.run

echo "chmod OK" >> /home/test.txt

./DataSunrise_Suite.linux.64bit.run --target tmp install -f --no-password --no-start

echo $? >> /home/test.txt

echo "Exit code after installation" >> /home/test.txt

#curl https://packages.microsoft.com/config/rhel/8/prod.repo > /etc/yum.repos.d/mssql-release.repo

#sudo yum remove unixODBC-utf16 unixODBC-utf16-devel 

#sudo ACCEPT_EULA=Y yum install msodbcsql17 -y

#sudo yum install unixODBC-devel -y

#echo "mssql driver was updated successfully" >> /home/test.txt

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

echo "Remove odd servers in case there are ones" >> /home/test.txt

file_to_execute="/var/lib/waagent/custom-script/download/1/${14}"

$file_to_execute ${12} ${15} ${16} ${17}

echo "The odd servers were successfully removed" >> /home/test.txt
