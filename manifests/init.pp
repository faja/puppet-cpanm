class cpanm {
  
  if ! defined(Package['perl'])       { package { 'perl':       ensure => installed } }
  if ! defined(Package['perl-devel']) { package { 'perl-devel': ensure => installed } }
  if ! defined(Package['perl-CPAN'])  { package { 'perl-CPAN':  ensure => installed } }
  if ! defined(Package['curl'])       { package { 'curl':       ensure => installed } }
  if ! defined(Package['wget'])       { package { 'wget':       ensure => installed } }

}
