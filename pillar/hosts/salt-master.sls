salt:
  # Salt Master Config
  master:
    interface: 10.0.127.54
    hash_type: sha256
    aws_profile:
      region: eu-west-1
      message_format: json
      key: NadSqCqkaqf7VbZp1BqZvwwFBnqbeTdmMeLdvC/j
      keyid: AKIAIZ37SVPSPBKDFOFQ
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
    aws_profile:
      region: eu-west-1
      message_format: json
      key: NadSqCqkaqf7VbZp1BqZvwwFBnqbeTdmMeLdvC/j
      keyid: AKIAIZ37SVPSPBKDFOFQ
    hash_type: sha256
    grains:
      roles:
        - salt-master
        - salt-minion
        - docker
      public_ip: 54.154.135.125
      private_ip: 10.0.127.54
      public_interface: eth0
      icinga_dns: ip-10-0-127-54.eu-west-1.compute.internal
      aws_instance_id: i-0b2f8b06b7ce6691a
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