# Class: php
#
# Install PHP common files and dev files.
#
# == Parameters:
#
# :ensure
#   (default="present") - What state the PHP package should be in
#
# == Example:
#
# include php

class php ($ensure = 'present') {
  include php::params

  package { $common_package_name:
    ensure  => $ensure,
  }

  package { $package_dev:
    ensure  => $ensure,
    require => Package[$common_package_name],
  }
}
