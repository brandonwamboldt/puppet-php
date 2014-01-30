# Class: php::pear
#
# Installs PEAR.
#
# == Parameters:
#
# :ensure
#   (default="present") - What state PEAR should be in
#
# == Example:
#
# include php::pear

class php::pear ($ensure = 'present') {
  include php::params

  package { $package_pear:
    ensure => $ensure,
  }
}
