salt:
  # Salt Minion Config
  minion:
    master: salt-master
    hash_type: sha256
    grains:
      roles:
        - salt-minion
        - letsencrypt-slave
        - docker
        - openvpn-server
      public_ip: 34.252.178.55
      public_interface: eth0
      icinga_dns: ip-172-31-33-168.eu-west-1.compute.internal
      aws_instance_id: i-0a9d951846b83bc7f
      aws_region: eu-west-1
    mine_functions:
      public_ips:
        - mine_function: grains.get
        - public_ip

NGINX_DOMAIN: vpn.sattler.io
NGINX_LDAP: True
NGINX_LETSENCRYPT: True
NGINX_PROXY_PASS:  https://localhost:943;