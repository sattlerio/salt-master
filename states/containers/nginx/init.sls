/srv/nginx/:
  file.directory:
    - require_in:
      - file: /srv/nginx/config

/srv/nginx/config:
  file.directory
#    - require:
#      - file: /srv/nginx

/srv/nginx/config/sites:
  file.directory:
    - require:
      - file: /srv/nginx/config


/srv/nginx/config/nginx.conf:
  file.managed:
    - source: salt://containers/nginx/files/nginx.conf
    - mode: 777
    - template: jinja
    - require:
      - file: /srv/nginx/config

/srv/nginx/config/h5bp:
  file.recurse:
    - source: salt://containers/nginx/files/h5bp/
    - include_empty: True

/srv/nginx/config/uwsgi_params:
  file.managed:
    - source: salt://containers/nginx/files/uwsgi_params

/srv/nginx/config/fastcgi_params:
  file.managed:
    - source: salt://containers/nginx/files/fastcgi_params

/srv/nginx/config/proxy_params:
  file.managed:
    - source: salt://containers/nginx/files/proxy_params

/srv/nginx/config/mime.types:
  file.managed:
    - source: salt://containers/nginx/files/mime.types

'delete-default-dirs':
  file.absent:
    - names:
      - /srv/nginx/config/conf.d
      - /srv/nginx/config/snippets
      - /srv/nginx/config/sites-enabled
      - /srv/nginx/config/sites-available

'nginx-reload-service':
  cmd.wait:
    - name: docker kill -s HUP nginx-{{ grains['id'] }}
    - watch:
      - file: /srv/nginx/config/nginx.conf
      - file: /srv/nginx/config/h5bp
      - file: /srv/nginx/config/uwsgi_params
      - file: /srv/nginx/config/mime.types
      - file: /srv/nginx/config/fastcgi_params
      - file: /srv/nginx/config/proxy_params
    - require:
      - docker_container: 'nginx-container'

'nginx-container':
  docker_container.running:
    - name: nginx-{{ grains['id'] }}
    - image: {{ pillar.get('NGINX_IMAGE', 'nginx') }}:{{ pillar.get('NGINX_VERSION', '1.11') }}
    - restart_policy: always
    - network_mode: {{ pillar.get('NGINX_NETWORK', 'bridge') }}
{% if pillar.get("NGINX_LINKS") %}
    - links:
{% for link in pillar.get("NGINX_LINKS") %}
      - {{ link }}:{{ link }}
{% endfor %}
{% endif %}
    - binds:
      - /srv/nginx/config:/etc/nginx
      - /srv/nginx/www:/var/www
      - /etc/letsencrypt:/etc/letsencrypt
{% if pillar.get('NGINX_EXTERNAL_VOLUMES') %}
    - volumes_from:
  {% for container in pillar.get('NGINX_EXTERNAL_VOLUMES') %}
      - {{ container.name }}
  {% endfor %}
{% endif %}
{% if pillar.get('NGINX_EXPOSE', True) %}
    - port_bindings:
      - 80:80
      - 443:443
{% endif %}
{% if pillar.get('NGINX_LINKS') or pillar.get('NGINX_EXTERNAL_VOLUMES') %}
    - require:
      - file: /srv/nginx/config
  {% for container in pillar.get('NGINX_LINKS', []) %}
      - docker_container: {{ container }}
  {% endfor %}
  {% for container in pillar.get('NGINX_EXTERNAL_VOLUMES', []) %}
      - docker_container: {{ container.salt_id }}
  {% endfor %}
{% endif %}
{% if pillar.get('NGINX_EXTERNAL_VOLUMES') %}
    - watch:
  {% for container in pillar.get('NGINX_EXTERNAL_VOLUMES', []) %}
      - docker_container: {{ container.salt_id }}
  {% endfor %}
{% endif %}
