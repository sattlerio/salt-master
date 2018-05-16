jenkins:
  group.present: []

  user.present:
    - fullname: Jenkins
    - shell: /bin/bash
    - home: /srv/jenkins
    - gid: jenkins
    - gid_from_name: True
    - require:
      - group: jenkins


# INSTALL Node
install node from dist:
  cmd.run:
    - name: wget https://nodejs.org/dist/v7.2.0/node-v7.2.0-linux-x64.tar.xz && tar xf node-v7.2.0-linux-x64.tar.xz
    - cwd: /usr/local
    - unless: test -e /usr/local/node-v7.2.0-linux-x64

rm /usr/local/node-v7.2.0-linux-x64.tar.xz:
  cmd.run:
    - onlyif: test -e /usr/local/node-v7.2.0-linux-x64.tar.xz

/usr/local/bin/node:
  file.symlink:
    - target: /usr/local/node-v7.2.0-linux-x64/bin/node
    - require:
      - cmd: install node from dist
    - unless: test -e /usr/local/bin/node

/usr/local/bin/npm:
  file.symlink:
    - target: /usr/local/node-v7.2.0-linux-x64/bin/npm
    - require:
      - cmd: install node from dist
    - unless: test -e /usr/local/bin/npm

# INSTALL PhantomJS
libfontconfig1:
  pkg.installed

install phantomjs from dist:
  cmd.run:
    - name: wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 && tar xf phantomjs-2.1.1-linux-x86_64.tar.bz2
    - cwd: /usr/local
    - unless: test -e /usr/local/phantomjs-2.1.1-linux-x86_64
    - require:
      - pkg: libfontconfig1

rm /usr/local/phantomjs-2.1.1-linux-x86_64.tar.bz2:
  cmd.run:
    - onlyif: test -e /usr/local/phantomjs-2.1.1-linux-x86_64.tar.bz2

/usr/local/bin/phantomjs:
  file.symlink:
    - target: /usr/local/phantomjs-2.1.1-linux-x86_64/bin/phantomjs
    - require:
      - cmd: install phantomjs from dist
    - unless: test -e /usr/local/bin/phantomjs

install openjdk jre:
  pkg.installed:
    - name: openjdk-8-jre

install openjdk jdk:
  pkg.installed:
    - name: openjdk-8-jdk

{% if 'docker' in salt['grains.get']('roles') %}
add-jenkins-to-docker-group:
  group.present:
    - name: docker
    - addusers:
      - jenkins
{% endif %}

/etc/cron.d/docker-cleanup:
  file.managed:
    - source: salt://jenkins/files/docker-cleanup.cron


/srv/jenkins/.gradle/gradle.properties:
  file.managed:
    - source: salt://jenkins/files/gradle.properties
    - template: jinja

/srv/jenkins/keystore:
  file.managed:
    - source: salt://jenkins/files/sotre


