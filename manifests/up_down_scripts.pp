class ucarp::up_down_scripts {

    notify { "${node_id}": }
    #Creating vip up/down scripts
    file { "vip-up":
      ensure => $present,
      path => '/etc/sysconfig/carp/vip-up',
      content => template("ucarp/vip-up.erb"),
      require => Package['ucarp'],
      mode => 755,
    }

    file { "vip-down":
      ensure => $present,
      path => '/etc/sysconfig/carp/vip-down',
      content => template("ucarp/vip-down.erb"),
      mode => 755,
      require => Package['ucarp'],
    }
}
