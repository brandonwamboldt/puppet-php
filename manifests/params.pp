# Class: php::params

class php::params {
  $exec_path = '/usr/bin:/usr/sbin:/bin:/sbin:/usr/local/bin:/usr/local/sbin'

  case $::osfamily {
    'Debian': {
      $package_common = 'php5-common'
      $package_cli    = 'php5-cli'
      $package_dev    = 'php5-dev'
      $package_fpm    = 'php5-fpm'
      $package_pear   = 'php-pear'
      $fpm_service    = 'php5-fpm'
      $php_conf_dir   = '/etc/php5/conf.d'
      $fpm_pool_dir   = '/etc/php5/fpm/pool.d'
      $fpm_conf_dir   = '/etc/php5/fpm'
      $fpm_confd_dir  = '/etc/php5/fpm/conf.d'
      $fpm_error_log  = '/var/log/php5-fpm.log'
      $fpm_pid = '/var/run/php5-fpm.pid'
      $httpd_package_name = 'apache2'
      $httpd_service_name = 'apache2'
      $httpd_conf_dir = '/etc/apache2/conf.d'
    }
    default: {
      $package_common = 'php-common'
      $package_cli    = 'php-cli'
      $package_dev    = 'php-dev'
      $package_fpm    = 'php-fpm'
      $package_pear   = 'php-pear'
      $fpm_service = 'php-fpm'
      $php_conf_dir = '/etc/php.d'
      $fpm_pool_dir = '/etc/php-fpm.d'
      $fpm_conf_dir = '/etc'
      $fpm_confd_dir = '/etc/php.d'
      $fpm_error_log = '/var/log/php-fpm/error.log'
      $fpm_pid = '/var/run/php-fpm/php-fpm.pid'
      $httpd_package_name = 'httpd'
      $httpd_service_name = 'httpd'
      $httpd_conf_dir = '/etc/httpd/conf.d'
    }
  }
}
