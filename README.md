puppet-cpanm
============

####Usage
* to install needed packages include cpanm class

 ```
 class{'cpanm'}
 ```
* to install perl modules globally as root
 ```
 class{'cpanm':} ->

 cpanm::env {'root_cpanm_env':}
 cpanm::install {'App::cpanminus':}
 cpanm::install {'Time::HiRes':}
 ```
* to prepare local perl and cpanm environment for user "foo"   

 ```
 cpanm::env {'foo_cpanm_env':
      user => 'foo',
 }
 ```
 it means 
   * cpnam binary will be placed in /home/foo/bin/
   * local perl modules will be installed into /home/foo/perl5/lib/perl5
   
* to install perl module into local perl dir
 ```
 # to install latest version of module
 cpanm::install {'App::cpanminus': user => 'sempro',}
 # to install specific version of module
 cpanm::install {'Test::Most@0.30': user => 'sempro',}
 ```
 
* example class
```
class foo::perl::env {
      cpanm::env {'foo': user => 'foo',}
}
class foo::perl::modules {
      cpanm::install {'App::cpanminus': user => 'foo',}
      cpanm::install {'Time::HiRes': user => 'foo',} ->
      cpanm::install {'Test::Most': user => 'foo',}
}
class{'cpanm'} ->
class{'foo::perl::env':} ->
class{'foo::perl::modules':}
```
