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

   ./AppBackendService SET_ADMIN_PASSWORD=$1
  
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


  ./executecommand.sh addInstancePlus -name $8 \
  -dbType $9 \
  -dbHost ${10} \
  -dbPort ${11} \
  -database ${12} \
  -login ${13} \
  -password ${14} \
  -proxyHost `hostname -I` \
  -proxyPort ${15} 
  -savePassword ds

}
