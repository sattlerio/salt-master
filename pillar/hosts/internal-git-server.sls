salt:
  # Salt Minion Config
  minion:
    master: salt-master
    hash_type: sha256
    grains:
      roles:
        - salt-minion
        - letsencrypt-slave
        - gitlab-chef
      public_ip: 34.249.90.227
      public_interface: eth0
      icinga_dns: ip-172-31-21-55.eu-west-1.compute.internal
      aws_instance_id: i-03acd3a715407647c
      aws_region: eu-west-1
    mine_functions:
      public_ips:
        - mine_function: grains.get
        - public_ip
