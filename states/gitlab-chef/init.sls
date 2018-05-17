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

'/etc/gitlab/gitlab.rb':
  file.managed:
    - chmod: 755
    - template: jinja
    - source: salt://gitlab-chef/files/gitlab.rb
    - require:
      - pkg: install gitlab-ce

'/opt/gitlab/embedded/service/gitlab-rails/config/initializers/local.rb':
  file.managed:
    - chmod: 755
    - template: jinja
    - source: salt://gitlab-chef/files/local.rb
    - require:
      - pkg: install gitlab-ce