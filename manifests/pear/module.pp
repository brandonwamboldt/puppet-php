# Type: php::pear::module
#
# Install a PHP library using PEAR (PHP Extension and Application Repository).
#
# == Parameters:
#
# :ensure
#   (default="present") - What state the module should be in
# :version
#   (default="present") - Which version of the module to install
# :preferred_state
#   (default="stable") - Define which preferred state to use when installing
# :repository
#   (default="pear.php.net") - The PEAR repository to install the module from
# :alldeps
#   (default="false") - Define if all the available (optional) modules should
#   be installed
# :timeout
#   (default=300) - Timeout for the PEAR installation process
#
# == Usage:
#
# php::pear::module { 'packagename': }
#
# == Example:
#
# php::pear::module { 'PHP_CodeSniffer': }

define php::pear::module (
  $ensure          = 'present',
  $version         = 'present',
  $preferred_state = 'stable',
  $repository      = 'pear.php.net',
  $alldeps         = false,
  $timeout         = 300,
) {
  include php::pear
  include php::params

  $bool_alldeps   = any2bool($alldeps)
  $manage_alldeps = $bool_alldeps ? {
    true  => '--alldeps',
    false => '',
  }

  $pear_source = $version ? {
    'present' => "${repository}/${name}",
    default   => "${repository}/${name}-${version}",
  }

  $pear_exec_command = $ensure ? {
    present => "pear -d preferred_state=${preferred_state} install ${manage_alldeps} ${pear_source}",
    absent  => "pear uninstall -n ${pear_source}",
  }

  $pear_exec_unless = $ensure ? {
    present => "pear info ${pear_source}",
    absent  => undef
  }

  $pear_exec_onlyif = $ensure ? {
    present => undef,
    absent  => "pear info ${pear_source}",
  }

  if $repository != 'pear.php.net' {
    if !defined (Php::Pear::Config['auto_discover']) {
      php::pear::config { 'auto_discover':
        value => '1',
      }
    }
  }

  exec { "php-pear-module-${name}":
    command => $pear_exec_command,
    path    => $exec_path,
    timeout => $timeout,
    unless  => $pear_exec_unless,
    onlyif  => $pear_exec_onlyif,
    require => Package[$package_pear],
  }
}
