#!/bin/sh

echo "FTP_USER:     $FTP_USER"
echo "EXTERNAL_IP:  $EXTERNAL_IP"
echo "FTP_PASSWORD: $FTP_PASSWORD"

sed -i s/EXTERNAL_IP/$EXTERNAL_IP/g /tmp/vsftpd.conf;
mv /tmp/vsftpd.conf /etc/vsftpd/vsftpd.conf
echo "check -1"

adduser -D $FTP_USER && echo "$FTP_USER:$FTP_PASSWORD" | chpasswd
chown -R $FTP_USER /home/$FTP_USER 

vsftpd /etc/vsftpd/vsftpd.conf