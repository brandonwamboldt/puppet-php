# Type: php::module
#
# Install a PHP module.
#
# == Example:
#
# php::module { 'curl':
#   ensure => present,
# }

define php::module ($ensure = 'present', $prefix = false) {
  include php::params

  if defined(Class[$::php::params::package_fpm]) {
    $to_notify = Class['php::fpm']
  } else {
    $to_notify = undef
  }

  if $prefix {
    $real_prefix = $prefix
  } else {
    $real_prefix = $name ? {
      'apc'                => 'php-',
      'auth'               => 'php-',
      'auth-http'          => 'php-',
      'auth-sasl'          => 'php-',
      'benchmark'          => 'php-',
      'cache'              => 'php-',
      'cache-lite'         => 'php-',
      'codesniffer'        => 'php-',
      'compat'             => 'php-',
      'config'             => 'php-',
      'console-table'      => 'php-',
      'crypt-blowfish'     => 'php-',
      'crypt-cbc'          => 'php-',
      'crypt-gpg'          => 'php-',
      'date'               => 'php-',
      'db'                 => 'php-',
      'doc'                => 'php-',
      'elisp'              => 'php-',
      'event-dispatcher'   => 'php-',
      'file'               => 'php-',
      'fpdf'               => 'php-',
      'geshi'              => 'php-',
      'getid3'             => 'php-',
      'gettext'            => 'php-',
      'html-common'        => 'php-',
      'html-safe'          => 'php-',
      'html-template-it'   => 'php-',
      'htmlpurifier'       => 'php-',
      'http'               => 'php-',
      'http-request'       => 'php-',
      'http-upload'        => 'php-',
      'http-webdav-server' => 'php-',
      'image-text'         => 'php-',
      'imlib'              => 'php-',
      'kolab-filter'       => 'php-',
      'kolab-freebusy'     => 'php-',
      'letodms-core'       => 'php-',
      'letodms-lucene'     => 'php-',
      'log'                => 'php-',
      'mail'               => 'php-',
      'mail-mime'          => 'php-',
      'mail-mimedecode'    => 'php-',
      'mdb2'               => 'php-',
      'mdb2-driver-mysql'  => 'php-',
      'mdb2-driver-pgsql'  => 'php-',
      'mdb2-driver-sqlite' => 'php-',
      'mime-type'          => 'php-',
      'net-checkip'        => 'php-',
      'net-dime'           => 'php-',
      'net-dnsbl'          => 'php-',
      'net-ftp'            => 'php-',
      'net-imap'           => 'php-',
      'net-ipv4'           => 'php-',
      'net-ipv6'           => 'php-',
      'net-ldap'           => 'php-',
      'net-ldap2'          => 'php-',
      'net-lmtp'           => 'php-',
      'net-nntp'           => 'php-',
      'net-ping'           => 'php-',
      'net-portscan'       => 'php-',
      'net-sieve'          => 'php-',
      'net-smartirc'       => 'php-',
      'net-smtp'           => 'php-',
      'net-socket'         => 'php-',
      'net-url'            => 'php-',
      'net-whois'          => 'php-',
      'numbers-words'      => 'php-',
      'openid'             => 'php-',
      'pager'              => 'php-',
      'pear'               => 'php-',
      'radius'             => 'php-',
      'radius-legacy'      => 'php-',
      'services-json'      => 'php-',
      'services-weather'   => 'php-',
      'soap'               => 'php-',
      'text-captcha'       => 'php-',
      'text-figlet'        => 'php-',
      'text-password'      => 'php-',
      'text-wiki'          => 'php-',
      'wikidiff2'          => 'php-',
      'xajax'              => 'php-',
      'xml-htmlsax3'       => 'php-',
      'xml-parser'         => 'php-',
      'xml-rpc'            => 'php-',
      'xml-rpc2'           => 'php-',
      'xml-rss'            => 'php-',
      'xml-serializer'     => 'php-',
      'xml-util'           => 'php-',
      'zeroc-ice'          => 'php-',
      'php-tools'          => 'php-',
      default              => 'php5-',
    }
  }

  package { "${real_prefix}${name}":
    ensure => $ensure,
    notify => $to_notify,
  }
}
