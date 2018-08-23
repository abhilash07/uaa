#!/bin/bash

# CF Info
DOMAIN=182.252.135.138.xip.io

# Login Info
ADMIN=admin
ADMIN_PASSWORD=rDaYpV7tUgj5I5YVhoquSXi2AQ8SDp
ORG=system

# Sudouser Info
MEMBERS=("scim.write" "scim.read" "openid" "cloud_controller.admin" "clients.read" "clients.write" "doppler.firehose" 
         "routing.router_groups.read" "password.write" "uaa.admin")
SUDOUSER=sudouser
SUDOUSER_PASSWORD=sudouser

# Clinet Info
ADMIN=admin
ADMIN_SECRET=71KvUEgCPcxkadBLdc4FMwaF4X5zD6
CLIENT=harbor_uaa_client
CLIENT_SECRET=q3j50u886jr2d99hms85
AUTHORITIES="oauth.login,scim.write,clients.read,scim.userids,password.write,clients.secret,clients.write,uaa.admin,scim.read,doppler.firehose"
AUTHORIZED_GRANT_TYPES="client_credentials,password,refresh_token" # authorization_code,implicit
SCOPE="cloud_controller.read,cloud_controller.write,openid,cloud_controller.admin,scim.read,scim.write,doppler.firehose,uaa.user,routing.router_groups.read,uaa.admin,password.write"

# [1] Add Sudouser
cf login -a https://api.$DOMAIN -u $ADMIN -p $ADMIN_PASSWORD -o $ORG --skip-ssl-validation

cf create-user $SUDOUSER $SUDOUSER_PASSWORD

for value in ${MEMBERS[*]}; do
  echo $value
  uaac member add $value $SUDOUSER
done

# [2] Add Client
uaac target https://uaa.$DOMAIN --skip-ssl-validation
uaac token client get $ADMIN -s $ADMIN_SECRET
uaac client add $CLIENT --name $CLIENT -s $CLIENT_SECRET \
--authorities $AUTHORITIES \
--authorized_grant_types $AUTHORIZED_GRANT_TYPES \
--scope $SCOPE
