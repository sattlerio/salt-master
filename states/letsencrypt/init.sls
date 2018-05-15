{% set _l = salt['pillar.get']('letsencrypt', {}) %}
{% set _global = _l.get('global', {}) %}
{% set _domains = _l.get('domains', {}) %}

'certbot-auto deps':
  pkg.installed:
    - names:
      - python-virtualenv
      - virtualenv
      - libaugeas0
      - augeas-lenses
      - python
      - python-dev
      - gcc
      - dialog
      - libssl-dev
      - libffi-dev
      - ca-certificates

/usr/local/sbin/certbot-auto:
  file.managed:
    - source: salt://letsencrypt/files/certbot-auto
    - mode: 755
    - require:
      - pkg: 'certbot-auto deps'

/etc/letsencrypt/configs:
  file.directory:
    - makedirs: True

{% for _id, _config in _domains.items() %}
  {% set settings = _global.copy() %}
  {% do settings.update(_config) %}
/etc/letsencrypt/configs/{{ _id }}.ini:
  file.managed:
    - source: salt://letsencrypt/files/config.ini
    - template: jinja
    - context:
        settings: {{ settings }}
    - require:
      - file: /etc/letsencrypt/configs

  {% if _config.get('webroot-path', None) %}
{{ _config.get('webroot-path') }}:
  file.directory:
    - makedirs: True
  {% endif %}
{% endfor %}

/etc/cron.d/letsencrypt:
  file.managed:
    - source: salt://letsencrypt/files/letsencrypt.cron
    - template: jinja
    - context:
        ids: {{ _domains.keys() }}
