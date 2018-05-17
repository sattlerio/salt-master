'jenkins deps':
  pkg.installed:
    - name: mailutils

/etc/apt/sources.list.d/jenkins.list:
  file.managed:
    - source: salt://jenkins/files/jenkins.list

jenkins:
  pkg.installed:
    - name: jenkins
    - skip_verify: True
    - require:
      - file: /etc/apt/sources.list.d/jenkins.list
  service.running:
    - enable: True
    - restart: True
    - watch:
      - file: /etc/default/jenkins
    - __monitoring__:
      - service: service_running
        title: Jenkins CI Server
        service_name: jenkins

  file.managed:
    - source: salt://jenkins/files/jenkins.default
