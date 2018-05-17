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
    - unless: test -e /usr/local/node-v7.2.0-linux-x64
    - require:
      - pkg: 'gitlab dependencies'