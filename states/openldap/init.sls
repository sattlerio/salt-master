slapd:
  pkg.installed:
    - name: slapd
  service.running:
    - enable: True
    - restart: True
    - watch:
      - file: /etc/default/slapd

/etc/ldap/schema/groups.ldif:
  file.managed:
    - source: salt://openldap/schema/groups.ldif

/etc/ldap/schema/memberOf.ldif:
  file.managed:
    - source: salt://openldap/schema/memberOf.ldif


/etc/default/slapd:
  file.managed:
    - source: salt://openldap/files/slapd.default
    - require:
      - pkg: slapd
