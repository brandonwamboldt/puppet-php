# Type: php::fpm::confd_file
#
# Install a conf file in the conf.d directory and restart PHP FPM.
#
# == Parameters:
#
# :ensure
#   (default="present") - What state the config file should be in
# :source
#   A source file, which will be copied into place as the config file. This
#   attribute is mutually exclusive with `source` and `target`
# :content
#   The desired contents of the config file, as a string. This attribute is
#   mutually exclusive with `source` and `target`
# :target
#   Absolute path to another file to link the config file to. This attribute is
#   mutually exclusive with `source` and `target`
#
# == Usage:
#
# php::fpm::confd_file { 'conf_file.conf': }
#
# == Example:
#
# php::fpm::confd_file { 'my_ext.conf':
#   content => 'extension=my_ext.so',
# }

define php::fpm::confd_file (
  $ensure  = 'present',
  $source  = undef,
  $content = undef,
  $target  = undef,
) {
  if $content and $source {
    fail('You may not supply both content and source parameters to php::fpm::confd_file')
  }

  file { "${php::fpm::real_fpm_confd_dir}/${name}":
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => $content,
    source  => $source,
    target  => $target,
    notify  => Service[$fpm_service],
    require => Package[$fpm_package],
  }
}
