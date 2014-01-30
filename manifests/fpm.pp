# Class: php::fpm
#
# Install the PHP FPM daemon.
#
# == Parameters:
#
# :ensure
#   (default="present") - What state PHP FPM should be in
# :start
#   (default="running") - What state the PHP FPM service should be in
# :enable
#   (default=true) - Whether PHP-FPM should be enabled to start at boot
# :pid_file
#   (default="/var/run/php5-fpm.pid") - Path to PID file
# :log_directory
#   (default="/var/log/php-fpm") - Log directory
# :log_level
#   (default="notice") - Error log level
# :log_owner
#   (default="www-data") - User to own the log directory
# :log_group
#   (default="www-data") - Group to own the log directory
# :error_log
#   (default="/var/log/php-fpm/php5-fpm.log") - Path to error log file
# :emergency_restart_threshold
#   (default=10) - If this number of child processes exit with SIGSEGV or SIGBUS
#   within the time interval set then FPM will restart
# :emergency_restart_interval
#   (default="1m") - Interval of time used by emergency_restart_interval to
#   determine when a graceful restart will be initiated.
# :process_control_timeout
#   (default="15s") - Time limit for child processes to wait for a reaction on
#   signals from master
# :daemonize
#   (default="yes") - Send FPM to background
# :fpm_include
#   Glob pattern to include additional PHP FPM config files from
# :pool_include
#   Glob pattern to include PHP FPM pool config files from
# :ini_source
#   A source file, which will be copied into place as the PHP INI file
# :ini_content
#   The desired contents of the PHP INI file, as a string. This attribute is
#   mutually exclusive with `source` and `target`
# :fpm_pool_dir
#   Directory to load pool definitions from
# :fpm_confd_dir
#   Directory to load additional config files from
#
# == Usage:
#
# class { 'php::fpm': }
#
# == Example:
#
# class { 'php::fpm':
#   ini_source => 'puppet:///files/php.ini',
# }

class php::fpm (
  $ensure                      = 'present',
  $start                       = 'running',
  $enable                      = true,
  $pid_file                    = '/var/run/php5-fpm.pid',
  $log_directory               = '/var/log/php-fpm',
  $log_level                   = 'notice',
  $log_owner                   = 'www-data',
  $log_group                   = 'www-data',
  $error_log                   = '/var/log/php-fpm/php5-fpm.log',
  $emergency_restart_threshold = 10,
  $emergency_restart_interval  = '1m',
  $process_control_timeout     = '15s',
  $daemonize                   = 'yes',
  $fpm_include                 = undef,
  $ini_source                  = undef,
  $ini_content                 = undef,
  $fpm_pool_dir                = undef,
  $fpm_confd_dir               = undef,
) {
  include php
  include php::params

  if $fpm_pool_dir == undef {
    $real_fpm_pool_dir = $php::params::fpm_pool_dir
  } else {
    $real_fpm_pool_dir = $fpm_pool_dir
  }

  if $fpm_confd_dir == undef {
    $real_fpm_confd_dir = $php::params::fpm_confd_dir
  } else {
    $real_fpm_confd_dir = $fpm_confd_dir
  }

  if $fpm_include == undef {
    $real_fpm_include = "${fpm_confd_dir}/*.conf"
  } else {
    $real_fpm_include = $fpm_include
  }

  if $ini_content and $ini_source {
    fail('You may not supply both ini_content and ini_source parameters to php::fpm')
  }

  package { $package_fpm:
    ensure => $ensure,
  }

  if $ensure == 'present' {
    service { $fpm_service:
      ensure  => $start,
      enable  => $enable,
      require => [Package[$package_fpm], File[$log_directory]],
    }

    file { $log_directory:
      ensure  => directory,
      owner   => $log_owner,
      group   => $log_group,
      mode    => '0775',
      require => Package[$package_fpm],
    }

    file { "${fpm_conf_dir}/php-fpm.conf":
      ensure  => file,
      content => template('php/php-fpm.conf.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      notify  => Service[$fpm_service],
      require => Package[$package_fpm],
    }

    file { $real_fpm_pool_dir:
      ensure  => directory,
      owner   => 'root',
      group   => 'root',
      recurse => true,
      purge   => true,
      force   => true,
      notify  => Service[$fpm_service],
      require => Package[$package_fpm],
    }

    file { $real_fpm_confd_dir:
      ensure  => directory,
      owner   => 'root',
      group   => 'root',
      notify  => Service[$fpm_service],
      require => Package[$package_fpm],
    }

    if $ini_source or $ini_content {
      file { "${fpm_conf_dir}/php.ini":
        ensure  => file,
        source  => $ini_source,
        content => $ini_content,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        notify  => Service[$fpm_service],
        require => Package[$package_fpm],
      }
    }
  }
}
