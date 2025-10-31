# paw_ansible_role_gitlab
# @summary Manage paw_ansible_role_gitlab configuration
#
# @param gitlab_external_url
# @param gitlab_time_zone Optional settings.
# @param gitlab_backup_keep_time
# @param gitlab_email_from
# @param gitlab_email_display_name
# @param gitlab_email_reply_to
# @param gitlab_default_theme
# @param gitlab_ssl_certificate
# @param gitlab_ssl_certificate_key
# @param gitlab_letsencrypt_auto_renew_hour
# @param gitlab_letsencrypt_auto_renew_minute
# @param gitlab_letsencrypt_auto_renew_day_of_month
# @param gitlab_git_data_dir
# @param gitlab_backup_path
# @param gitlab_ldap_host
# @param gitlab_ldap_port
# @param gitlab_ldap_uid
# @param gitlab_ldap_method
# @param gitlab_ldap_bind_dn
# @param gitlab_ldap_password
# @param gitlab_ldap_base
# @param gitlab_nginx_listen_port
# @param gitlab_smtp_address
# @param gitlab_smtp_port
# @param gitlab_smtp_user_name
# @param gitlab_smtp_password
# @param gitlab_smtp_domain
# @param gitlab_smtp_authentication
# @param gitlab_smtp_openssl_verify_mode
# @param gitlab_smtp_ca_path
# @param gitlab_smtp_ca_file
# @param gitlab_nginx_ssl_verify_client 2-way SSL Client Authentication support.
# @param gitlab_nginx_ssl_client_certificate
# @param gitlab_registry_external_url
# @param gitlab_registry_nginx_ssl_certificate
# @param gitlab_registry_nginx_ssl_certificate_key
# @param setting
# @param gitlab_domain General config.
# @param gitlab_edition
# @param gitlab_version
# @param gitlab_config_template
# @param gitlab_redirect_http_to_https SSL Configuration.
# @param gitlab_create_self_signed_cert SSL Self-signed Certificate Configuration.
# @param gitlab_self_signed_cert_subj
# @param gitlab_ldap_enabled LDAP Configuration.
# @param gitlab_smtp_enable SMTP Configuration
# @param gitlab_smtp_enable_starttls_auto
# @param gitlab_smtp_tls
# @param gitlab_restart_handler_failed_when Probably best to leave this as the default, unless doing testing.
# @param gitlab_dependencies Dependencies.
# @param gitlab_download_validate_certs
# @param gitlab_email_enabled Email configuration.
# @param gitlab_registry_enable Registry configuration.
# @param gitlab_letsencrypt_enable LetsEncrypt configuration.
# @param gitlab_letsencrypt_contact_emails
# @param gitlab_letsencrypt_auto_renew
# @param par_tags An array of Ansible tags to execute (optional)
# @param par_skip_tags An array of Ansible tags to skip (optional)
# @param par_start_at_task The name of the task to start execution at (optional)
# @param par_limit Limit playbook execution to specific hosts (optional)
# @param par_verbose Enable verbose output from Ansible (optional)
# @param par_check_mode Run Ansible in check mode (dry-run) (optional)
# @param par_timeout Timeout in seconds for playbook execution (optional)
# @param par_user Remote user to use for Ansible connections (optional)
# @param par_env_vars Additional environment variables for ansible-playbook execution (optional)
# @param par_logoutput Control whether playbook output is displayed in Puppet logs (optional)
# @param par_exclusive Serialize playbook execution using a lock file (optional)
class paw_ansible_role_gitlab (
  String $gitlab_external_url = 'https://{{ gitlab_domain }}/',
  String $gitlab_time_zone = 'UTC',
  String $gitlab_backup_keep_time = '604800',
  String $gitlab_email_from = 'gitlab@example.com',
  String $gitlab_email_display_name = 'Gitlab',
  String $gitlab_email_reply_to = 'gitlab@example.com',
  String $gitlab_default_theme = '2',
  String $gitlab_ssl_certificate = '/etc/gitlab/ssl/{{ gitlab_domain }}.crt',
  String $gitlab_ssl_certificate_key = '/etc/gitlab/ssl/{{ gitlab_domain }}.key',
  Integer $gitlab_letsencrypt_auto_renew_hour = 1,
  Integer $gitlab_letsencrypt_auto_renew_minute = 30,
  String $gitlab_letsencrypt_auto_renew_day_of_month = '*/7',
  String $gitlab_git_data_dir = '/var/opt/gitlab/git-data',
  String $gitlab_backup_path = '/var/opt/gitlab/backups',
  String $gitlab_ldap_host = 'example.com',
  String $gitlab_ldap_port = '389',
  String $gitlab_ldap_uid = 'sAMAccountName',
  String $gitlab_ldap_method = 'plain',
  String $gitlab_ldap_bind_dn = 'CN=Username,CN=Users,DC=example,DC=com',
  String $gitlab_ldap_password = 'password',
  String $gitlab_ldap_base = 'DC=example,DC=com',
  Optional[String] $gitlab_nginx_listen_port = undef,
  String $gitlab_smtp_address = 'smtp.server',
  String $gitlab_smtp_port = '465',
  String $gitlab_smtp_user_name = 'smtp user',
  String $gitlab_smtp_password = 'smtp password',
  String $gitlab_smtp_domain = 'example.com',
  String $gitlab_smtp_authentication = 'login',
  String $gitlab_smtp_openssl_verify_mode = 'none',
  String $gitlab_smtp_ca_path = '/etc/ssl/certs',
  String $gitlab_smtp_ca_file = '/etc/ssl/certs/ca-certificates.crt',
  Optional[String] $gitlab_nginx_ssl_verify_client = undef,
  Optional[String] $gitlab_nginx_ssl_client_certificate = undef,
  String $gitlab_registry_external_url = 'https://gitlab.example.com:4567',
  String $gitlab_registry_nginx_ssl_certificate = '/etc/gitlab/ssl/gitlab.crt',
  String $gitlab_registry_nginx_ssl_certificate_key = '/etc/gitlab/ssl/gitlab.key',
  Optional[String] $setting = undef,
  String $gitlab_domain = 'gitlab',
  String $gitlab_edition = 'gitlab-ce',
  Optional[String] $gitlab_version = undef,
  String $gitlab_config_template = 'gitlab.rb.j2',
  Boolean $gitlab_redirect_http_to_https = true,
  Boolean $gitlab_create_self_signed_cert = true,
  String $gitlab_self_signed_cert_subj = '/C=US/ST=Missouri/L=Saint Louis/O=IT/CN={{ gitlab_domain }}',
  Boolean $gitlab_ldap_enabled = false,
  Boolean $gitlab_smtp_enable = false,
  Boolean $gitlab_smtp_enable_starttls_auto = true,
  Boolean $gitlab_smtp_tls = false,
  String $gitlab_restart_handler_failed_when = 'gitlab_restart.rc != 0',
  Array $gitlab_dependencies = ['openssh-server', 'postfix', 'curl', 'openssl', 'tzdata'],
  Boolean $gitlab_download_validate_certs = true,
  Boolean $gitlab_email_enabled = false,
  Boolean $gitlab_registry_enable = false,
  Boolean $gitlab_letsencrypt_enable = false,
  Array $gitlab_letsencrypt_contact_emails = ['gitlab@example.com'],
  Boolean $gitlab_letsencrypt_auto_renew = true,
  Optional[Array[String]] $par_tags = undef,
  Optional[Array[String]] $par_skip_tags = undef,
  Optional[String] $par_start_at_task = undef,
  Optional[String] $par_limit = undef,
  Optional[Boolean] $par_verbose = undef,
  Optional[Boolean] $par_check_mode = undef,
  Optional[Integer] $par_timeout = undef,
  Optional[String] $par_user = undef,
  Optional[Hash] $par_env_vars = undef,
  Optional[Boolean] $par_logoutput = undef,
  Optional[Boolean] $par_exclusive = undef
) {
# Execute the Ansible role using PAR (Puppet Ansible Runner)
  $vardir = pick($facts['puppet_vardir'], $settings::vardir, '/opt/puppetlabs/puppet/cache')
  $playbook_path = "${vardir}/lib/puppet_x/ansible_modules/ansible_role_gitlab/playbook.yml"

  par { 'paw_ansible_role_gitlab-main':
    ensure        => present,
    playbook      => $playbook_path,
    playbook_vars => {
      'gitlab_external_url'                        => $gitlab_external_url,
      'gitlab_time_zone'                           => $gitlab_time_zone,
      'gitlab_backup_keep_time'                    => $gitlab_backup_keep_time,
      'gitlab_email_from'                          => $gitlab_email_from,
      'gitlab_email_display_name'                  => $gitlab_email_display_name,
      'gitlab_email_reply_to'                      => $gitlab_email_reply_to,
      'gitlab_default_theme'                       => $gitlab_default_theme,
      'gitlab_ssl_certificate'                     => $gitlab_ssl_certificate,
      'gitlab_ssl_certificate_key'                 => $gitlab_ssl_certificate_key,
      'gitlab_letsencrypt_auto_renew_hour'         => $gitlab_letsencrypt_auto_renew_hour,
      'gitlab_letsencrypt_auto_renew_minute'       => $gitlab_letsencrypt_auto_renew_minute,
      'gitlab_letsencrypt_auto_renew_day_of_month' => $gitlab_letsencrypt_auto_renew_day_of_month,
      'gitlab_git_data_dir'                        => $gitlab_git_data_dir,
      'gitlab_backup_path'                         => $gitlab_backup_path,
      'gitlab_ldap_host'                           => $gitlab_ldap_host,
      'gitlab_ldap_port'                           => $gitlab_ldap_port,
      'gitlab_ldap_uid'                            => $gitlab_ldap_uid,
      'gitlab_ldap_method'                         => $gitlab_ldap_method,
      'gitlab_ldap_bind_dn'                        => $gitlab_ldap_bind_dn,
      'gitlab_ldap_password'                       => $gitlab_ldap_password,
      'gitlab_ldap_base'                           => $gitlab_ldap_base,
      'gitlab_nginx_listen_port'                   => $gitlab_nginx_listen_port,
      'gitlab_smtp_address'                        => $gitlab_smtp_address,
      'gitlab_smtp_port'                           => $gitlab_smtp_port,
      'gitlab_smtp_user_name'                      => $gitlab_smtp_user_name,
      'gitlab_smtp_password'                       => $gitlab_smtp_password,
      'gitlab_smtp_domain'                         => $gitlab_smtp_domain,
      'gitlab_smtp_authentication'                 => $gitlab_smtp_authentication,
      'gitlab_smtp_openssl_verify_mode'            => $gitlab_smtp_openssl_verify_mode,
      'gitlab_smtp_ca_path'                        => $gitlab_smtp_ca_path,
      'gitlab_smtp_ca_file'                        => $gitlab_smtp_ca_file,
      'gitlab_nginx_ssl_verify_client'             => $gitlab_nginx_ssl_verify_client,
      'gitlab_nginx_ssl_client_certificate'        => $gitlab_nginx_ssl_client_certificate,
      'gitlab_registry_external_url'               => $gitlab_registry_external_url,
      'gitlab_registry_nginx_ssl_certificate'      => $gitlab_registry_nginx_ssl_certificate,
      'gitlab_registry_nginx_ssl_certificate_key'  => $gitlab_registry_nginx_ssl_certificate_key,
      'setting'                                    => $setting,
      'gitlab_domain'                              => $gitlab_domain,
      'gitlab_edition'                             => $gitlab_edition,
      'gitlab_version'                             => $gitlab_version,
      'gitlab_config_template'                     => $gitlab_config_template,
      'gitlab_redirect_http_to_https'              => $gitlab_redirect_http_to_https,
      'gitlab_create_self_signed_cert'             => $gitlab_create_self_signed_cert,
      'gitlab_self_signed_cert_subj'               => $gitlab_self_signed_cert_subj,
      'gitlab_ldap_enabled'                        => $gitlab_ldap_enabled,
      'gitlab_smtp_enable'                         => $gitlab_smtp_enable,
      'gitlab_smtp_enable_starttls_auto'           => $gitlab_smtp_enable_starttls_auto,
      'gitlab_smtp_tls'                            => $gitlab_smtp_tls,
      'gitlab_restart_handler_failed_when'         => $gitlab_restart_handler_failed_when,
      'gitlab_dependencies'                        => $gitlab_dependencies,
      'gitlab_download_validate_certs'             => $gitlab_download_validate_certs,
      'gitlab_email_enabled'                       => $gitlab_email_enabled,
      'gitlab_registry_enable'                     => $gitlab_registry_enable,
      'gitlab_letsencrypt_enable'                  => $gitlab_letsencrypt_enable,
      'gitlab_letsencrypt_contact_emails'          => $gitlab_letsencrypt_contact_emails,
      'gitlab_letsencrypt_auto_renew'              => $gitlab_letsencrypt_auto_renew,
    },
    tags          => $par_tags,
    skip_tags     => $par_skip_tags,
    start_at_task => $par_start_at_task,
    limit         => $par_limit,
    verbose       => $par_verbose,
    check_mode    => $par_check_mode,
    timeout       => $par_timeout,
    user          => $par_user,
    env_vars      => $par_env_vars,
    logoutput     => $par_logoutput,
    exclusive     => $par_exclusive,
  }
}
