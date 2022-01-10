Install the following packages 
------------------------------
+ apt install bsd-mailx
+ apt install msmtp
+ apt install msmtp-mta

Configuring mail
----------------

create **/etc/msmtprc** file with content like

#Set default values for all accounts.
defaults
auth on
tls on
tls_starttls on
tls_trust_file /etc/ssl/certs/ca-certificates.crt
logfile /var/log/msmtp.log

#Gmail settings
account gmail
host smtp.gmail.com
port 587
from yourname@gmail.com
user yourname
password <your password>

#Set a default account
account default : gmail


Change file owner/rights 
------------------------

chown root:msmtp /etc/msmtprc 
chmod 640 /etc/msmtprc 


