# Letsencrypt
letsencrypt:
  global:
    rsa-key-size: 4096
    email: georg@sattler.io
    non-interactive: true
    agree-tos: true
    authenticator: webroot
  domains:
    salt.sattler.io:
      domains: salt.sattler.io
      webroot-path: /var/www/letsencrypt/salt.sattler.io
    ldap.sattler.io:
      domains: ldap.sattler.io
      webroot-path: /var/www/letsencrypt/ldap.sattler.io
