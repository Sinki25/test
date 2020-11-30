sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc

sudo sh -c 'echo -e "[azure-cli] \
name=Azure \
CLI baseurl=https://packages.microsoft.com/yumrepos/azure-cli \
enabled=1 \
gpgcheck=1 \
gpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/azure-cli.repo'

sudo yum install azure-cli -y

echo "Azure CLI was successfully installed" >> /home/test.txt

az login -u azuretest@datasunrise.com -p Armor-409

echo "Azure successful login" >> /home/test.txt

sudo yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

sudo yum install jq -y

echo "jq was successfully installed" >> /home/test.txt

sudo yum install java-1.8.0-openjdk -y

touch /tmp/ds_servers.txt

./executecommand.sh connect -host `hostname` -port 11000 -login admin -password 84218421

./executecommand.sh showDsServers | grep 11000 > /tmp/ds_servers.txt

ds_server_name_del=()

for i in {0..$1}

do

    hostname=''

    hostname=$(az vmss list-instances -g katya-group -n vmScaleSet_0 | jq '.[i].osProfile.computerName')

    if [ "$hostname" != null]; then

        hostname=`hostname | tr -d \"`

        while IFS='' read -r DS_LINE || [[ -n "$DS_LINE" ]]; do
        
            IFS=':'; ARG=($DS_LINE); unset IFS;
    
            CK_DS_NAME=`echo ${ARG[0]} | tr -d '[:space:]'`
            CK_DS_HOST_NAME=`echo ${ARG[1]} | tr -d '[:space:]'`
            
    
            if [ "$CK_DS_HOST_NAME" == "$hostname" ]; then
                continue
            else 
                name_del+=($CK_DS_NAME);
                continue
            fi

done < /tmp/ds_servers.txt



fi

done
