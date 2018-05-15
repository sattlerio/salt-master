/srv/ssl/:
  file.directory

/srv/ssl:
  file.recurse:
    - source: salt://containers/nginx/files/ssl
    - include_empty: True

include:
  - apache.modules
  - apache.vhosts.standard






