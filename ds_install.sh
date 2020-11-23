sudo yum install unixODBC -y

echo "unixODBC install OK" >> /home/test.txt 

wget -O DataSunrise_Suite_6_3_1_31046.linux.64bit.run $1

echo "DS download OK" >> /home/test.txt

chmod +x DataSunrise_Suite_6_3_1_31046.linux.64bit.run

echo "chmod OK" >> /home/test.txt

./DataSunrise_Suite_6_3_1_31046.linux.64bit.run install --remote-config -v --dictionary-type postgresql --dictionary-host $2 --dictionary-port 5432 --dictionary-database datasunrise_db --dictionary-login $3 --dictionary-password $4 --server-name katya --server-host $5 --server-port 11000

echo "DS install OK" >> /home/test.txt
