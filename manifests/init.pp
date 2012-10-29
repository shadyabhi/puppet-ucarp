class ucarp ( $service_status = "running" ) {
  $package_name = 'ucarp'

  package { $package_name :
    ensure => installed,
  }

  file { "/etc/init.d/carp" :
    ensure => present,
    source => filelookup("ucarp/carp.init"),
    mode => 755,
    require => Package["ucarp"],
  }

  service { 'carp' :
    ensure => $service_status,
    enable => "true",
    hasstatus => "false",
    require => Package["ucarp"],
    }
}
