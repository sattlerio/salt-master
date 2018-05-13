{% for mid, addr in salt['mine.get']('*', 'public_ips') | dictsort() %}
/etc/hosts {{ mid }}:
  host.present:
    - ip: {{ addr }}
    - name: {{ mid }}
{% endfor %}