#!/usr/bin/perl
use strict;
use warnings;
use Term::ANSIColor;

# Language selection
my $lang = 'en';
print color("yellow");
print "Select language / Selecione o idioma:\n";
print "1. English\n";
print "2. Português\n";
print "Choice / Escolha: ";
print color("reset");
chomp(my $choice = <STDIN>);

if ($choice eq '2') {
    $lang = 'pt';
}

# Language strings
my %strings = (
    'en' => {
        'banner_title' => "ZefferAPI Installation",
        'select_lang' => "Select language / Selecione o idioma:",
        'english' => "English",
        'portuguese' => "Português",
        'choice' => "Choice / Escolha:",
        'open_ports' => "Open Ports 80/22? [Y/n] ",
        'opening_ports' => "Opening ports 80 and 22...",
        'ports_opened_firewalld' => "Ports opened with firewalld.",
        'ports_opened_iptables' => "Ports opened with iptables.",
        'ports_success' => "Ports opened successfully.",
        'install_packages' => "Install required packages? [Y/n] ",
        'installing_packages' => "Installing required packages...",
        'packages_success' => "Required packages installed successfully.",
        'install_ssh2' => "Install SSH2? [Y/n] ",
        'installing_ssh2' => "Installing SSH2...",
        'verifying_ssh2' => "Verifying SSH2 installation...",
        'ssh2_success' => "SSH2 installation completed.",
        'install_extras' => "Install additional utilities? [Y/n] ",
        'installing_extras' => "Installing additional utilities...",
        'extras_success' => "Additional utilities installed successfully.",
        'configure_firewall' => "Configure firewall for ports 80/22/443? [Y/n] ",
        'configuring_firewall' => "Configuring firewall...",
        'firewall_success' => "Firewall configured successfully.",
        'setup_ssl' => "Setup SSL certificate (self-signed)? [Y/n] ",
        'setting_ssl' => "Setting up SSL certificate...",
        'generating_dh' => "Generating DH parameters (this may take a moment)...",
        'ssl_success' => "SSL certificate configured successfully.",
        'completed' => "ZefferAPI installation completed successfully!",
        'http_server' => "Apache HTTP Server: http://localhost",
        'https_server' => "Apache HTTPS Server: https://localhost",
        'ssh_server' => "SSH Server: port 22",
        'executing' => "Executing:",
        'command_failed' => "Command failed:",
        'verifying' => "Verifying...",
        'if_see_ssh2' => "If you see 'ssh2' above, the installation was successful."
    },
    'pt' => {
        'banner_title' => "Instalação ZefferAPI",
        'select_lang' => "Selecione o idioma:",
        'english' => "Inglês",
        'portuguese' => "Português",
        'choice' => "Escolha:",
        'open_ports' => "Abrir portas 80/22? [S/n] ",
        'opening_ports' => "Abrindo portas 80 e 22...",
        'ports_opened_firewalld' => "Portas abertas com firewalld.",
        'ports_opened_iptables' => "Portas abertas com iptables.",
        'ports_success' => "Portas abertas com sucesso.",
        'install_packages' => "Instalar pacotes necessários? [S/n] ",
        'installing_packages' => "Instalando pacotes necessários...",
        'packages_success' => "Pacotes necessários instalados com sucesso.",
        'install_ssh2' => "Instalar SSH2? [S/n] ",
        'installing_ssh2' => "Instalando SSH2...",
        'verifying_ssh2' => "Verificando instalação do SSH2...",
        'ssh2_success' => "Instalação do SSH2 concluída.",
        'install_extras' => "Instalar utilitários adicionais? [S/n] ",
        'installing_extras' => "Instalando utilitários adicionais...",
        'extras_success' => "Utilitários adicionais instalados com sucesso.",
        'configure_firewall' => "Configurar firewall para portas 80/22/443? [S/n] ",
        'configuring_firewall' => "Configurando firewall...",
        'firewall_success' => "Firewall configurado com sucesso.",
        'setup_ssl' => "Configurar certificado SSL (autoassinado)? [S/n] ",
        'setting_ssl' => "Configurando certificado SSL...",
        'generating_dh' => "Gerando parâmetros DH (isso pode levar um momento)...",
        'ssl_success' => "Certificado SSL configurado com sucesso.",
        'completed' => "Instalação do ZefferAPI concluída com sucesso!",
        'http_server' => "Servidor Apache HTTP: http://localhost",
        'https_server' => "Servidor Apache HTTPS: https://localhost",
        'ssh_server' => "Servidor SSH: porta 22",
        'executing' => "Executando:",
        'command_failed' => "Comando falhou:",
        'verifying' => "Verificando...",
        'if_see_ssh2' => "Se você ver 'ssh2' acima, a instalação foi bem-sucedida."
    }
);

# Get string by language
sub get_string {
    my ($key) = @_;
    return $strings{$lang}{$key} || $strings{'en'}{$key};
}

