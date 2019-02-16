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
}

user { 'meguca':
  ensure => 'present',
  home   => '/home/meguca',
  shell  => '/bin/bash'
}

daemontools::service {'meguca':
  ensure  => running,
  command => 'sudo -u meguca /home/meguca/meguca/meguca -r',
  logpath => '/var/log/meguca',
}
EOL


puppet apply puppet_apply_me.pp

cd /home/meguca
sudo -u meguca git clone https://github.com/bakape/meguca.git /server/meguca
cd meguca
sudo -u meguca make
