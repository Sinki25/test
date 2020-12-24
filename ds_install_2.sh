file_to_execute="./$1"

source $file_to_execute 

logBeginAct "Datasunrise installation script has been started"

logEndAct "Install_libraries execution result - $RETVAL"

echo "Install_libraries execution" >> /home/test.txt

file_to_execute="./$2"

source $file_to_execute 

identity=$3

$file_to_execute  

echo "Pre_setup execution" >> /home/test.txt

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

echo "Ds_setup execution" >> /home/test.txt

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

if [ "$RETVAL" == "93" ]; then

  file_to_execute="/var/lib/waagent/custom-script/download/1/${16}"

  source $file_to_execute 

  echo "Exit code after connection attempt" >> /home/test.txt

  ds_connect ${14} 

  echo $? >> /home/test.txt

  file_to_execute="/var/lib/waagent/custom-script/download/1/$6"

  source $file_to_execute

  echo "Exit code after license is gotten" >> /home/test.txt

  setupDSLicense ${17}

  echo $? >> /home/test.txt

  echo "Exit code after license is set" >> /home/test.txt

  setDictionaryLicense

  echo $? >> /home/test.txt

  echo "Exit code after instance addition attempt" >> /home/test.txt

  setupProxy ${18} ${19} ${20} ${21} ${22} ${23} ${24} ${25}

  echo $? >> /home/test.txt
  
fi

echo "Ds_remove_servers execution" >> /home/test.txt

file_to_execute="/var/lib/waagent/custom-script/download/1/${16}"

source $file_to_execute 

echo "Exit code after connection attempt" >> /home/test.txt

ds_connect ${14} 

echo $? >> /home/test.txt 

echo "Exit code after showDsServers" >> /home/test.txt

ds_showservers 

echo $? >> /home/test.txt

get_ds_servers_list ${26} ${27} ${28}

remove_odd_servers

echo "The odd servers were successfully removed" >> /home/test.txt
