class exhibitor::config(
  $opts = $exhibitor::opts,
  $properties = $exhibitor::properties,
  $install_dir = $exhibitor::install_dir
) inherits exhibitor::params {

  $merged_properties = merge($exhibitor::params::properties, $properties)

  if $lsbdistcodename in ['xenial', 'beaver', 'bionic' ] {

    file { '/etc/systemd/system/exhibitor.service.d':
      ensure => 'directory',
    }

    file { '/etc/systemd/system/exhibitor.service.d/exhibitor.conf':
      ensure => 'present',
      content => template('exhibitor/exhibitor.service.conf.erb'),
      notify  => [
        Service['exhibitor'],
        Exec['/bin/systemctl daemon-reload']],
    }

  } else {
    file { '/etc/default/exhibitor':
      ensure  => present,
      content => template('exhibitor/default.erb')
    }
  }

  file { "${install_dir}/exhibitor.properties":
    ensure  => present,
    content => template('exhibitor/exhibitor.properties.erb')
  }
}
