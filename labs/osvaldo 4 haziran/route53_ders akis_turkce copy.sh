

---------------------------------------------------------------------------------------------
Setup :
----------------------------------------------------------------------------------------------
# 1.Create 1 Sec.Group:

   Route 53 Sec: In bound : "SSH 22, HTTP 80  > anywhere(0:/00000)"

# We ll totally create "6" instance.
   
# 2.Create EC2 that is installed httpd user data in default VPC "N.virginia_1"

   Region: "N.Virginia"
   VPC: Default VPC
   Subnet: PublicA
   Sec Group: "Route 53 Sec"

   user data: 

#!/bin/bash

yum update -y
yum install -y httpd
yum install -y wget
chkconfig httpd on
cd /var/www/html
wget https://raw.githubusercontent.com/awsdevopsteam/route-53/master/N.virginia_1/index.html
wget https://raw.githubusercontent.com/awsdevopsteam/route-53/master/N.virginia_1/N.virginia_1.jpg
service httpd start

# 3.Create EC2 that is installed httpd user data in default VPC "N.virginia_2"

   Region: "N.Virginia"
   VPC: Default VPC
   Subnet: PublicA
   Sec Group: "Route 53 Sec"

   user data:

#!/bin/bash

yum update -y
yum install -y httpd
yum install -y wget
chkconfig httpd on
cd /var/www/html
wget https://raw.githubusercontent.com/awsdevopsteam/route-53/master/N.virginia_2/index.html
wget https://raw.githubusercontent.com/awsdevopsteam/route-53/master/N.virginia_2/N.Virginiatwo.jpg
service httpd start


# 4."Optinal" Create EC2 that is installed httpd user data in tokyo region default VPC "Geo-Japon"

   Region: "Tokyo"
   VPC: Default VPC
   Subnet: PublicA
   Sec Group: "SSH 22, HTTP 80  > anywhere(0:/00000)"

   "user data:"

#!/bin/bash

yum update -y
yum install -y httpd
yum install -y wget
chkconfig httpd on
cd /var/www/html
wget https://raw.githubusercontent.com/awsdevopsteam/route-53/master/geo-japon/index.html
wget https://raw.githubusercontent.com/awsdevopsteam/route-53/master/geo-japon/Tsubasa.jpg
service httpd start

# 5.Optinal Create EC2 that is installed httpd user data in "N.Virginia Rregion" "Geo-Frankfurt"
 
   Region: "N.Virginia"
   VPC: Default VPC
   Subnet: PublicA
   Sec Group: "SSH 22, HTTP 80  > anywhere(0:/00000)"

   "user data:"

#!/bin/bash

yum update -y
yum install -y httpd
yum install -y wget
chkconfig httpd on
cd /var/www/html
wget https://raw.githubusercontent.com/awsdevopsteam/route-53/master/frankfurt/index.html
wget https://raw.githubusercontent.com/awsdevopsteam/route-53/master/frankfurt/frankfurt.jpg
service httpd start

# 6. Create EC2 that is installed httpd user data in "N.Virginia Region" "Local"
 
   Region: "N.virginia"
   VPC: Osvaldo VPC
   Subnet: PublicA
   Sec Group: "SSH 22, HTTP 80  > anywhere(0:/00000)"

   "user data:"

#!/bin/bash

yum update -y
yum install -y httpd
yum install -y wget
chkconfig httpd on
cd /var/www/html
wget https://raw.githubusercontent.com/awsdevopsteam/route-53/master/local/index.html
wget https://raw.githubusercontent.com/awsdevopsteam/route-53/master/local/Local.jpg
service httpd start

# 7.Create "Windows" EC2
   Region: "N.virginia"
   "AMI": Microsoft Windows Server 2019 Base - "ami-05bb2dae0b1de90b3"
   VPC: Default VPC
   Subnet: PublicA
   Sec Group: "RDP >>>>>anywhere"  
   user data:"-"

