sudo.config_file:
  file.managed:
    - name: /etc/sudoers
    - user: root
    - group: root
    - mode: 0440
    - source: salt://sudoers/files/sudoers.conf
    - check_cmd: /usr/sbin/visudo -c -f
