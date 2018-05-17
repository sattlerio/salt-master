{% include 'letsencrypt.sls' %}

salt:
  # Salt Master Config
  master:
    interface: 172.31.27.44
    hash_type: sha256
    file_roots:
      base:
        - /srv/salt/states
    pillar_roots:
      base:
        - /srv/salt/pillar
    engines_dirs:
        - /srv/salt/engines
    runner_dirs:
        - /srv/salt/runners
    module_dirs:
        - /srv/salt/modules
    rest_cherrypy:
      port: 5002
      host: 127.0.0.1
      webhook_disable_auth: true
      disable_ssl: true

  # Salt Minion Config
  minion:
    master: salt-master
    hash_type: sha256
    grains:
      roles:
        - salt-master
        - salt-minion
        - docker
        - web-apache2
        - letsencrypt
      public_ip: 54.77.37.39
      private_ip: 172.31.27.44
      public_interface: eth0
      icinga_dns: ip-172-31-27-44.eu-west-1.compute.internal
      aws_instance_id: i-023d580ece161970f
      aws_region: eu-west-1
    mine_functions:
      public_ips:
        - mine_function: grains.get
        - public_ip

# Salt Formulas from https://github.com/saltstack-formulas/
salt_formulas:
  git_opts:
    default:
      basedir: /srv/salt/formulas
  list:
    base:
      - openssh-formula
      - salt-formula
      - apache-formula
      - docker-formula

apache:
  server: apache2
  service: apache2
  vhostdir: /etc/apache2/sites-available
  confext: .conf
  wwwdir: /var/www/html

  sites:
    salt.sattler.io:
      enabled: True
      template_file: salt://apache2/files/vhosts/https_reverse-proxy_ldap-auth_with-port80-redirect_letsencrypt.conf
      interface: "*"
      ServerName: salt.sattler.io
      DocumentRoot: /var/www/html
      ProxyPass: http://127.0.0.1:5002/
      SSLCertificateFile: /etc/letsencrypt/live/salt.sattler.io/fullchain.pem
      SSLCertificateKeyFile: /etc/letsencrypt/live/salt.sattler.io/privkey.pem
      LDAPGroup: cn=deployer,ou=groups,dc=ldap,dc=sattler,dc=io
    certs.sattler.io:
      enabled: True
      template_file: salt://apache2/files/vhosts/letsencrypt_only.conf
      interface: "*"
      ServerName: certs.sattler.io
      DocumentRoot: False
   {% set validation_only = ['ldap', 'vpn', 'jenkins', 'salt'] %}
{% for d in validation_only %}
    {{ d }}.sattler.io:
      enabled: True
      interface: "*"
      template_file: salt://apache2/files/vhosts/letsencrypt_only.conf
      ServerName: {{ d }}.sattler.io
      DocumentRoot: False
{% endfor %}
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
      - proxy_http
      - proxy
      - rewrite
      - setenvif
      - socache_shmcb
      - ssl
      - status