# 8 . Create Static WebSite Hosting 

  - Create a bucket with "naked domain" name "awsdevopsteam.net"
  - Public Access Enabled
  - Upload Files
  - Permission>>> Bucket Policy >>> Paste bucket Policy
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::benideğiştir/*"
        }
    ]
}
  - Preporties>>> Set Static Web Site >>> Enable  


# 9. Create Static WebSite Hosting 
  - Create a bucket with "sub-domain name" "www.awsdevopsteam.net"
  - Public Access Enabled
  - Upload Files
  - Permission>>> Bucket Policy >>> Paste bucket Policy
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::www.awsdevopsteam.net/*"
        }
    ]
}
  - Preporties>>> Set Static Web Site >>> Enable  


---------------------------------------------------------------------------------------------
A Record:
----------------------------------------------------------------------------------------------

# 9.Create A record with N. Virginia_1

Name:"www"
Type: "A – IPv4 address"
Alias:"No"
TTL:"1m"
Value: "IP of N.Virginia_1"
Routing Policy: "Simple"

# 10.Create another "A record" with N. Virginia_1 

Name:"info"
Type: "A – IPv4 address"
Alias:"No"
TTL:"1m"
Value: "IP of N.Virginia_1"
Routing Policy: "Simple"

then "Delete" it 


# 11.Add another IP of N. Virginia_2  to the existing "A record" 
Name:"www"
Type: "A – IPv4 address"
Alias:"No"
TTL:"1m"
Value: "IP of N.Virginia_1" ,and 
       "IP of N.Virginia_2"
Routing Policy: "Simple"


# Check from terminal
nslookup www.awsdevopsteam.net

---------------------------------------------------------------------------------------------
CNAME Record:
----------------------------------------------------------------------------------------------
# 12. Add CNAME record for domain name 
   
Name:"info"
Type: "CNAME"
Alias:"No"
TTL:"1m"
Value: "www.awsdevopsteam.net"
Routing Policy: "Simple"

# 12. Add CNAME record" for S3 static web hosting ans see that you dont need to enter bucket name as same as
the target domain name "www.awsdevopsteam.net"
   
Name:"www"
Type: "CNAME"
Alias:"No"
TTL:"1m"
Value: "Bucket endpoint"
Routing Policy: "Simple"

---------------------------------------------------------------------------------------------
Alias Record:
----------------------------------------------------------------------------------------------

# 13. Add Alias A record" for S3 static web hosting ans see that you can only select bucket neme as same as
the target domain name "www.awsdevopsteam.net"

Name:"www"
Type: "A"
Alias:"yes"
TTL:"1m"
Value: "Selecet from the menu"
Routing Policy: "Simple"
   
---------------------------------------------------------------------------------------------
Simple Policy
---------------------------------------------------------------------------------------------- 
  
# 14.inspect the existing "A record" with two IP;
Name:"www"
Type: "A – IPv4 address"
Alias:"No"
TTL:"1m"
Value: "IP of N.Virginia_1" ,and 
       "IP of N.Virginia_2"
Routing Policy: "Simple"
   
nslookup "www.awsdevopsteam.net"

---------------------------------------------------------------------------------------------
Failover Policy
---------------------------------------------------------------------------------------------- 
# 15. Create health check for "N. virgnia_1 instance"
# 16. Create A record with  "N. virgnia_1 instance" IP and 
Name:"www"
Type: "A – IPv4 address"
Alias:"No"
TTL:"1m"
Value: "IP of N.Virginia_1"
Routing Policy: "Failover"
Primary/Secondary: "Primary"
Health check: "select the N. virgnia_1 instance Health Checks"

# 17. Create A record "Alias" with  "S3 bucket " 
Name:"www"
Type: "A – IPv4 address"
Alias:"yes"
TTL:"1m"
Value: "S3 bucket endpoint"
Routing Policy: "Failover"
Primary/Secondary: "secondary"
Health check: - 

---------------------------------------------------------------------------------------------
GeoLocation Policy
---------------------------------------------------------------------------------------------- 
   
# 18. Create A record with  "Geo-Japo" instance IP
Name:"www"
Type: "A – IPv4 address"
Alias:"No"
TTL:"1m"
Value: "IP of Geo-Japon Instace"
Routing Policy: "Geolocation"
Continent/city: "City-Tokyo"
Health check: - 

# 19. Create A record with  "Geo-Frankfurt" instance IP
Name:"www"
Type: "A – IPv4 address"
Alias:"No"
TTL:"1m"
Value: "IP of Geo-Frankfurt Instace"
Routing Policy: "Geolocation"
Continent/city: "Continent-Europe"
Health check: - 

# 20. Create A record with  "N.virginia_1" instance IP
Name:"www"
Type: "A – IPv4 address"
Alias:"No"
TTL:"1m"
Value: "IP of N.virginia_1 Instace"
Routing Policy: "Geolocation"
Continent/city: "default"
Health check: - 

- change the IP of via VPN and see the Japon page .
- Send the dns to students try for Europe and US.

---------------------------------------------------------------------------------------------
Private Hosted Zone
---------------------------------------------------------------------------------------------- 

# 20. Create Private hosted zone with thesame name of yor domain
  - www.awsdevopsteam.net
  - Vpc: Osvaldo VPC

# 21. Create A record with  "Local" instance IP in "Private Hosted Zone"
Name:"www"
Type: "A – IPv4 address"
Alias:"No"
TTL:"1m"
Value: "IP of Local Instace"
Routing Policy: "Simple"
Health check: - 

# 21. Provide conncetion to windows machine via RDP 

# 22. Create A record with  "N.Virginia_1" instance IP in "Prublic Hosted Zone"

Name:"www"
Type: "A – IPv4 address"
Alias:"No"
TTL:"1m"
Value: "N.Virginia_1 IP"
Routing Policy: "Simple"
Health check: - 

# 22. Go to windows machinee and open Internet Explorer and enter "wwww.awsdevopsteam.net" 
and this time ,in pulic internet, try "wwww.awsdevopsteam.net"  and you'll see different page.

---------------------------------------------------------------------------------------------
                                             Finish
---------------------------------------------------------------------------------------------- 