# Display ZefferAPI banner with color
sub display_banner {
    print color("cyan");
    print <<"EOTEXT";

▒███████▒▓█████   █████▒ █████▒▓█████  ██▀███  
▒ ▒ ▒ ▄▀░▓█   ▀ ▓██   ▒▓██   ▒ ▓█   ▀ ▓██ ▒ ██▒
░ ▒ ▄▀▒░ ▒███   ▒████ ░▒████ ░ ▒███   ▓██ ░▄█ ▒
  ▄▀▒   ░▒▓█  ▄ ░▓█▒  ░░▓█▒  ░ ▒▓█  ▄ ▒██▀▀█▄  
▒███████▒░▒████▒░▒█░   ░▒█░    ░▒████▒░██▓ ▒██▒
░▒▒ ▓░▒░▒░░ ▒░ ░ ▒ ░    ▒ ░    ░░ ▒░ ░░ ▒▓ ░▒▓░
░░▒ ▒ ░ ▒ ░ ░  ░ ░      ░       ░ ░  ░  ░▒ ░ ▒░
░ ░ ░ ░ ░   ░    ░ ░    ░ ░       ░     ░░   ░ 
  ░ ░       ░  ░                  ░  ░   ░     
░                                              

EOTEXT
    print color("reset");
}

# Function to execute system commands with error checking
sub run_command {
    my ($cmd) = @_;
    print color("bold blue");
    print "[" . get_string('executing') . "] $cmd\n";
    print color("reset");
    my $result = system($cmd);
    if ($result != 0) {
        print color("bold red");
        warn "[" . get_string('command_failed') . "] $cmd ($result)\n";
        print color("reset");
    }
    return $result;
}

# Check if firewalld is available
sub has_firewalld {
    return system("which firewall-cmd > /dev/null 2>&1") == 0;
}

# Check if iptables is available
sub has_iptables {
    return system("which iptables > /dev/null 2>&1") == 0;
}

# Main program
display_banner();

# Open ports 80 and 22
print color("yellow");
print "[" . get_string('open_ports') . "] ";
print color("reset");
chomp(my $response = <STDIN>);
if ($response eq '' || lc($response) eq 'y' || lc($response) eq 's') {
    print color("green");
    print "[" . get_string('opening_ports') . "]\n";
    print color("reset");
    
    # Try firewalld first (modern approach)
    if (has_firewalld() && system("systemctl is-active --quiet firewalld") == 0) {
        run_command("sudo firewall-cmd --permanent --add-service=http");
        run_command("sudo firewall-cmd --permanent --add-service=ssh");
        run_command("sudo firewall-cmd --reload");
        print color("green");
        print "[" . get_string('ports_opened_firewalld') . "]\n";
        print color("reset");
    } 
    # Fallback to iptables
    elsif (has_iptables()) {
        run_command("sudo iptables -I INPUT -p tcp --dport 80 -j ACCEPT");
        run_command("sudo iptables -I INPUT -p tcp --dport 22 -j ACCEPT");
        
        # Try to save iptables rules
        if (system("which iptables-save > /dev/null 2>&1") == 0) {
            system("sudo mkdir -p /etc/iptables 2>/dev/null");
            system("sudo iptables-save > /etc/iptables/rules.v4 2>/dev/null || sudo iptables-save > /etc/sysconfig/iptables 2>/dev/null || echo 'Could not save iptables rules' >&2");
        }
        print color("green");
        print "[" . get_string('ports_opened_iptables') . "]\n";
        print color("reset");
    } else {
        print color("red");
        print "[!] No firewall system found (firewalld or iptables)\n";
        print color("reset");
    }
    print color("green");
    print "[" . get_string('ports_success') . "]\n\n";
    print color("reset");
}

# Install required packages
print color("yellow");
print "[" . get_string('install_packages') . "] ";
print color("reset");
chomp($response = <STDIN>);
if ($response eq '' || lc($response) eq 'y' || lc($response) eq 's') {
    print color("green");
    print "[" . get_string('installing_packages') . "]\n";
    print color("reset");
    run_command("sudo yum -y update");
    run_command("sudo yum install -y make gcc libssh2 php-devel php-pear libssh2-devel");
    run_command("sudo yum install -y httpd mod_ssl");
    run_command("sudo yum install -y php php-mysql php-gd php-pecl-memcache php-pspell php-snmp php-xmlrpc php-xml");
    run_command("sudo yum install -y screen epel-release yum-utils unzip");
    
    # Install newer PHP version
    if (system("rpm -q remi-release-7 > /dev/null 2>&1") != 0) {
        run_command("sudo yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm");
    }
    run_command("sudo yum-config-manager --enable remi-php74");
    run_command("sudo yum install -y php-mysqlnd");
    
    run_command("sudo systemctl enable httpd");
    run_command("sudo systemctl start httpd");
    print color("green");
    print "[" . get_string('packages_success') . "]\n\n";
    print color("reset");
}

