sudo yum install unixODBC -y

echo "unixODBC install OK" >> /home/test.txt 

wget -O DataSunrise_Suite_6_3_1_31046.linux.64bit.run $1

echo "DS download OK" >> /home/test.txt

chmod +x DataSunrise_Suite_6_3_1_31046.linux.64bit.run

echo "chmod OK" >> /home/test.txt

./DataSunrise_Suite_6_3_1_31046.linux.64bit.run --target tmp install -f --no-password --no-start

echo $? >> /home/test.txt

echo "Exit code after installation" >> /home/test.txt

cd /opt/datasunrise

./AppBackendService CLEAN_LOCAL_SETTINGS \
DICTIONARY_TYPE=$2 \
DICTIONARY_HOST=$3 \
DICTIONARY_PORT=$4 \
DICTIONARY_DB_NAME=$5 \
DICTIONARY_LOGIN=$6 \
DICTIONARY_PASS=$7 \
FIREWALL_SERVER_NAME=$8 \
FIREWALL_SERVER_HOST=`hostname` \
FIREWALL_SERVER_BACKEND_PORT=11000 \
FIREWALL_SERVER_CORE_PORT=11001 \
FIREWALL_SERVER_BACKEND_HTTPS=1 \
FIREWALL_SERVER_CORE_HTTPS=1

echo $? >> /home/test.txt

echo "Exit code after dictionary configuration" >> /home/test.txt
