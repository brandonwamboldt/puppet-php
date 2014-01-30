Puppet Module: php
==================

This is a Puppet module for managing PHP.

Usage - CLI
-----------

* Install the command line client for PHP

    ```puppet
    class { 'php': }
    ```

* Configure the PHP command line client with an INI file

    ```puppet
    class { 'php':
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
