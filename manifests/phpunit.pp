# Class: php::phpunit
#
# Installs PHPUnit.
#
# == Parameters:
#
# :ensure
#   (default="present") - What state PHPUnit should be in
# :install_path
#  (default="/usr/bin/phpunit") - Absolute path to install PHPUnit to
#
# == Example:
#
# include php::phpunit

class php::phpunit ($ensure = 'present', $install_path = '/usr/bin/phpunit') {
  if $ensure == 'present' {
    exec { 'php_phpunit_install':
      command => "/usr/bin/curl -sS https://phar.phpunit.de/phpunit.phar > ${install_path} && /bin/chmod a+x /usr/bin/phpunit",
      creates => '/usr/bin/phpunit',
      user    => 'root',
      group   => 'root',
      timeout => 60,
    }
  } else {
    file { '/usr/bin/phpunit':
      ensure => absent,
    }
  }
}
