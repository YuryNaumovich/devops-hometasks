$script = <<-'SCRIPT'
sudo apt-get install apache2 php -y
sudo echo "Listen 8080" >> /etc/apache2/ports.conf
sudo echo "Listen 8081" >> /etc/apache2/ports.conf
sudo mkdir /var/www/html/itacademy-devops-files
sudo git clone https://github.com/Fenikks/itacademy-devops-files /var/www/html/itacademy-devops-files
sudo cat > /etc/apache2/sites-available/it_academy.conf << EOF
<VirtualHost *:8080>
DocumentRoot /var/www/html/itacademy-devops-files/01-demosite-static
</VirtualHost>
<VirtualHost *:8081>
DocumentRoot /var/www/html/itacademy-devops-files/01-demosite-php
</VirtualHost>
EOF
sudo a2ensite it_academy
sudo systemctl reload apache2
SCRIPT

Vagrant.configure("2") do |config|
 config.vm.box = "generic/debian10"
 config.vm.provision "shell", inline: $script
 config.vm.network "forwarded_port", guest: 8080, host: 8080
 config.vm.network "forwarded_port", guest: 8081, host: 8081
end
