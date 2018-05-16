#!/bin/bash

if [ -z "$#" ];  then
        echo "adduser.sh <firstname> <surname> <email>"
        exit 1
fi

FIRSTNAME="$1"
LASTNAME="$2"
EMAIL="$3"

PWD=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 13 ; echo '')

(
cat <<add
dn: cn=${EMAIL,,},ou=users,dc=ldap,dc=sattler,dc=io
objectClass: posixAccount
objectClass: top
objectClass: inetOrgPerson
cn: ${EMAIL,,}
givenName: $FIRSTNAME
displayName: $FIRSTNAME $LASTNAME
loginShell: /bin/bash
homeDirectory: /home/${FIRSTNAME,,}.${LASTNAME,,}
o: ${FIRSTNAME,,}.${LASTNAME,,}
sn: ${LASTNAME,,}
userPassword: {ssha}$PWD
uid: ${EMAIL,,}
gidNumber: $(echo $[ 1000 + $[ RANDOM % 65535 ]])
uidNumber: $(echo $[ 1000 + $[ RANDOM % 65535 ]])
add
) > /etc/ldap/tmp/addNewUser.ldif

/usr/bin/ldapadd -x -W -D "cn=admin,dc=ldap,dc=sattler,dc=io" -f /etc/ldap/tmp/addNewUser.ldif && rm /etc/ldap/tmp/addNewUser.ldif
