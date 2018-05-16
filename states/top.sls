base:
  '*':
    - hosts
    - salt.minion
    - timezone
    - basic_packages
    - sudoers
    - ssh-users
    - default_locale
  'roles:salt-master':
    - match: grain
    - salt.master
    - salt.formulas
    - salt.api
  'roles:ldap-server':
    - match: grain
    - openldap
  'roles:openvpn-server':
    - match: grain
    - openvpn
  'roles:web-apache2':
    - match: grain
    - apache2
  'roles:letsencrypt':
    - match: grain
    - letsencrypt
  'roles:letsencrypt-slave':
    - match: grain
    - letsencrypt.slave
  'roles:docker':
    - match: grain
    - docker
    - docker_io
  'roles:jenkins':
    - match: grain
    - jenkins
{% for container in pillar.get('containers', []) %}
    - {{ container }}
{% endfor %}
