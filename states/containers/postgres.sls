postgresql container:
  docker_container.running:
    - name: postgresql-{{ grains['id'] }}
    - image: postgres:{{ pillar.get('POSTGRES_VERSION', '9.6.1') }}
    - binds:
      - /srv/postgresql:/var/lib/postgresql/data:rw
    - environment:
      - POSTGRES_PASSWORD: {{ pillar.get('POSTGRES_PASSWORD') }}
    - restart_policy: always
    - network_mode: {{ pillar.get('POSTGRES_NETWORK', 'bridge') }}
{% if pillar.get('POSTGRES_BIND_PORT', False) %}
    - port_bindings:
      - 127.0.0.1:5432:5432
{% endif %}
