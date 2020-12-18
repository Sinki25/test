echo "Datasunrise installation script has been started"

echo "install_libraries execution" >> /home/test.txt

file_to_execute="./$1"

$file_to_execute $2 $3 

echo "pre_setup execution" >> /home/test.txt

file_to_execute="./$4"

source $file_to_execute 

install_product $5

echo $? >> /home/test.txt

echo "Exit code after installation" >> /home/test.txt

#curl https://packages.microsoft.com/config/rhel/8/prod.repo > /etc/yum.repos.d/mssql-release.repo

#sudo yum remove unixODBC-utf16 unixODBC-utf16-devel 

#sudo ACCEPT_EULA=Y yum install msodbcsql17 -y

#sudo yum install unixODBC-devel -y

#echo "mssql driver was updated successfully" >> /home/test.txt

echo "ds_setup execution" >> /home/test.txt

file_to_execute="./$6"

source $file_to_execute 

resetDict $7 $8 $9 ${10} ${11} ${12} ${13}

RETVAL=$?

echo $? >> /home/test.txt

echo "Exit code after dictionary configuration" >> /home/test.txt

if [ "$RETVAL" == "93" ]; then

  resetAdminPassword ${14}

fi

resetAudit $8 $9 ${15} ${11} ${12}

echo $? >> /home/test.txt

echo "Exit code after audit configuration" >> /home/test.txt

sudo service datasunrise start

echo "Datasunrise Suite was successfully started" >> /home/test.txt

file_to_execute="/var/lib/waagent/custom-script/download/1/${16}"

source $file_to_execute 

echo "exit code after connection attempt" >> /home/test.txt

ds_connect ${14} 

echo $? >> /home/test.txt

file_to_execute="/var/lib/waagent/custom-script/download/1/$6"

source $file_to_execute

echo "exit code after instance addition attempt" >> /home/test.txt

setupProxy ${20} ${21} ${22} ${23} ${24} ${25} ${26} ${27}

echo $? >> /home/test.txt

echo "ds_remove_servers execution" >> /home/test.txt

file_to_execute="/var/lib/waagent/custom-script/download/1/${16}"

source $file_to_execute 

echo "exit code after connection attempt" >> /home/test.txt

ds_connect ${14} 

echo $? >> /home/test.txt 

echo "exit code after showDsServers" >> /home/test.txt

ds_showservers 

echo $? >> /home/test.txt

get_ds_servers_list ${17} ${18} ${19}

remove_odd_servers

echo "The odd servers were successfully removed" >> /home/test.txt
