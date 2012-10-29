  define ucarp::config( $node_id, $password="", $interface_primary, $interface_vip, $vip_addr, $vip_addr_netmask, $vip_addr_gw, $other_options = "", $ensure=present ) {

    # Enabled or disabled ?
    if($ensure == present) {
        $present = file
    } else {
        $present = absent
    }

    if ($password == "") {
      $password = md5("${vip_address}${node_id}")
    }

    $primary_interface_ip = inline_template("<%= scope.lookupvar('ipaddress_${interface_primary}') %>")
    $vip_addr_mac = inline_template("<%= scope.lookupvar('macaddress_${interface_vip}') %>")

    #Creating vip up/down scripts
    #Class becayse it has to be done only once
    include up_down_scripts

    #Serving if up/down scripts
    file { "/etc/sysconfig/network-scripts/ifcfg-${interface_vip}:${node_id}":
      ensure => $present,
      content => template("ucarp/ifcfg.erb"),
      require => Package['ucarp'],
      notify => Service['carp'],
      }

    #Serving the actual config file
    file { "/etc/sysconfig/carp/vip-00${node_id}.conf":
      ensure => $present,
      content => template("ucarp/vip_conf.erb"),
      require => Package['ucarp'],
      notify => Service['carp'],
      }
}
