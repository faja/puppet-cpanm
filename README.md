puppet-cpanm
============

####Usage
* to prepare "cpanm" environment for user "foo"   

 ```
 cpanm::env {'foo_cpanm_env':
      user => 'foo',
 }
 ```
 it means 
   * cpnam binary will be placed in /home/foo/bin/
   * local perl modules will be installed into /home/foo/perl5/lib/perl5
 
 
* example class
