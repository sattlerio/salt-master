salt:
  # Salt Minion Config
  minion:
    master: salt-master
    hash_type: sha256
    grains:
      roles:
        - salt-minion
        - letsencrypt-slave
      public_ip: 34.249.96.85
      public_interface: eth0
      icinga_dns: ip-172-31-28-47.eu-west-1.compute.internal
      aws_instance_id: i-07480b3b9828be658
      aws_region: eu-west-1
    mine_functions:
      public_ips:
        - mine_function: grains.get
        - public_ip
