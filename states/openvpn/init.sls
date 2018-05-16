'install openvpn':
  cmd.run:
    - name: wget http://swupdate.openvpn.org/as/openvpn-as-2.1.12-Ubuntu16.amd_64.deb && dpkg -i openvpn-as-2.1.12-Ubuntu16.amd_64.deb
    - unless: ! file /etc/init.d/openvpn

'set openvpn admin password':
  cmd.run:
    - name: echo "openvpn:{{ pillar.get('openvpn_password')  }}" | chpasswd && touch /usr/pwd.txt
    - unless: ! file /usr/pwd.txt
    - require:
      - cmd: 'install openvpn'
