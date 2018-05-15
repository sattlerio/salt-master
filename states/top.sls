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
  'roles:web-apache2':
    - match: grain
    - apache2