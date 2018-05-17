salt:
  # Salt Minion Config
  minion:
    master: salt-master
    hash_type: sha256
    grains:
      roles:
        - salt-minion
        - web-apache2
        - jenkins
        - letsencrypt-slave
        - docker
      public_ip: 34.249.96.85
      public_interface: eth0
      icinga_dns: ip-172-31-28-47.eu-west-1.compute.internal
      aws_instance_id: i-07480b3b9828be658
      aws_region: eu-west-1
    mine_functions:
      public_ips:
        - mine_function: grains.get
        - public_ip

containers:
  - containers.nexus3

apache:
  server: apache2
  service: apache2
  vhostdir: /etc/apache2/sites-available
  confext: .conf
  wwwdir: /var/www/html

  sites:
    jenkins.sattler.io:
      enabled: True
      template_file: salt://apache2/files/vhosts/https_reverse-proxy_ldap-auth_with-port80-redirect_letsencrypt.conf
      interface: "*"
      ServerName: jenkins.sattler.io
      DocumentRoot: /var/www/html
      SSLCertificateFile: /etc/letsencrypt/live/jenkins.sattler.io/fullchain.pem
      SSLCertificateKeyFile: /etc/letsencrypt/live/jenkins.sattler.io/privkey.pem
      ProxyPass: http://127.0.0.1:8080/
    nexus.sattler.io:
      enabled: True
      template_file: salt://apache2/files/vhosts/https_reverse-proxy_ldap-auth_with-port80-redirect_letsencrypt.conf
      interface: "*"
      ServerName: nexus.sattler.io
      DocumentRoot: /var/www/html
      SSLCertificateFile: /etc/letsencrypt/live/nexus.sattler.io/fullchain.pem
      SSLCertificateKeyFile: /etc/letsencrypt/live/nexus.sattler.io/privkey.pem
      ProxyPass: http://127.0.0.1:8081/
    docker-builds.sattler.io:
      enabled: True
      template_file: salt://apache2/files/vhosts/special_docker-registry.conf
      interface: "*"
      ServerName: docker-builds.sattler.io
      DocumentRoot: /var/www/docker-builds.sattler.io/docker-registry-frontend
      SSLCertificateFile: /etc/letsencrypt/live/docker-builds.sattler.io/fullchain.pem
      SSLCertificateKeyFile: /etc/letsencrypt/live/docker-builds.sattler.io/privkey.pem
      ProxyPass: http://127.0.0.1:8082/v2

  modules:
    enabled:
      - access_compat
      - actions
      - alias
      - auth_basic
      - authn_core
      - authn_file
      - authnz_ldap
      - authz_core
      - authz_host
      - authz_user
      - autoindex
      - deflate
      - dir
      - env
      - filter
      - headers
      - ldap
      - mime
      - mpm_prefork
      - negotiation
      - php7.0
      - proxy_http
      - proxy
      - rewrite
      - setenvif
      - socache_shmcb
      - ssl
      - status