# Install SSH2
print color("yellow");
print "[" . get_string('install_ssh2') . "] ";
print color("reset");
chomp($response = <STDIN>);
if ($response eq '' || lc($response) eq 'y' || lc($response) eq 's') {
    print color("green");
    print "[" . get_string('installing_ssh2') . "]\n";
    print color("reset");
    run_command("sudo yum install -y gcc php-devel libssh2 libssh2-devel");
    
    # Remove old ssh2.ini if exists
    system("sudo rm -f /etc/php.d/ssh2.ini");
    
    # Install via PECL with proper error handling
    my $pecl_result = system("echo 'y' | sudo pecl install ssh2 2>&1");
    if ($pecl_result == 0) {
        run_command("echo 'extension=ssh2.so' | sudo tee /etc/php.d/20-ssh2.ini");
        run_command("sudo setsebool -P httpd_can_network_connect 1");
        run_command("sudo systemctl restart httpd");
        
        # Verify installation
        print color("cyan");
        print "[" . get_string('verifying_ssh2') . "]\n";
        print color("reset");
        system("php -m | grep ssh2");
        print color("green");
        print "[" . get_string('ssh2_success') . "]\n\n";
        print color("reset");
    } else {
        print color("red");
        print "[!] SSH2 installation failed\n";
        print color("reset");
    }
}

# Install extras
print color("yellow");
print "[" . get_string('install_extras') . "] ";
print color("reset");
chomp($response = <STDIN>);
if ($response eq '' || lc($response) eq 'y' || lc($response) eq 's') {
    print color("green");
    print "[" . get_string('installing_extras') . "]\n";
    print color("reset");
    run_command("sudo yum install -y nano vnstat dstat hping3 htop iotop iftop net-tools telnet python3 python3-pip");
    print color("green");
    print "[" . get_string('extras_success') . "]\n\n";
    print color("reset");
}

# Configure firewall
print color("yellow");
print "[" . get_string('configure_firewall') . "] ";
print color("reset");
chomp($response = <STDIN>);
if ($response eq '' || lc($response) eq 'y' || lc($response) eq 's') {
    print color("green");
    print "[" . get_string('configuring_firewall') . "]\n";
    print color("reset");
    
    # Check if firewalld is available
    if (has_firewalld()) {
        run_command("sudo systemctl start firewalld 2>/dev/null || echo 'firewalld not available, trying alternative'");
        run_command("sudo systemctl enable firewalld 2>/dev/null || echo 'firewalld not available'");
        run_command("sudo firewall-cmd --permanent --add-service=http 2>/dev/null || echo 'firewall-cmd failed'");
        run_command("sudo firewall-cmd --permanent --add-service=https 2>/dev/null || echo 'firewall-cmd failed'");
        run_command("sudo firewall-cmd --permanent --add-service=ssh 2>/dev/null || echo 'firewall-cmd failed'");
        run_command("sudo firewall-cmd --reload 2>/dev/null || echo 'firewall-cmd reload failed'");
        run_command("sudo firewall-cmd --list-all 2>/dev/null || echo 'Could not list firewall rules'");
        print color("green");
        print "[" . get_string('firewall_success') . "]\n\n";
        print color("reset");
    } else {
        print color("yellow");
        print "[!] firewalld not found, skipping firewall configuration\n\n";
        print color("reset");
    }
}

# Setup SSL Certificate
print color("yellow");
print "[" . get_string('setup_ssl') . "] ";
print color("reset");
chomp($response = <STDIN>);
if ($response eq '' || lc($response) eq 'y' || lc($response) eq 's') {
    print color("green");
    print "[" . get_string('setting_ssl') . "]\n";
    print color("reset");
    
    # Create directories
    run_command("sudo mkdir -p /etc/ssl/private 2>/dev/null");
    run_command("sudo chmod 700 /etc/ssl/private 2>/dev/null");
    
    # Generate private key and certificate
    run_command("sudo openssl genrsa -out /etc/ssl/private/apache-selfsigned.key 2048 2>/dev/null");
    run_command("sudo openssl req -new -x509 -key /etc/ssl/private/apache-selfsigned.key -out /etc/ssl/certs/apache-selfsigned.crt -days 365 -subj \"/C=US/ST=State/L=City/O=ZefferAPI/CN=localhost\" 2>/dev/null");
    
    # Generate DH parameters
    print color("cyan");
    print "[" . get_string('generating_dh') . "]\n";
    print color("reset");
    run_command("sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048 2>/dev/null || echo 'DH parameters generation failed'");
    
    # Create SSL config
    my $ssl_config = <<'EOF';
Listen 443 https

<VirtualHost _default_:443>
    SSLEngine on
    SSLCertificateFile /etc/ssl/certs/apache-selfsigned.crt
    SSLCertificateKeyFile /etc/ssl/private/apache-selfsigned.key
    
    BrowserMatch "MSIE [2-5]" \
             nokeepalive ssl-unclean-shutdown \
             downgrade-1.0 force-response-1.0
</VirtualHost>
EOF

    open(my $fh, '>', '/etc/httpd/conf.d/ssl.conf') or die "Could not open file: $!";
    print $fh $ssl_config;
    close $fh;
    
    # Restart Apache
    run_command("sudo systemctl restart httpd");
    print color("green");
    print "[" . get_string('ssl_success') . "]\n\n";
    print color("reset");
}

# Final message
display_banner();
print color("bold green");
print "[" . get_string('completed') . "]\n";
print get_string('http_server') . "\n";
print get_string('https_server') . "\n";
print get_string('ssh_server') . "\n";
print color("reset");
