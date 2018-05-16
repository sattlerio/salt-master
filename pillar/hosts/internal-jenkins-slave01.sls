salt:
  # Salt Minion Config
  minion:
    master: salt-master
    hash_type: sha256
    grains:
      roles:
        - salt-minion
        - jenkins-slave
        - docker
      public_ip: 34.246.135.134
      public_interface: eth0
      icinga_dns: ip-172-31-32-15.eu-west-1.compute.internal
      aws_instance_id: i-0a689c407c2d5acd2
      aws_region: eu-west-1
    mine_functions:
      public_ips:
        - mine_function: grains.get
        - public_ip
