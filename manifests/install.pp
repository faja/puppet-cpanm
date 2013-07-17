define cpanm::install (
  $ensure = present,
  $user   = 'root',
) {
  
  $module = $name

  if $user == 'root' {
    exec {"$module":
      command => "/root/bin/cpanm $module",
    }
  }
  else {
    exec {"$module":
      command => "/bin/su - $user -c \"cpanm $module\"",
    }
  }
}
