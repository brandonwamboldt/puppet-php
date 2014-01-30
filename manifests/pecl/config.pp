# Define: php::pecl::config
#
# Configures PECL.
#
# == Parameters:
#
# :value
#   The value to set the PEAR config option to
#
# == Usage:
#
# php::pecl::config { 'config_option':
#   value => 'config_value',
# }
#
# == Example:
#
# php::pecl::config { http_proxy:
#   value => "myproxy:8080",
# }

define php::pecl::config ($value, $layer = 'user') {
  include php::pear
  include php::params

  exec { "php_pecl_config_set_${name}":
    command => "pecl config-set ${name} ${value} ${layer}",
    path    => $exec_path,
    unless  => "pecl config-get ${name} | grep ${value}",
    require => Package[$package_pear],
  }

}
