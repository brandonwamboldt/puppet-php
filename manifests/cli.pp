# Class: php::cli
#
# Install the PHP command line package.
#
# == Parameters:
#
# :ensure
#   (default="present") - What state PHP should be in
# :ini_source
#   A source file, which will be copied into place as the PHP INI file
# :ini_content
#   The desired contents of the PHP INI file, as a string. This attribute is
#   mutually exclusive with `source` and `target`
#
# == Example:
#
# include php::cli

class php::cli (
  $ensure      = 'present',
  $ini_source  = undef,
  $ini_content = undef
) {
  require php

  if $ini_content and $ini_source {
    fail('You may not supply both ini_content and ini_source parameters to php::fpm')
  }

  package { $::php::params::package_cli:
    ensure => $ensure,
  }

  if $ensure == 'present' {
    if $ini_source or $ini_content {
      file { '/etc/php5/cli/php.ini':
        ensure  => file,
        source  => $ini_source,
        content => $ini_content,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        require => Package['php5-cli'],
      }
    }
  }
}
