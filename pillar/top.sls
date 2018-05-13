
{% set mid = salt['grains.get']('id') %}

base:
  '*':
    - ssh-admins
  {{ mid }}:
    - hosts.{{ mid | replace('.', '-') }}
    - hosts.{{ mid | replace('.', '-') }}_secret
