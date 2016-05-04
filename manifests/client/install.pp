# PRIVATE CLASS: do not call directly
class mongodb::client::install {
  $package_ensure = $mongodb::client::ensure
  $package_name   = $mongodb::client::package_name
  $tools_package_name = $mongodb::client::tools_package_name
  $tools_package_ensure = $mongodb::client::tools_ensure

  case $package_ensure {
    true:     {
      $my_package_ensure = 'present'
    }
    false:    {
      $my_package_ensure = 'purged'
    }
    'absent': {
      $my_package_ensure = 'purged'
    }
    default:  {
      $my_package_ensure = $package_ensure
    }
  }

  case $tools_package_ensure {
    true:     {
      $my_tools_package_ensure = 'present'
    }
    false:    {
      $my_tools_package_ensure = 'purged'
    }
    'absent': {
      $my_tools_package_ensure = 'purged'
    }
    default:  {
      $my_tools_package_ensure = $tools_package_ensure
    }
  }

  if $package_name {
    package { 'mongodb_client':
      ensure => $my_package_ensure,
      name   => $package_name,
      tag    => 'mongodb',
    }
  }
 
  if $::os['family'] != 'RedHat' or ($::os['family'] == 'RedHat' and $::os['release']['major'] != '7') {
    if $tools_package_name {
      package { 'mongodb_tools':
        ensure => $my_tools_package_ensure,
        name => $tools_package_name,
        tag => 'mongodb',
      }
    }
  }
}
