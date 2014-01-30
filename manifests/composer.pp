# Class: php::composer
#
# Installs Composer.
#
# == Parameters:
#
# :ensure
#   (default="present") - What state Composer should be in
# :install_path
#  (default="/usr/bin/composer") - Absolute path to install Composer to
#
# == Example:
#
# include php::composer

class php::composer ($ensure = 'present', $install_path = '/usr/bin/composer') {
  include php::cli
  include php::params

  if $ensure == 'present' {
    exec { 'php_composer_install':
      command => "curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin && mv /usr/bin/composer.phar ${install_path}",
      creates => $install_path,
      path    => $exec_path,
    }
  } else {
    file { $install_path:
      ensure => absent,
    }
  }
}
