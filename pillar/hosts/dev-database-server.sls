salt:
  # Salt Minion Config
  minion:
    master: salt-master
    hash_type: sha256
    grains:
      roles:
        - salt-minion
        - docker
      public_ip: 34.249.95.190
      public_interface: eth0
      icinga_dns: ip-172-31-31-141.eu-west-1.compute.internal
      aws_instance_id: i-006837b874d90a94e
      aws_region: eu-west-1
    mine_functions:
      public_ips:
        - mine_function: grains.get
        - public_ip

POSTGRES_BIND_PORT: True

containers:
  - containers.postgres
