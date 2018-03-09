class exhibitor::service(
  $install_dir = $exhibitor::install_dir,
  $config_dir = $exhibitor::config_dir
) {

  if $::lsbdistrelease in ['16.04'] {
    file { '/lib/systemd/system/exhibitor.service':
      mode    => '0644',
      owner   => 'root',
      group   => 'root',
      content => template('exhibitor/exhibitor.systemd.erb'),
    }~>
    exec { 'exhibitor-systemd-reload':
      command     => 'systemctl daemon-reload',
      path        => [ '/usr/bin', '/bin', '/usr/sbin' ],
      refreshonly => true,
    }
  }
  else {
    file { '/etc/init.d/exhibitor':
      ensure  => present,
      content => template('exhibitor/init.d.erb'),
      mode    => '0755',
      require => Exec['download-exhibitor']
    }

    service { 'exhibitor':
      ensure => 'running',
      require => File['/etc/init.d/exhibitor']
    }
  }
}
