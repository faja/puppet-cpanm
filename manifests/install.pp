define cpanm::install (
  $ensure = present,
  $user   = 'root',
) {
  
  $module = $name

  exec {"$module":
    command => "/bin/su - $user -c \"cpanm $module\"",
  }
}
