class nginx {
  package {'nginx':
    ensure => present,
  }

  File {
  owner => 'root',
  group => 'root',
  mode => '0664',
  }

  file {'/var/www':
    ensure => directory,
    mode => '0755',
    }
  
  file {'index.html':
    ensure => file,
    path => '/var/www/index.html',
    source => 'puppet:///modules/nginx/index.html',
    }
    
  file {'nginx.conf':
    ensure => file,
    path => '/etc/nginx/nginx.conf',
    source => 'puppet:///modules/nginx/nginx.conf',
    }
    
  file {'default.conf':
    ensure => file,
    path => '/etc/nginx/conf.d/default.conf',
    source => 'puppet:///modules/nginx/default.conf',
  }
  
  service { 'nginx':
    ensure => running,
    enable => true,
    subscribe => [File['nginx.conf'], File['default.conf']]
    }
    
}
