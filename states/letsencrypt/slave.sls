/etc/letsencrypt:
  file.recurse:
    - source: salt://letsencrypt/etc
    - include_empty: True
    - clean: True
    - keep_symlinks: True
