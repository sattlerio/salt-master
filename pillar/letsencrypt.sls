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
    vpn.sattler.io:
      domains: vpn.sattler.io
      webroot-path: /var/www/letsencrypt/vpn.sattler.io
    jenkins.sattler.io:
      domains: jenkins.sattler.io
      webroot-path: /var/www/letsencrypt/jenkins.sattler.io
    nexus.sattler.io:
      domains: nexus.sattler.io
      webroot-path: /var/www/letsencrypt/nexus.sattler.io
    docker-builds.sattler.io:
      domains: docker-builds.sattler.io
      webroot-path: /var/www/letsencrypt/docker-builds.sattler.io
    git.sattler.io
      domains: git.sattler.io
      webroot-path: /var/www/letsencrypt/git.sattler.io
