sudo yum install unixODBC -y

echo "unixODBC install OK" >> /home/test.txt 

wget -O DataSunrise_Suite_6_3_1_31046.linux.64bit.run $1

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
DICTIONARY_TYPE=$2 \
DICTIONARY_HOST=$3 \
DICTIONARY_PORT=$4 \
DICTIONARY_DB_NAME=$5 \
DICTIONARY_LOGIN=$6 \
DICTIONARY_PASS=$7 \
FIREWALL_SERVER_NAME=$8'-'`hostname` \
FIREWALL_SERVER_HOST=`hostname` \
FIREWALL_SERVER_BACKEND_PORT=11000 \
FIREWALL_SERVER_CORE_PORT=11001 \
FIREWALL_SERVER_BACKEND_HTTPS=1 \
FIREWALL_SERVER_CORE_HTTPS=1

RETVAL=$?

if [ "$RETVAL" == "93" ]; then

./AppBackendService SET_ADMIN_PASSWORD=${11}

fi

./AppBackendService CHANGE_SETTINGS \
AuditDatabaseType=$2 \
AuditDatabaseHost=${15} \
AuditDatabasePort=$4 \
AuditDatabaseName=${16} \
AuditLogin=$6 \
AuditPassword=$7 \

echo $? >> /home/test.txt

echo "Exit code after dictionary configuration" >> /home/test.txt

sudo service datasunrise start

echo "Datasunrise Suite was successfully started" >> /home/test.txt

sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc

sudo sh -c 'echo -e "[azure-cli]
name=Azure CLI
baseurl=https://packages.microsoft.com/yumrepos/azure-cli
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/azure-cli.repo'

sudo yum install azure-cli -y

echo "Azure CLI was successfully installed" >> /home/test.txt

az login -u $9 -p ${10}

echo "Azure successful login" >> /home/test.txt

sudo yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

sudo yum install jq -y

echo "jq was successfully installed" >> /home/test.txt

sudo yum install java-1.8.0-openjdk -y

touch /tmp/ds_servers.txt

cd /opt/datasunrise/cmdline

./executecommand.sh connect -host `hostname` -port 11000 -login admin -password ${11}

./executecommand.sh showDsServers | grep 11000 > /tmp/ds_servers.txt

ds_servers_count=`wc -l < /tmp/ds_servers.txt`

echo "ds_servers_count=$ds_servers_count" >> /home/test.txt

ds_server_name_del=()

ds_server_name_cont=()

vm_count=$((${12}-1))

echo "vm_count=$vm_count" >> /home/test.txt

for i in {0..$ds_servers_count}

do

    while IFS='' read -r DS_LINE || [[ -n "$DS_LINE" ]]; do
        
        IFS=':'; ARG=($DS_LINE); unset IFS;
    
        CK_DS_NAME=`echo ${ARG[0]} | tr -d '[:space:]'`
        CK_DS_HOST_NAME=`echo ${ARG[1]} | tr -d '[:space:]'`
        
        echo "CK_DS_NAME=$CK_DS_NAME" >> /home/test.txt
        
        echo "CK_DS_HOST_NAME=$CK_DS_HOST_NAME" >> /home/test.txt
        
        for ((j=0; j<=$vm_count; j++))

        do

            echo "resource_group=${13}" >> /home/test.txt
            echo "resource_group=${13}" >> /home/test.txt
            echo "j=$j" >> /home/test.txt
            
            hostname_scale=$(az vmss list-instances -g ${13} -n ${14} | jq ".[$j].osProfile.computerName")
            
            echo "hostname_scale=`$(az vmss list-instances -g ${13} -n ${14} | jq ".[$j].osProfile.computerName")`" >> /home/test.txt
            
            echo "hostname_scale=$hostname_scale" >> /home/test.txt

            hostname_scale="${hostname_scale//\"}"
            
            echo "hostname_scale=$hostname_scale" >> /home/test.txt

            if [ "$hostname_scale" == "$CK_DS_HOST_NAME" ]; then
                
                ds_server_name_cont+=($CK_DS_NAME);
                
                echo "CK_DS_NAME_cont=$CK_DS_NAME" >> /home/test.txt
                    
            else 
                if [[ " ${ds_server_name_del[@]} " =~ " ${CK_DS_NAME} " ]]; then
                    
                    continue
                        
                else
                    ds_server_name_del+=($CK_DS_NAME);
                    
                    echo "CK_DS_NAME_del=$CK_DS_NAME" >> /home/test.txt
                    
                fi
            fi
            
         done

    done < /tmp/ds_servers.txt
    
done

if [ ${#ds_server_name_cont[@]} != ${#ds_server_name_del[@]} ]; then

    echo "ds_server_name_cont_count=${#ds_server_name_cont[@]}" >> /home/test.txt
    
    echo "ds_server_name_del_count=${#ds_server_name_del[@]}" >> /home/test.txt

    for cont in ${ds_server_name_cont[@]}
    do
        
        ds_server_name_del=("${ds_server_name_del[@]/$cont}") 
        
        echo "cont=$cont" >> /home/test.txt

    done
  
    for del in ${ds_server_name_del[@]}

    do 

        ./executecommand.sh delDsServer -name $del
        
        echo "del=$del" >> /home/test.txt
    
    done
fi
