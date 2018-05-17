mongodb container:
  docker_container.running:
    - name: mongodb-{{ grains['id'] }}
    - image: mongo:{{ pillar.get('MONGODB_VERSION', '3.2.11') }}
    - binds:
      - /srv/mongodb:/data/db:rw
    - restart_policy: always
    - network_mode: {{ pillar.get('MONGODB_NETWORK', 'bridge') }}
{% if pillar.get('MONGODB_BIND_PORT', False) %}
    - port_bindings:
      - 127.0.0.1:27017:27017
{% endif %}
    - __monitoring__:
        - service: container-running
          title: mongodb container
          container_name: mongodb-{{ grains['id'] }}

{% if pillar.get('MONGODB_AUTHENTICATION', False) %}
set_mongodb_password:
   file.append:
     - name: /etc/profile.d/globalenvvars.sh
     - text: export RIMI_PASSWORD={{ pillar['MONGODB_USER_PASSWORD'] }}
{% endif %}
