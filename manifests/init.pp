class cpanm {
 
  $compatible = ['Debian','Ubuntu','CentOS','RedHat']
  if ! ($::operatingsystem in $compatible) {
    fail("Module is not compatible with ${::operatingsystem}")
  }

  if ! defined(Package['perl'])       { package { 'perl':       ensure => installed } }
  if ! defined(Package['curl'])       { package { 'curl':       ensure => installed } }
  if ! defined(Package['wget'])       { package { 'wget':       ensure => installed } }


  case $operatingsystem {
    'RedHat', 'CentOS': { 
      if ! defined(Package['perl-devel'])        { package { 'perl-devel': ensure => installed } }
      if ! defined(Package['perl-CPAN'])         { package { 'perl-CPAN':  ensure => installed } }
      if ! defined(Package['perl-Test-Simple'])  { package { 'perl-Test-Simple':  ensure => installed } }
    }
    'Debian', 'Ubuntu': {
      if ! defined(Package['perl-base'])     { package { 'perl-base':     ensure => installed } }
      if ! defined(Package['perl-modules'])  { package { 'perl-modules':  ensure => installed } }
    }
  }

}
