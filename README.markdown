# Yum Repo Manager

This module manages yum repositories.

Easily manage YUM repos

Module ensures that your machine only has the repos you want.  Purges ones not explicitly defined.

##Example using Hiera 

**Hiera yaml** 
```
---
yum_repos:
  centos:
    descr: 'CentOS-$releasever - Base'
    enabled: '1'
    baseurl: 'http://%{mirror_server}/mirror/centos/$releasever/os/$basearch'
    priority: '3'
    gpgcheck: 0
  centos-updates:
    descr: 'CentOS-$releasever - Updates'
    enabled: '1'
    baseurl: 'http://%{mirror_server}/mirror/centos/$releasever/updates/$basearch'
    priority: '2'
    gpgcheck: 0
  centos-extras:
    descr: 'CentOS-$releasever - Extras'
    enabled: '1'
    baseurl: 'http://%{mirror_server}/mirror/centos/$releasever/extras/$basearch'
    priority: '2'
    gpgcheck: 0
```

**Puppet node conf**
```puppet
node 'default' {
  $mirror_server = 'suse.lightedge.com'
  $yum_repos = hiera_hash('yum_repos', [])
  create_resources('yum_repo::repo',$yum_repos)
}
```


##Example of just Puppet node conf

```puppet
node 'myserver' {
  repo::yumrepo {
    'dell-omsa-indep':
      descr => 'Dell OMSA repository - Hardware independent',
      enabled => 1,
      mirrorlist => 'http://linux.dell.com/repo/hardware/latest/mirrors.cgi?osname=el$releasever&basearch=$basearch&native=1&dellsysidpluginver=$dellsysidpluginver',
      gpgcheck => 1,
      gpgkey => "http://linux.dell.com/repo/hardware/latest/RPM-GPG-KEY-dell   http://linux.dell.com/repo/hardware/latest/RPM-GPG-KEY-libsmbios",
      priority => 10,
      proxy => 'http://mylocal_proxy.localdomain:3128',
      require => File['/usr/lib/yum-plugins/dellsysid.py','/etc/yum/pluginconf.d/dellsysid.conf'];
    'dell-omsa-specific':
      descr => 'Dell OMSA repository - Hardware specific',
      enabled => 1,
      mirrorlist => 'http://linux.dell.com/repo/hardware/latest/mirrors.cgi?osname=el$releasever&basearch=$basearch&native=1&sys_ven_id=$sys_ven_id&sys_dev_id=$sys_dev_id&dellsysidpluginver=$dellsysidpluginver',
      gpgcheck => 1,
      gpgkey => "http://linux.dell.com/repo/hardware/latest/RPM-GPG-KEY-dell   http://linux.dell.com/repo/hardware/latest/RPM-GPG-KEY-libsmbios",
      priority => 10,
      proxy => 'http://mylocal_proxy.localdomain:3128',
      require => File['/usr/lib/yum-plugins/dellsysid.py','/etc/yum/pluginconf.d/dellsysid.conf'];
  }
}
```
