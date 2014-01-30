# Type: php::pear::config
#
# Configures PEAR.
#
# == Parameters:
#
# :value
#   The value to set the PEAR config option to
#
# == Usage:
#
# php::pear::config { 'config_option':
#   value => 'config_value',
# }
#
# == Example:
#
# php::pear::config { 'http_proxy':
#   value => 'myproxy:8080',
# }

define php::pear::config ($value) {
  include php::pear
  include php::params

  exec { "php_pear_config_set_${name}":
    command => "pear config-set ${name} ${value}",
    path    => $exec_path,
    unless  => "pear config-get ${name} | grep ${value}",
    require => Package[$package_pear],
  }
}
