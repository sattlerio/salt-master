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