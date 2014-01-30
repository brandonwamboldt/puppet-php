# Type: php::composer::project
#
# Create a Composer project
#
# == Parameters:
#
# :package
#   Package name to be installed
# :directory
#   Directory where the files should be created
# :version
#   Version, will default to latest
# :stability
#   (default=false) Minimum-stability allowed (unless a version is specified)
# :prefer_source
#   (default=false) Forces installation from package sources when possible,
#   including VCS information
# :prefer_dist
#   (default=false) Forces installation from package dist even for dev versions
# :repository_url
#   (default=undef) Pick a different repository url to look for the package
# :dev
#   (default=false) Enables installation of require-dev packages (enabled by
#   default, only present for BC)
# :no_dev
#   (default=false) Disables installation of require-dev packages
# :no_plugins
#   (default=false) Whether to disable plugins
# :no_scripts
#   (default=false) Whether to prevent execution of all defined scripts in the
#   root package
# :keep_vcs
#   (default=false) Whether to prevent deletion vcs folder
# :no_install
#   (default=false) Whether to skip installation of the package dependencies
#
# == Usage:
#
# php::composer::project { 'install_directory':
#   package => 'package_name',
#   version => 'version',
# }
#
# == Example:
#
# php::composer::project { '/var/www/html/example.com':
#   package => 'symfony/framework-standard-edition',
#   version => '2.4.1',
# }

define php::composer::project (
  $package,
  $version,
  $directory            = undef, # $name by default
  $stability            = undef,
  $prefer_source        = false,
  $prefer_dist          = false,
  $repository_url       = undef,
  $dev                  = false,
  $no_dev               = false,
  $no_plugins           = false,
  $no_custom_installers = false,
  $no_scripts           = false,
  $no_progress          = false,
  $keep_vcs             = false,
  $no_install           = false
) {
  include php::composer
  include php::params


}
