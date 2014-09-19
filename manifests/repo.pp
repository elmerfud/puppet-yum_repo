define yum_repo::repo (
  $enabled,
  $baseurl,
  $descr,
  $includepkgs = 'absent',
  $gpgcheck = '1',
  $gpgkey = 'absent',
  $priority = '99') {

  $filename = $title

  yumrepo {
    $filename:
      descr => $descr,
      enabled => $enabled,
      baseurl => $baseurl,
      gpgcheck => $gpgcheck,
      gpgkey => $gpgkey,
      priority => $priority
  }

  file {
    "/etc/yum.repos.d/${filename}.repo":
      ensure => present,
      require => Yumrepo[$title];
  }

}
