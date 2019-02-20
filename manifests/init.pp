class exhibitor(
  $conf_dir       = $exhibitor::params::conf_dir,
  $install_dir    = $exhibitor::params::install_dir,
  $install_source = $exhibitor::params::install_source,
  $opts           = $exhibitor::params::opts,
  $properties     = $exhibitor::params::properties,
  $version        = $exhibitor::params::version,
  $zk_quorum      = ''
) inherits exhibitor::params {

  class { 'exhibitor::install': } ->
  class { 'exhibitor::config': } ~>
  class { 'exhibitor::service': } ->
  Class['exhibitor']
}
