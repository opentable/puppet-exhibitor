class exhibitor::service(
  $install_dir = $exhibitor::install_dir,
) {

  if $lsbdistcodename in ['xenial', 'beaver'] {

    file { '/etc/systemd/system/exhibitor.service':
      ensure => 'present',
      content => template('exhibitor/exhibitor.service.erb'),
      notify  => [
        Service['exhibitor'],
        Exec['/bin/systemctl daemon-reload']],
    }

    exec { '/bin/systemctl daemon-reload':
      refreshonly => true,
    }

    service { 'exhibitor':
      ensure => 'running',
      require => File['/etc/systemd/system/exhibitor.service'],
    }

  } else {
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
