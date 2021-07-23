#! /bin/bash

mkdir -p /var/lib/faasd/secrets/
echo ${faasd_password} > /var/lib/faasd/secrets/basic-auth-password
echo admin > /var/lib/faasd/secrets/basic-auth-user

export FAASD_DOMAIN=${faasd_domain}
export LETSENCRYPT_EMAIL=${letsencrypt_email}

iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
iptables -I INPUT -j ACCEPT
iptables -A OUTPUT -j ACCEPT
iptables -I INPUT -m state --state NEW -p tcp --dport 80 -j ACCEPT
iptables -I INPUT -m state --state NEW -p tcp --dport 443 -j ACCEPT
netfilter-persistent save
apt update
apt upgrade -y
curl -sfL https://raw.githubusercontent.com/markopolo123/faasd/master/hack/install.sh | sh -s -
reboot