define cpanm::install (
  $ensure = present,
  $user   = 'root',
  $export = false,
) {
  
  $module = $name

  if $user == 'root' {
    exec {"$module":
      command => "/root/bin/cpanm $module",
    }
  }
  else {
    if $export {
      exec {"$module":
        command => "/bin/su - $user -c \"$export cpanm $module\"",
      }
    }
    else {
      exec {"$module":
        command => "/bin/su - $user -c \"cpanm $module\"",
      }
    }
  }
}
