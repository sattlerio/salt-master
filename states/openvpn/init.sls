{% if pillar.get('OPENVPN_NGINX') %}

include:
  - containers.nginx

/srv/nginx/config/sites/{{ pillar.get("NGINX_DOMAIN") }}:
  file.managed:
    - source: salt://containers/nginx/templates/nginx_site_with_reverse_proxy.conf
    - template: jinja
    - require:
      - /srv/nginx/config/sites
    - watch_in:
      - cmd: nginx-reload-service

{% endif %}

'install openvpn':
  cmd.run:
    - name: wget http://swupdate.openvpn.org/as/openvpn-as-2.1.12-Ubuntu16.amd_64.deb && dpkg -i openvpn-as-2.1.12-Ubuntu16.amd_64.deb
    - unless: ! file /etc/init.d/openvpn

'set openvpn admin password':
  cmd.run:
    - name: echo "openvpn:{{ pillar.get('openvpn_password')  }}" | chpasswd && touch /usr/pwd.txt
    - unless: ! file /usr/pwd.txt
    - require:
      - cmd: 'install openvpn'
