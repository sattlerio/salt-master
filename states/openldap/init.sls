slapd:
  pkg.installed:
    - name: slapd
  service.running:
    - enable: True
    - restart: True
    - watch:
      - file: /etc/default/slapd

/etc/ldap/schema:
  file.recurse:
    - source: salt://openldap/schema
    - include_empty: True
    - clean: True

/etc/default/slapd:
  file.managed:
    - source: salt://openldap/files/slapd.default
    - require:
      - pkg: slapd
