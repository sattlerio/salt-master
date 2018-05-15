'install php module':
  pkg:
    - installed
    - pkgs:
      - libapache2-mod-php7.0
      - libapache2-mod-php

/srv/ssl/:
  file.directory

/srv/ssl:
  file.recurse:
    - source: salt://containers/nginx/files/ssl
    - include_empty: True

include:
  - apache.modules
  - apache.vhosts.standard






