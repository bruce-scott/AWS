LAB-Setting Up VPC

Public olanlar
10.40.10.0/24 (251 tane IP adresi atayabiliriz ama biz sadece 251 tanesini kullanabileceğiz)
10.40.20.0/24

Private olanlar
10.40.11.0/24
10.40.21.0/24


1. Create VPC

create a vpc named workshop-VPC-a    CIDR blok is  ----> 10.40.0.0/16 

a.  enable DNS hostnames for the vpc workshop-VPC
b.  Rename route table 'workshop-default-rt'

2. Create Subnets

Public
10.40.10.0/24 'workshop-AZ-1A-public-subnet' 
10.40.20.0/24 'workshop- AZ-1A-private-subnet' 

Private
10.40.11.0/24 'workshop- AZ-1B -public-subnet'
10.40.21.0/24 'workshop- AZ-1B-private-subnet'

3. create a private route table (not allowing access to the internet) named 'workshop-private-rt' in the vpc workshop-VPC-a for private subnets

Now we have two route table;
i. Private route table
ii. Public Route table

associate route table with subnets which belong to 

Now we have two route table;
a. Private route table
b. Public Route table

4. enable Auto-Assign Public IPv4 Address for public subnets

5. Internet Gateway
a. create an internet gateway named 'workshop-IGW'
b. ATTACH the internet gateway 'workshop-IGW' to the vpc 'workshop-VPC'

6. add a route for destination 0.0.0.0/0 (any network, any host) to target the internet gateway 'workshop-IGW' in order to allow access to the internet

7. Bastion Host (Jump Box)

a. Create EC2 named 'Workshop-VPC-Public-EC2' in one of the public subnet
SSH --> anywhere
http --> anywhere
https ---> anywhere

b. Create EC2 named 'Workshop-VPC-Private-EC2' in one of the private subnet
SSH --> anywhere
http --> anywhere
https ---> anywhere

Dont forget to copy your pem key while connecting 

8. Elastic IP
allocate Elastic IP and name it 'workshop-eip'
Attach it to EC2 located public subnet. 

NAT Gateway and Nat Instance
9. NAT Gateway
a. create a NAT Gateway in the public subnet workshop-az1a-public-subnet using the workshop-eip-for-nat-gw and name it 'workshop-az1a-nat-gw'
b. set a rule in workshop-private-rt to ensure requests to be routed to the NAT Gateway workshop-az1a-nat-gw

10. NAT Instance
a. launch an instance from amzn-ami-vpc-nat-hvm-2018.03.0.20181116-x86_64-ebs (ami-00a9d4a05375b2763) in workshop-az1b-public-subnet using public-custom-sg-for-workshop-VPC-a and name it as 'NAT Instance'

Nat Instances Security Group
ssh ---->  22 ------> anywhere
http ---> 80 ------> custom 10.40.0.0/16 (workshop VPC’nin CIDR bloğunu veriyorum)
https ---> 443 ------> custom 10.40.0.0/16 (workshop VPC’nin CIDR bloğunu veriyorum)

b. disable source/destination check on NAT Instance
c. Rearrange Route Table for Nat Instance

11. EndPoint

a. Create S3 Bucket and pu some files in it
b. We can reach this S3 bucket with the EC2 in Private Subnet
c. Cut internet from private route table
d. Create Endpoint
e. Show Endpoint list
f. Repeat connecting S3 bucket with EC2 located private subnet

12. VPC peering

a. Show Default VPC and our VPC that we have just created 
b. Try to connect EC2 located private subnet on workshop-VPC from EC2 located default VPC
c. Create peering connection
Accepter: workshop-VPC
Requester: Default-VPC
d. public and private route table is edited with peering connection and give permission to each CIDR block















