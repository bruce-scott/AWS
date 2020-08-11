
# 1.Create 3 Sec.Group:

   Wordpress/BastionHost: In bound : "SSH 22, HTTP 80, Mysql/Aurora 3306  > anywhere(0:/00000)"
   Mysql_dB_Sec.Grb: In bound :"Mysql 3306, HTTP, SSH 22  > anywhere (0:/00000)"
   Natinstance Sec.Grp: In bound : "HTTP, SSH 22  > anywhere (0:/00000)"

# 2.Create EC2 that is installed LAMP with user data seen below for "Wordpress app in Subnet PublicB"

   # VPC: VPC-osvaldo
   # Subnet: osvaldo-PublicB
   # Sec Group: Wordpress_Seg.Grb
   
   #!/bin/bash

	yum update -y
	amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
	yum install -y httpd
	systemctl start httpd
	systemctl enable httpd
	wget https://wordpress.org/latest.tar.gz
    tar -xzf latest.tar.gz
	sudo cp -r wordpress/* /var/www/html/
	cd /var/www/html/
	cp wp-config-sample.php wp-config.php
	chown -R apache /var/www
	chgrp -R apache /var/www
	chmod 775 /var/www
	find /var/www -type d -exec sudo chmod 2775 {} \;
	find /var/www -type f -exec sudo chmod 0664 {} \;
	systemctl restart httpd

# 3.Create RDS mysql instance in PrivateB

   # VPC: VPC-osvaldo
   # Subnet: PrivateB
   # Sec Group: Mysql_Database

	#!/bin/bash

	yum update -y
	yum install -y mariadb-server
	systemctl start mariadb
    systemctl enable mariadb


# 4. Control the instance status.

# 5. We need to establish Database Configuration in DB instance which is in PrivateB Subnet 
So we need to use Wordpress instance as a Bastionhost to access DB instance. BAstion host is in PublicB. So first we need to 
ensure DB instance Sec Gruup inbound rule that it only permit BastionHost Secgroup to access

Rule: Mysql 3306, SSH 22,HTTP  > "anywhere (0:/00000)"

							 V
 							 V
 							 V
 							 
Rule: Mysql_database: Mysql 3306, SSH 22, HTTP >>>>>> "Wordpress/Bastion_Host Sec.Gruoup"

# 6. To conncet to private instance first we ensure the .pem file be exist in Wordpress instance.

- connect to Wordpress instance
- create a .pem file with the same name of your .pem file 
   -sudo nano key.pem
- open the .pem file in local with text editor
- copy the text file
- paste it in to the nano file
- Ctrl X + Y
- chmod 400 .pem 
-ssh ec2-user@"privateIP of private instance that you want to conncet"

"OR" 

# 7 Type  following code to start
eval "$(ssh-agent)"

# 8 Add your private key to the ssh agent
ssh-add p.pem

# 9 Connect to the "Wordpress instance -Bastion Host "instance in "publicA" subnet
ssh -A ec2-user@ec2-3-88-199-43.compute-1.amazonaws.com

# 10 connect to the Database instance in the privateA subnet 
ssh ec2-user@10.7.2.20 (Private IP of Database Instance)


# 11 Instal mariadb  but it snot possible because one way ticket.

	sudo yum update -y
	sudo yum install -y mariadb-server
	
# 12 Create Natgateway in  "SuBnet PublicC"

  # VPC: VPC-osvaldo
  # Subnet: osvaldo_lab-PublicA
  # Sec Group: VPc_osvaldo_Natinstance

# 13 Try to Instal mariadb  but it snot possible because route table dosen't know İnternet

	sudo yum update -y
	
	
# 14 Change "Private Route" table:


Destination            target

10.0.0....>>>>>>       Local
"00000/0>>>>>>>>>"     "Natinstance"


#15 On Natinstance click Networking from the Actions menu and then go to Change Source/ Destination Check

click "Disable" option from the window that opens.

# 16 Instal mariadb to "DB instance" .

	sudo yum update -y
	sudo yum install -y mariadb-server
	sudo systemctl start mariadb
    sudo systemctl enable mariadb
    
# 17  Setup secure installation of MariaDB
sudo mysql_secure_installation

# 18. Connect mysql terminal without password anymore
mysql -u root -p

# 19.Show that test db is gone.
SHOW databases;

# 20. Select msql and List the users defined in the server
USE mysql;


# 21. Create new database named "clarusway";
CREATE DATABASE clarusway;


# 22. Create a user named "admin"; 
CREATE USER admin IDENTIFIED BY 'Pl12';

# 23. Grant permissions to the user "admin" for database "clarusway"
GRANT ALL ON clarusway.* TO admin IDENTIFIED BY 'Pl12' WITH GRANT OPTION;  

# 24. Update privileges
FLUSH PRIVILEGES;

# 25. List the users defined.
SELECT Host, User, Password FROM user;

# 26. Close the mysql terminal
EXIT;


# 28. Return to the Connect "Wordpres Instance" to confgire Word press database settings  "cd /var/www/html/" to secure config file before change
cd /var/www/html/
sudo cp wp-config-sample.php wp-config.php

# 29. Change the config file for database assosiation
sudo nano wp-config.php

     #define( 'DB_NAME', 'clarusway' );

     #define( 'DB_USER', 'admin' );

     #define( 'DB_PASSWORD', 'Pl12' );

     # local ("Private DNS")
Ctrl X and  Y
sudo systemctl restart httpd

# 30. Check the browser. You'll see the home page of Wordpress
      # enter pasword,user name etc... 

-------------------------------------------------------------
# 31 Create peering between osvaldo VPC and Default VPC
  - Accept the Request Peering Connection Action Menu
  - Set the routing table of "Requster VPC(Osvaldo)"
     -172.31.0.0/16   >>>>> peering
  - Set the routing table of "Accepter VPC(default)" 
     - 10.0.0.0/16 >>>>> peering

# 32 Create "Messenger Instance" and conncet with SSH and msql/aurora: 
  
  Sec. group: ssh-mysql aurora:0/00000, 
  
  #userdata:
    
    #!/bin/bash

    yum update -y
    yum install -y https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
    yum install -y mysql-community-client

# 33. Connect from "Messenger instance in default VPC" to "DB instance in osvaldo VPC" via SHH

# 34. Copy .pem and chmod 400

# 35. Try shh
# 36 . Change sec group of DB instance .

add rule: 
SHH>>>>>>>>>> "IP of Messsanger Instance."
Msql/aurora>>>>"IP of Messsanger Instance."

# 37. Try shh again
# 38 Try connect database
mysql -u admin -h "your-DB instace Private DNS" -p clarusway

---------------------------------------------