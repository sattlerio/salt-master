'install php module':
  pkg:
    - installed
    - pkgs:
      - libapache2-mod-php7.0
      - libapache2-mod-php

/srv/ssl/:
  file.directory

include:
  - apache.modules
  - apache.vhosts.standard






