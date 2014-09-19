class yum_repo {

  package {
    'yum-plugin-priorities':
      ensure => present;
  }

  file {
    '/etc/yum.repos.d':
      ensure => directory,
      recurse => true,
      purge => true;
  }

}
