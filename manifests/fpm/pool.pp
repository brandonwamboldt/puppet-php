# Type: php::fpm::pool
#
# Create a new PHP FPM pool.
#
# == Parameters:
#
# :ensure
#   (default="present") - What state the pool should be in
# :source
#   A source file, which will be copied into place as the pool config file. This
#   attribute is mutually exclusive with `source`
# :content
#   The desired contents of the pool config file, as a string. This attribute is
#   mutually exclusive with `source`
# :listen
#   (default="127.0.0.1:9000") - The address on which to accept FastCGI requests
# :listen_backlog
#   (default="-1") - Set listen(2) backlog. A value of '-1' means unlimited
# :listen_allowed_clients
#   List of ipv4 addresses of FastCGI clients which are allowed to connect
# :listen_owner
#   (default="root") - Set permissions for unix socket, if one is used
# :listen_group
#   (default="root") - Set permissions for unix socket, if one is used
# :listen_mode
#   (default="0666") - Set permissions for unix socket, if one is used
# :user
#   (default="www-data") - Unix user of FPM processes
# :group
#   (default="www-data") - Unix group of FPM processes
# :pm
#   (default="dynamic") - Choose how the process manager will control the number
#   of child processes
# :pm_max_children
#   (default="50") - The number of child processes to be created when `pm` is
#   set to `static` and the maximum number of child processes to be created when
#   `pm` is set to `dynamic`
# :pm_start_servers
#   (default="5") - The number of child processes created on startup
# :pm_min_spare_servers
#   (default="5") - The desired minimum number of idle server processes
# :pm_max_spare_servers
#   (default="35") - The desired maximum number of idle server processes
# :pm_max_requests
#   (default="0") - The number of requests each child process should execute
#   before respawning
# :pm_status_path
#   The URI to view the FPM status page
# :ping_path
#   The ping URI to call the monitoring page of FPM
# :ping_response
#   (default="pong") - This directive may be used to customize the response to a
#   ping request
# :request_terminate_timeout
#   (default="0") - The timeout for serving a single request after which the
#   worker process will be killed
# :request_slowlog_timeout
#   (default="0") - The timeout for serving a single request after which a PHP
#   backtrace will be dumped to the 'slowlog' file
# :slowlog
#   (default="/var/log/php-fpm/${name}-slow.log") - The log file for slow
#   requests
# :rlimit_files
#   Set open file descriptor rlimit
# :rlimit_core
#   Set max core size rlimit
# :chroot
#   Chroot to this directory at the start
# :chdir
#   Chdir to this directory at the start
# :catch_workers_output
#   (default="no") - Redirect worker stdout and stderr into main error log
# :limit_extensions
#   (default=".php") -
# :env
#   Hash of environment variables to set
# :php_value
#   Hash of PHP values to set
# :php_flag
#   Hash of PHP flags to set
# :php_admin_value
#   Hash of PHP values to set using php_admin_value
# :php_admin_flag
#   Hash of PHP flags to set using php_admin_flag
# :php_directives
#   Array of other directives to append to the config file
#
# == Example:
#
# php::fpm::pool { 'example':
#   source => 'puppet:///files/your/site/php/example.conf',
# }
#
# php::fpm::pool { 'example':
#   listen => '/var/run/php-fpm.sock',
# }

define php::fpm::pool (
  $ensure                    = 'present',
  $source                    = undef,
  $content                   = undef,
  $listen                    = '127.0.0.1:9000',
  $listen_backlog            = '-1',
  $listen_allowed_clients    = '',
  $listen_owner              = 'root',
  $listen_group              = 'root',
  $listen_mode               = '0666',
  $user                      = 'www-data',
  $group                     = 'www-data',
  $pm                        = 'dynamic',
  $pm_max_children           = '50',
  $pm_start_servers          = '5',
  $pm_min_spare_servers      = '5',
  $pm_max_spare_servers      = '35',
  $pm_max_requests           = '0',
  $pm_status_path            = undef,
  $ping_path                 = undef,
  $ping_response             = 'pong',
  $request_terminate_timeout = '0',
  $request_slowlog_timeout   = '0',
  $slowlog                   = "/var/log/php-fpm/${name}-slow.log",
  $rlimit_files              = undef,
  $rlimit_core               = undef,
  $chroot                    = undef,
  $chdir                     = undef,
  $catch_workers_output      = 'no',
  $limit_extensions          = '.php',
  $env                       = {},
  $php_value                 = {},
  $php_flag                  = {},
  $php_admin_value           = {},
  $php_admin_flag            = {},
  $php_directives            = []
) {
  include php::fpm
  include php::params

  if $content and $source {
    fail('You may not supply both content and source parameters to php::fpm::pool')
  }

  if $content or $source {
    file { "${php::fpm::real_fpm_pool_dir}/${name}.conf":
      ensure  => $ensure,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => $content,
      source  => $source,
      notify  => Service[$service_fpm],
      require => Package[$package_fpm],
    }
  } else {
    file { "${php::fpm::real_fpm_pool_dir}/${name}.conf":
      ensure  => $ensure,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template('php/pool.conf.erb'),
      notify  => Service[$service_fpm],
      require => Package[$package_fpm],
    }
  }
}
