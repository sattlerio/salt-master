salt:
  # Salt Minion Config
  minion:
    master: salt-master
    hash_type: sha256
    grains:
      roles:
        - salt-minion
        - web-apache2
        - ldap-server
      public_ip: 34.242.137.137
      public_interface: eth0
      icinga_dns: ip-172-31-10-158.eu-west-1.compute.internal
      aws_instance_id: i-0efcf62ed23056f93
      aws_region: eu-west-1
    mine_functions:
      public_ips:
        - mine_function: grains.get
        - public_ip

apache:
  server: apache2
  service: apache2
  vhostdir: /etc/apache2/sites-available
  confext: .conf
  wwwdir: /var/www/html

  sites:
    ldap.sattler.io:
      enabled: True
      template_file: salt://apache2/files/vhosts/https_reverse-proxy_ldap_auth_with-port80-redirect_letsencrypt.conf
      interface: "*"
      ServerName: ldap.sattler.io
      DocumentRoot: /usr/share/phpldapadmin/htdocs
      ExtraInclude: /etc/phpldapadmin/apache.conf
      AuthName: For Admins only
      LDAPGroup: cn=administrator,ou=groups,dc=ldap,dc=sattler,dc=io
      SSLCertificateFile: /etc/letsencrypt/live/ldap.sattler.io/fullchain.pem
      SSLCertificateKeyFile: /etc/letsencrypt/live/ldap.sattler.io/privkey.pem


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
      - negotiation
      - php7.0
      - proxy_http
      - proxy
      - rewrite
      - setenvif
      - socache_shmcb
      - ssl
      - status
