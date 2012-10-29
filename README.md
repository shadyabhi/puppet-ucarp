puppet-ucarp
============

Module to manage ucarp instances.

Usage
=====

The code below will start 2 ucarp instances managing two public ips 1.1.1.10 and 1.1.1.11

    include ucarp

    ucarp::config { "ucarp-test1":
      node_id => '1',
      password => "pwtest",
      interface_primary => 'eth0',
      interface_vip => 'eth1',
      vip_addr => '1.1.1.10',
      vip_addr_netmask => '255.255.254.0',
      vip_addr_gw => '1.1.1.1',
      other_options => '-k 1 -P -b 1',
      ensure => present,
    }

    ucarp::config { "ucarp-test2":
      node_id => '2',
      password => "pwtest",
      interface_primary => 'eth0',
      interface_vip => 'eth1',
      vip_addr => '1.1.1.11',
      vip_addr_netmask => '255.255.254.0',
      vip_addr_gw => '1.1.1.1',
      other_options => '-b 3',
      ensure => present,
      }
