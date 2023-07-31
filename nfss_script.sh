#!/bin/bash

#firewall
systemctl enable firewalld --now
firewall-cmd --add-service="nfs3" --add-service="rpc-bind" --add-service="mountd" --permanent
firewall-cmd --reload

#nfs
systemctl enable rpcbind nfs-server
mkdir -p /srv/share/upload
chown -R nfsnobody:nfsnobody /srv/share
chmod 0777 /srv/share/upload

echo "/srv/share 192.168.56.11(wdelay,hide,no_subtree_check,sec=sys,rw,secure,root_squash)" > /etc/exports
systemctl restart nfs-server
