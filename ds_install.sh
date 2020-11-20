sudo yum install unixODBC -y

echo "unixODBC install OK" >> /home/test.txt 

wget -O DataSunrise_Suite_6_3_1_31046.linux.64bit.run $1

echo "DS download OK" >> /home/test.txt

chmod +x DataSunrise_Suite_6_3_1_31046.linux.64bit.run

echo "chmod OK" >> /home/test.txt

./DataSunrise_Suite_6_3_1_31046.linux.64bit.run install

echo "DS install OK" >> /home/test.txt
