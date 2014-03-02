Puppet Module: php
==================

This is a Puppet module for managing PHP.

Compatibility
-------------

This module was built for use with Ubuntu, and probably won't work with CentOS/RedHat.

Usage - CLI
-----------

* Install the command line client for PHP

    ```puppet
    include php::cli
    ```

* Configure the PHP command line client with an INI file

    ```puppet
    class { 'php::cli':
      ini_source => 'puppet:///path/to/your/php.ini',
    }
    ```

Usage - FPM
-----------

* Install PHP-FPM

    ```puppet
    class { 'php::fpm': }
    ```

* Configure PHP-FPM

    ```puppet
    class { 'php::fpm':
      log_owner => 'php',
      log_group => 'php',
      error_log => '/var/log/php5-fpm.log',
    }
    ```

* Add a pool definition to PHP-FPM

    ```puppet
    php::fpm::pool { 'example':
      listen          => '/var/run/php5-fpm.sock',
      pm_status_path  => '/server-status',
      php_admin_flag  => {
        display_errors => 'off',
        log_errors     => 'on'
      },
      php_admin_value => {
        memory_limit        => '128M',
        post_max_size       => '128M',
        upload_max_filesize => '128M'
      },
    }
    ```

* Add a custom config file

    ```puppet
    php::fpm::confd_file { 'custom.conf':
      ensure => present,
      source => 'puppet:///files/php/custom.conf',
    }
    ```

Usage - PHPUnit
---------------

* Install PHPUnit

    ```puppet
    include php::phpunit
    ```

Usage - PEAR/PECL
-----------------

* Install PEAR/PECL

    ```puppet
    include php::pear
    ```

* Install a PECL extension

    ```puppet
    php::pecl::extension { 'memcache':
      ensure => present,
    }
    ```

* Change a PECL config value

    ```puppet
    php::pecl::config { 'http_proxy':
      value => "myproxy:8080",
    }
    ```

* Install a PEAR package

    ```puppet
    php::pear::module { 'PHP_CodeSniffer':
      ensure => present,
    }
    ```

* Change a PEAR config value

    ```puppet
    php::pear::config { 'http_proxy':
      value => "myproxy:8080",
    }
    ```

Usage - Composer
----------------

Note: by default, Composer is installed to `/usr/bin/composer`, not `/usr/bin/composer.phar`.

* Install Composer

    ```puppet
    include php::composer
    ```

* Setup a new project

    ```puppet
    php::composer::project { '/var/www/html/example.com':
      package => 'symfony/framework-standard-edition',
      version => '2.4.1',
    }
    ```
