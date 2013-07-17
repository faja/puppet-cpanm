define cpanm::env (
  $ensure      = present,
  $user        = 'root',
  $homedir     = "/home/$user",
) {

  if $user == 'root' {
    file {"/root/bin":
      ensure  => directory,
    } ->
    exec {"/root/bin/cpanm":
      command => "curl -L http://cpanmin.us > /root/bin/cpanm",
      unless  => "ls /root/bin/cpanm",
      path    => ['/bin','/usr/bin/']
    } ->
    file {"/root/bin/cpanm":
      ensure => present,
      mode   => 0744,
    }
  }
  else {
    file {"$homedir/bin":
      ensure  => directory,
      owner   => $user,
      group   => $user,
    } ->
    exec {"$homedir/bin/cpanm":
      command => "curl -L http://cpanmin.us > $homedir/bin/cpanm",
      unless  => "ls $homedir/bin/cpanm",
      user    => $user,
      path    => ['/bin','/usr/bin/']
    } ->
    file {"$homedir/bin/cpanm":
      ensure => present,
      mode   => 0744,
      owner   => $user,
      group   => $user,
    } ->
    exec {"$user_cpanm_local-lib":
      command => "su - $user -c \"cpanm --local-lib=$homedir/perl5 local::lib\"",
      unless  => "ls $homedir/perl5/lib/perl5/local/lib.pm",
      path    => ["$homedir/bin",'/bin','/usr/bin/']
    } ->
    file_line {"cpanm_in_bashrc":
      path => "$homedir/.bashrc",
      line => "eval $(perl -I\$HOME/perl5/lib/perl5 -Mlocal::lib)",
    }
  }
}
