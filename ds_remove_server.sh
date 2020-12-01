sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc

sudo sh -c 'echo -e "[azure-cli] 
name=Azure 
CLI baseurl=https://packages.microsoft.com/yumrepos/azure-cli 
enabled=1 
gpgcheck=1 
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

cd /opt/datasunrise/cmdline

./executecommand.sh connect -host `hostname` -port 11000 -login admin -password $1

./executecommand.sh showDsServers | grep 11000 > /tmp/ds_servers.txt

ds_servers_count=`wc -l < /tmp/ds_servers.txt`

ds_server_name_del=()

ds_server_name_cont=()

for i in {0..$ds_servers_count}

do

    while IFS='' read -r DS_LINE || [[ -n "$DS_LINE" ]]; do
        
        IFS=':'; ARG=($DS_LINE); unset IFS;
    
        CK_DS_NAME=`echo ${ARG[0]} | tr -d '[:space:]'`
        CK_DS_HOST_NAME=`echo ${ARG[1]} | tr -d '[:space:]'`
        
        for j in {0..$2}

        do

            hostname_scale=$(az vmss list-instances -g $3 -n $4 | jq ".[$j].osProfile.computerName")

            hostname_scale="${hostname_scale//\"}"

            if [ "$hostname_scale" == "$CK_DS_HOST_NAME" ]; then
                
                ds_server_name_cont+=($CK_DS_NAME);
                    
            else 
                if [[ " ${ds_server_name_del[@]} " =~ " ${CK_DS_NAME} " ]]; then
                    
                    continue
                        
                else
                    ds_server_name_del+=($CK_DS_NAME);
                    
                fi
            fi
            
         done

    done < /tmp/ds_servers.txt
    
done

if [ ${#ds_server_name_cont[@]} != ${#ds_server_name_del[@]} ]; then

    for i in {1..${#ds_server_name_cont[@]}}

    do 

        for cont in ${ds_server_name_cont[@]}
        do
        
            ds_server_name_del=("${ds_server_name_del[@]/$cont}") 

        done
    
    done 

    for del in ${ds_server_name_del[@]}

    do 

        ./executecommand.sh delDsServer -name $del
    
    done
fi






