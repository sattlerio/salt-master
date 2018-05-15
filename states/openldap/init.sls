slapd:
  pkg.installed:
    - name: slapd
  service.running:
    - enable: True
    - restart: True
    - watch:
      - file: /etc/default/slapd

/etc/default/slapd:
  file.managed:
    - source: salt://openldap/files/slapd.default
    - require:
      - pkg: slapd
