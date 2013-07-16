define cpanm::env (
  $ensure      = present,
  $user        = 'root',
  $locallib    = true,
  $homedir     = "/home/$user",
) {

  if $user == 'root' and $locallib == true {
    file {"/root/test":
      ensure => present,
      content => "if\n",
    }
  }
  
  elsif $user == 'root' {
    file {"/root/test":
      ensure => present,
      content => "else\n",
    }
  }
  
  else {
    file {"$homedir/bin":
      ensure  => directory,
      owner   => $user,
      group   => $user,
    } ->
    exec {"$user-cpanm-bin":
      command => "curl -L http://cpanmin.us > $homedir/bin/cpanm",
      unless  => "ls $homedir/bin/cpanm",
      user    => $user,
      path    => ['/bin','/usr/bin/']
    } ->
    file {"$homedir/bin/cpanm":
      ensure => present,
      mode   => 0744,
    } ->
    exec {"$user-cpanm-local-lib":
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
