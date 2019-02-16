#run as root
#pre requisites: 
#change hostname
#dpkg-reconfigure locale
apt-get update
apt-get dist-upgrade -y
apt-get install ntp -y
apt install ssh curl wget apt-transport-https dirmngr -y
apt install sudo git -y
apt install puppet -y
apt install -y build-essential make gcc pkg-config libavcodec-dev libavutil-dev libavformat-dev libswscale-dev libopencv-dev 
puppet module install puppet-nodejs
puppet module install puppetlabs-postgresql
puppet module install puppet-nginx
puppet module install jbussdieker-daemontools
wget -O- https://dl.google.com/go/go1.11.5.linux-amd64.tar.gz| tar -xpz -C /usr/local #update url if needed
echo 'export PATH=$PATH:/usr/local/go/bin' >> /etc/profile
source /etc/profile


cat > puppet_apply_me.pp <<EOL
class { 'nodejs': 
  npm_package_ensure        => 'present',
}
class { 'postgresql::server':}
include nginx

::postgresql::server::db { 'meguca':
  user     => 'meguca',
  password => postgresql_password('meguca', 'meguca'),
}
~>
::postgresql::server::database_grant { 'test1':
  privilege => 'ALL',
  db        => 'meguca',
  role      => 'meguca',
}

::nginx::resource::server { 'exochan.org':
  listen_port => 80,
  proxy       => 'http://localhost:8000',
  listen_options => 'default_server',
}

user { 'meguca':
  ensure => 'present',
  home   => '/home/meguca',
  managehome => true,
  shell  => '/bin/bash'
}

daemontools::service {'meguca':
  ensure  => running,
  service_script => '#!/bin/bash
	cd /home/meguca/meguca
	exec sudo -u meguca /home/meguca/meguca/meguca -r
	',
  logpath => '/var/log/meguca',
}
EOL


puppet apply puppet_apply_me.pp


svc -dk /etc/service/meguca
cd /home/meguca
git clone https://github.com/bakape/meguca.git
cd meguca
make
chown -R meguca:meguca /home/meguca
cd /home/meguca/meguca
sudo -u meguca npm audit fix

svc -u /etc/service/meguca


apt-get purge curl wget apt-transport-https dirmngr build-essential make gcc -y
apt-get autoremove --purge -y
apt-get autoclean -y
reboot
