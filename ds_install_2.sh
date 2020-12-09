sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc

sudo sh -c 'echo -e "[azure-cli]
name=Azure CLI
baseurl=https://packages.microsoft.com/yumrepos/azure-cli
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/azure-cli.repo'

sudo yum install azure-cli -y

echo "Azure CLI was successfully installed" >> /home/test.txt

az login -u $1 -p $2

echo "Azure successful login" >> /home/test.txt

sudo yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

sudo yum install jq -y

echo "jq was successfully installed" >> /home/test.txt

sudo yum install java-1.8.0-openjdk -y

sudo yum install unixODBC -y

echo "unixODBC install OK" >> /home/test.txt 

wget -O DataSunrise_Suite.linux.64bit.run $3

echo "DS download OK" >> /home/test.txt

chmod +x DataSunrise_Suite_6_3_1_31046.linux.64bit.run

echo "chmod OK" >> /home/test.txt

./DataSunrise_Suite_6_3_1_31046.linux.64bit.run --target tmp install -f --no-password --no-start

echo $? >> /home/test.txt

echo "Exit code after installation" >> /home/test.txt

#curl https://packages.microsoft.com/config/rhel/8/prod.repo > /etc/yum.repos.d/mssql-release.repo

#sudo yum remove unixODBC-utf16 unixODBC-utf16-devel 

#sudo ACCEPT_EULA=Y yum install msodbcsql17 -y

#sudo yum install unixODBC-devel -y

#echo "mssql driver was updated successfully" >> /home/test.txt

cd /opt/datasunrise

./AppBackendService CLEAN_LOCAL_SETTINGS \
DICTIONARY_TYPE=$4 \
DICTIONARY_HOST=$5 \
DICTIONARY_PORT=$6 \
DICTIONARY_DB_NAME=$7 \
DICTIONARY_LOGIN=$8 \
DICTIONARY_PASS=$9 \
FIREWALL_SERVER_NAME=${10}'-'`hostname` \
FIREWALL_SERVER_HOST=`hostname` \
FIREWALL_SERVER_BACKEND_PORT=11000 \
FIREWALL_SERVER_CORE_PORT=11001 \
FIREWALL_SERVER_BACKEND_HTTPS=1 \
FIREWALL_SERVER_CORE_HTTPS=1

RETVAL=$?

if [ "$RETVAL" == "93" ]; then

./AppBackendService SET_ADMIN_PASSWORD=${11}

fi

echo $? >> /home/test.txt

echo "Exit code after dictionary configuration" >> /home/test.txt

./AppBackendService CHANGE_SETTINGS \
AuditDatabaseType=1 \
AuditDatabaseHost=$5 \
AuditDatabasePort=$6 \
AuditDatabaseName=${12} \
AuditLogin=$8 \
AuditPassword=$9 \

echo $? >> /home/test.txt

echo "Exit code after audit configuration" >> /home/test.txt

sudo service datasunrise start

echo "Datasunrise Suite was successfully started" >> /home/test.txt

echo "Remove odd servers in case there are ones" >> /home/test.txt

file_to_execute="./${13}"

$file_to_execute ${14} ${15} ${16} ${17}

echo "The odd servers were successfully removed" >> /home/test.txt
