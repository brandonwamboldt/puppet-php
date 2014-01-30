# Type: php::pecl::extension
#
# Install a PHP extension using PECL (the PHP Extension Community Library).
#
# == Parameters:
#
# :ensure
#   (default="present") - What state the extension should be in
# :version
#   Version of the extension to install
# :preferred_state
#   (default="stable") - The preferred state of the extension to install
# :restart_service
#   (default=true) - Whether to restart PHP-FPM and/or Apache
#
# == Usage:
#
# php::pecl::extension { 'extension_name': }
#
# == Example:
#
# php::pecl::extension { 'memcache':
#   ensure => present,
# }

define php::pecl::extension (
  $ensure          = 'present',
  $version         = '',
  $preferred_state = 'stable',
  $restart_service = true
) {
  include php::pear
  include php::params

  if defined(Service[$fpm_service]) and $restart_service {
    $to_notify = Service[$fpm_service]
  } else {
    $to_notify = []
  }

  if $version != '' {
    $version_suffix = "-${version}"
  } else {
    $version_suffix = ''
  }

  if $ensure == 'present' or $ensure == 'installed' {
    exec { "php_pecl_extension_${name}":
      command => "pecl -d preferred_state=${preferred_state} install ${name}${version_suffix}",
      unless  => "pecl info ${name}",
      notify  => $to_notify,
      require => Package[$package_pear],
    }
  } else {
    exec { "php_pecl_extension_${name}":
      command => "pecl uninstall -n ${name}${version_suffix}",
      onlyif  => "pecl info ${name}",
      notify  => $to_notify,
      require => Package[$package_pear],
    }
  }
}
