sonatype nexu3 container:
  docker_container.running:
    - name: nexus3-{{ grains['id'] }}
    - image: sonatype/nexus3:latest
    - binds:
      - /srv/nexus3/data:/nexus-data:rw
    - restart_policy: always
    - user: root
    - port_bindings:
      - 8081:8081
      - 8082:8082
    - network_mode: {{ pillar.get('NEXUS3_NETWORK', 'bridge') }}
    - __monitoring__:
      - service: container-running
        title: sonatype nexus3 container
        container_name: nexus3-{{ grains['id'] }}
