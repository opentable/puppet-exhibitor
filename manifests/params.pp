class exhibitor::params {
  $version = '1.5.2'

  $install_dir = '/opt/exhibitor'
  $install_source = "http://search.maven.org/remotecontent?filepath=com/netflix/exhibitor/exhibitor-standalone/${version}"

  $conf_dir = '/etc/exhibitor'

  $opts = {
    'port'        => '9090',
    'configtype'  => 'file',
    'fsconfigdir' => $install_dir,
    'hostname'    => $::hostname
  }

  $zk_quorum = ['']

  $properties = {
    'com.netflix.exhibitor.auto-manage-instances'                             => '0',
    'com.netflix.exhibitor.backup-max-store-ms'                               => '86400000',
    'com.netflix.exhibitor.backup-period-ms'                                  => '60000',
    'com.netflix.exhibitor.check-ms'                                          => '30000',
    'com.netflix.exhibitor.cleanup-max-files'                                 => '3',
    'com.netflix.exhibitor.cleanup-period-ms'                                 => '43200000',
    'com.netflix.exhibitor.client-port'                                       => '2181',
    'com.netflix.exhibitor.connect-port'                                      => '2888',
    'com.netflix.exhibitor.election-port'                                     => '3888',
    'com.netflix.exhibitor.servers-spec'                                      => '$EXHIBITOR_QUORUM',
    'com.netflix.exhibitor.zoo-cfg-extra'                                     => 'syncLimit\=5&tickTime\=2000&initLimit\=10&quorumListenOnAllIPs\=true',
    'com.netflix.exhibitor.zookeeper-data-directory'                          => '/opt/zookeeper-data',
    'com.netflix.exhibitor.zookeeper-install-directory'                       => '/opt/zookeeper',
    'com.netflix.exhibitor.zookeeper-log-directory'                           => '/opt/zookeeper-data'
  }
}
