'gitlab dependencies':
  pkg:
    - installed
    - pkgs:
      - ca-certificates
      - curl
      - openssh-server
      - postfix

download gitlab:
  cmd.run:
    - name: curl -LO https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh && bash script.deb.sh
    - cwd: /tmp
    - unless: test -e /etc/apt/sources.list.d/gitlab_gitlab-ce.list
    - require:
      - pkg: 'gitlab dependencies'

install gitlab-ce:
  pkg:
    - installed
    - pkgs:
      - gitlab-ce
    - require:
      - cmd: download gitlab