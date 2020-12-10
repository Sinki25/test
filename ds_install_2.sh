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

echo "Remove odd servers in case there are ones" >> /home/test.txt

file_to_execute="/var/lib/waagent/custom-script/download/1/${14}"

$file_to_execute ${12} ${15} ${16} ${17}

echo "The odd servers were successfully removed" >> /home/test.txt
