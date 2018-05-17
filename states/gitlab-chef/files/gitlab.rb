external_url 'https://git.sattler.io'
nginx['redirect_http_to_https'] = true
nginx['ssl_certificate'] = "/etc/letsencrypt/live/git.sattler.io/fullchain.pem"
nginx['ssl_certificate_key'] = "/etc/letsencrypt/live/git.sattler.io/privkey.pem"

# Disable components that will not be on the GitLab application server
postgresql['enable'] = true
redis['enable'] = true

# alternate ssh port for ssh conncection
gitlab_rails['gitlab_shell_ssh_port'] = 2222

# ldap
gitlab_rails['ldap_enabled'] = true
gitlab_rails['ldap_servers'] = {
'main' => {
  'label' => 'SattlerIO LDAP',
  'host' =>  'ldap.sattler.io',
  'port' => 389,
  'uid' => 'cn',
  'encryption' => 'plain',
  'verify_certificates' => false,
  'bind_dn' => '',
  'password' => '',
  'active_directory' => true,
  'base' => 'ou=users,dc=ldap,dc=sattler,dc=io',
  }
}
