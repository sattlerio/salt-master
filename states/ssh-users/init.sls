{% set users = pillar.get('ssh_users', []) %}

ubuntu:
  user.absent
#ec2-user:
 #user.absent

{% for user in users %}

{% if user.hosts == "*" or salt['grains.get']('id') in user.hosts %}

{{ user.username }}:
  group.present: []

  user.present:
    - fullname: {{ user.fullname }}
    - shell: /bin/bash
    - home: /home/{{ user.username }}
    - gid: {{ user.username }}
    - gid_from_name: True
    - groups:
      - adm
      - dialout
      - cdrom
      - floppy
      - sudo
      - audio
      - dip
      - video
      - plugdev
      - netdev
    - require:
      - group: {{ user.username }}

/home/{{ user.username }}/.ssh:
  file.directory:
    - mode: 700
    - user: {{ user.username }}
    - group: {{ user.username }}
    - require:
      - group: {{ user.username }}
      - user: {{ user.username }}

/home/{{ user.username }}/.ssh/authorized_keys:
  file.managed:
    - mode: 600
    - user: {{ user.username }}
    - group: {{ user.username }}
    - source: salt://ssh-users/files/{{ user.username }}.pub
    - require:
      - file: /home/{{ user.username }}/.ssh
{% else %}

{{ user.username }}:
  user.absent

{% endif %}
{% endfor %}
