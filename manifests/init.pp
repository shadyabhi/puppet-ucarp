class ucarp {
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
    ensure => "running",
    enable => "true",
    hasstatus => "true",
    require => Package["ucarp"],
    }
}
