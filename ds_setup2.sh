resetDict() {

  cd /opt/datasunrise

  ./AppBackendService CLEAN_LOCAL_SETTINGS \
  DICTIONARY_TYPE=$1 \
  DICTIONARY_HOST=$2 \
  DICTIONARY_PORT=$3 \
  DICTIONARY_DB_NAME=$4 \
  DICTIONARY_LOGIN=$5 \
  DICTIONARY_PASS=$6 \
  FIREWALL_SERVER_NAME=$7'-'`hostname` \
  FIREWALL_SERVER_HOST=`hostname` \
  FIREWALL_SERVER_BACKEND_PORT=11000 \
  FIREWALL_SERVER_CORE_PORT=11001 \
  FIREWALL_SERVER_BACKEND_HTTPS=1 \
  FIREWALL_SERVER_CORE_HTTPS=1
  
}

resetAdminPassword() {

  logBeginAct "Reset Admin Password..."

   ./AppBackendService SET_ADMIN_PASSWORD=$1
   
   RETVAL1=$?
   
   logEndAct "Reset DS Admin Password result - $RETVAL1"
  
 }

resetAudit() {

cd /opt/datasunrise

  ./AppBackendService CHANGE_SETTINGS \
  AuditDatabaseType=1 \
  AuditDatabaseHost=$1 \
  AuditDatabasePort=$2 \
  AuditDatabaseName=$3 \
  AuditLogin=$4 \
  AuditPassword=$5 \
  
}

setupProxy() {

  cd /opt/datasunrise/cmdline

  ./executecommand.sh addInstancePlus -name $1 -dbPort $2 -dbType $3 -dbHost $4 -database $5 -login $6 -password $7 -proxyHost `hostname -I` -proxyPort $8 -savePassword ds

}

setupDSLicense() {

  touch /tmp/appfirewall.reg

  echo "$1" > /tmp/appfirewall.reg  
  
  sudo mv /tmp/appfirewall.reg /opt/datasunrise/
  
  sudo chown datasunrise:datasunrise -R /opt/datasunrise/

}

setDictionaryLicense() {

  dsversion=`/opt/datasunrise/AppBackendService VERSION`
  
  if [ '6.3.1.99999' = "`echo -e "6.3.1.99999\n$dsversion" | sort -V | head -n1`" ] ; then
                        
    echo "DS version $dsversion" >> /home/test.txt 
    
    sudo /opt/datasunrise/AppBackendService IMPORT_LICENSE_FROM_FILE=/opt/datasunrise/appfirewall.reg
                  
  fi
 
}
