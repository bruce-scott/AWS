# 06-14-2020
# AWS Lab Session - Callahan
# Virtual Private Cloud (VPC)

# Session starts at 11am EST

# PART 1 - Setting Up VPC
# create a vpc with 3 public subnets and 3 private subnets and place them in 3 AZs, each az should include 1 public and 1 private subnet.

# create a vpc named 'call-lab-vpc-a' with 10.7.0.0/16 CIDR
    # no ipv6 CIDR block
    # tenancy: default
# explain the vpc descriptions
# enable DNS hostnames for the vpc 'call-lab-vpc-a'

# create an internet gateway named 'call-lab-igw'
# attach the internet gateway 'call-lab-igw' to the vpc 'call-lab-vpc-a'
# rename the route table of the vpc 'call-lab-vpc-a' as 'call-lab-default-rt'
# add a route for destination 0.0.0.0/0 (any network, any host) to target the internet gateway 'call-lab-igw' in order to allow access to the internet
# explain routes in the call-lab-default-rt

# create a public subnet named 'call-lab-az1a-public-subnet' under the vpc call-lab-vpc-a in AZ us-east-1a with 10.7.1.0/24
# create a private subnet named 'call-lab-az1a-private-subnet' under the vpc call-lab-vpc-a in AZ us-east-1a with 10.7.2.0/24
# create a public subnet named 'call-lab-az1b-public-subnet' under the vpc call-lab-vpc-a in AZ us-east-1b with 10.7.4.0/24
# create a private subnet named 'call-lab-az1b-private-subnet' under the vpc call-lab-vpc-a in AZ us-east-1b with 10.7.5.0/24
# create a public subnet named 'call-lab-az1c-public-subnet' under the vpc call-lab-vpc-a in AZ us-east-1c with 10.7.7.0/24
# create a private subnet named 'call-lab-az1c-private-subnet' under the vpc call-lab-vpc-a in AZ us-east-1c with 10.7.8.0/24
# explain the subnet descriptions and reserved ips (why 251 instead of 256)
# show the default subnet associations on the route table call-lab-default-rt (internet access even on private subnets)
# create a private route table (not allowing access to the internet) named 'call-lab-private-rt' in the vpc call-lab-vpc-a for private subnets
# show the routes in the route table call-lab-private-rt
# associate the route table call-lab-private-rt with private subnets
# enable Auto-Assign Public IPv4 Address for public subnets

############################ We left off here...


# show the default security group for the vpc call-lab-vpc-a and name it as 'default-sg-for-call-lab-vpc-a'
# create a custom security group with default values for public subnets within the vpc call-lab-vpc-a and name it as 'public-custom-sg-for-call-lab-vpc-a'
# show and explain inbound and outbound rules of public-custom-sg-for-call-lab-vpc-a
# set inbound rule for public-custom-sg-for-call-lab-vpc-a -->  type:ssh, port:22, source:my ip, description: 'allow ssh from call localhost'
# set inbound rule  for public-custom-sg-for-call-lab-vpc-a --> type:ssh, port:22, source:public-custom-sg-for-call-lab-vpc-a, description: 'allow ssh from public-custom-sg-for-call-lab-vpc-a' 
# set inbound rule for public-custom-sg-for-call-lab-vpc-a --> type:all icmp - ipv4, port:all, source:my ip, description: 'allow icmp from call localhost' 
# set inbound rule for public-custom-sg-for-call-lab-vpc-a --> type:all icmp - ipv4, port:all, source:public-custom-sg-for-call-lab-vpc-a, description: 'allow icmp from public-custom-sg-for-call-lab-vpc-a' 

# create a custom security group with default values for private subnets within the vpc call-lab-vpc-a and name it as 'private-custom-sg-for-call-lab-vpc-a'
# set inbound rule for private-custom-sg-for-call-lab-vpc-a --> type:all, port:all, source:public-custom-sg-for-call-lab-vpc-a, description: 'allow all from public-custom-sg-for-call-lab-vpc-a' 
# set inbound rule for private-custom-sg-for-call-lab-vpc-a  --> type:all, port:all, source:private-custom-sg-for-call-lab-vpc-a, description: 'allow all from private-custom-sg-for-call-lab-vpc-a' 

# show the default network acl for the vpc call-lab-vpc-a and name it as 'default-nacl-for-call-lab-vpc-a'
# explain the working principles of rules -> the lower number: the higher priority, rules numbering btwn 1-32766, rules policies: allow/deny, default rule of *.
# create a custom network acl for public subnets on the vpc call-lab-vpc-a and name it as 'public-custom-nacl-for-call-lab-vpc-a'
# show default the inbound and outbound rules of public-custom-nacl-for-call-lab-vpc-a
# set inbound rule for public-custom-nacl-for-call-lab-vpc-a; rule #: 80, type:ssh, port:22, source:0.0.0.0/0, policy: allow 
# set inbound rule for public-custom-nacl-for-call-lab-vpc-a; rule #: 120, type:all icmp - ipv4, port:all, source:0.0.0.0/0, policy: allow 
# set outbound rule for public-custom-nacl-for-call-lab-vpc-a; rule #: 80, type:ssh, port:22, destination:0.0.0.0/0, policy: allow 
# set outbound rule for public-custom-nacl-for-call-lab-vpc-a; rule #: 120, type:all icmp - ipv4, port:all, destination:0.0.0.0/0, policy: allow 
# explain the rules applied for public-custom-nacl-for-call-lab-vpc-a
# create a custom network acl for private subnets on the vpc call-lab-vpc-a and name it as 'private-custom-nacl-for-call-lab-vpc-a'
# set inbound rule for private-custom-nacl-for-call-lab-vpc-a; rule #: 80, type:all, port:22, source:10.7.0.0/16, policy: allow 
# set outbound rule for private-custom-nacl-for-call-lab-vpc-a; rule #: 80, type:all, port:22, destination:10.7.0.0/16, policy: allow 

# launch an instance (amazon linux 2) in az-1a public subnet using the public-custom-sg-for-call-lab-vpc-a and name it 'ec2-in-az1a-public-sn'
# launch an instance (amazon linux 2) in az-1a private subnet using the private-custom-sg-for-call-lab-vpc-a and name it 'ec2-in-az1a-private-sn'
# summarize what we have done so far
# show and explain the descriptions on ec2-in-az1a-public-sn instance
# show and explain the descriptions on ec2-in-az1a-private-sn instance
# connect to the ec2-in-az1a-public-sn instance with ssh
# show the interface configuration of the ec2-in-az1a-public-sn
# show the routes for the ec2-in-az1a-public-sn
# show that ec2-in-az1a-public-sn instance has internet connection (use ping and curl command)
# show that ec2-in-az1a-public-sn instance has connection with instances in private subnet(use ping)


# PART 2 - Bastion Host and NAT Gateway/Instance
# discuss about how to connect to the ec2-in-az1a-private-sn instance
# launch an instance (amazon linux 2) in az-1a private subnet using the private-custom-sg-for-call-lab-vpc-a, by enabling public-ip-assign and name it 'ec2-w/public-ip-in-az1a-private-sn'
# show that even with public-ip, we cannot connect to it with ssh due to rules in routing table

# setup a jump box/bastion host using the currently running ec2-in-az1a-public-sn instance to connect the instances in private subnet
# add your private key to the ssh agent on your localhost
# run the ssh agent if it is returning error like "Could not open a connection to your authentication agent"
# try again to add your private key to the ssh agent
# connect to the ec2-in-az1a-public-sn instance in public subnet
# once logged into the ec2-in-az1a-public-sn (bastion host/jump box), connect to the ec2-in-az1a-private-sn instance in the private subnet 
# show that the ec2-in-az1a-private-sn has connection with the ec2-in-az1a-public-sn instance
# show that the ec2-in-az1a-private-sn has connection with the ec2-w/public-ip-in-az1a-private-sn instance
# show that the ec2-in-az1a-private-sn does not have connection with the internet
# show the interface config of the ec2-in-az1a-private-sn
# show the route config of the ec2-in-az1a-private-sn

# discuss about how to connect to internet from the ec2-in-az1a-private-sn instance in private subnet
# OPTION 1
# set up internet connection with NAT Gateway
# allocate Elastic IP and name it 'call-lab-eip-for-nat-gw'
# create a NAT Gateway in the public subnet call-lab-az1a-public-subnet using the call-lab-eip-for-nat-gw and name it 'call-lab-az1a-nat-gw'
# set a rule in call-lab-private-rt to ensure requests to be routed to the NAT Gateway call-lab-az1a-nat-gw
# connect to the ec2-in-az1a-private-sn instance in the private subnet with ssh via bastion host
# show that the ec2-in-az1a-private-sn now has connection with the internet

# OPTION 2
# set up internet connection with NAT Instance
# launch an instance from amzn-ami-vpc-nat-hvm-2018.03.0.20181116-x86_64-ebs (ami-00a9d4a05375b2763) in call-lab-az1b-public-subnet using public-custom-sg-for-call-lab-vpc-a and name it as 'NAT Instance'
# disable source/destination check on NAT Instance
# create a private route table named 'call-lab-private-rt-for-nat-ins' in the vpc call-lab-vpc-a for call-lab-az1b-private-subnet
# show the routes in the route table call-lab-private-rt-for-nat-ins
# set a rule in call-lab-private-rt-for-nat-ins to ensure requests to be routed to the NAT Instance
# associate the route table call-lab-private-rt-for-nat-ins with private subnet call-lab-az1b-private-subnet
# launch an instance (amazon linux 2) in az-1b private subnet using the private-custom-sg-for-call-lab-vpc-a and name it 'ec2-in-az1b-private-sn'
# connect to the ec2-in-az1b-private-sn instance in the private subnet with ssh via bastion host
# show that the ec2-in-az1a-private-sn now has connection with the internet

# PART 3 - VPC Peering
# connect to the ec2-in-az1a-public-sn instance in the public subnet with ssh 
# show that the ec2-in-az1a-public-sn in call-lab-vpc-a does not have connection with MySQL Database Server in default-vpc
# create vpc peering between call-lab-vpc-a (requester) and default-vpc (accepter) and name it 'call-lab-vpc-a-peering-w/default-vpc'
# accept the request on peering dashboard
# add route for peering connection from default-vpc in the call-lab-default-rt
# add route for peering connection from default-vpc in the call-lab-private-rt
# add route for peering connection from call-lab-vpc-a in the default-rt
# set inbound rule for db-servers-sg --> rule type:all icmp - ipv4, port:all, source:call-lab-vpc-a, description: 'allow icmp for call-lab-vpc-a' 
# set inbound rule for public-custom-sg-for-call-lab-vpc-a --> type:all icmp - ipv4, port:all, source:defaul-vpc, description: 'allow icmp for default-vpc' 
# connect to the ec2-in-az1a-public-sn instance in the public subnet with ssh 
# show that the ec2-in-az1a-public-sn in call-lab-vpc-a now has connection with MySQL Database Server in default-vpc
# connect to the ec2-in-az1a-private-sn instance in the private subnet with ssh via bastion host
# show that the ec2-in-az1a-private-sn has connection with the internet
# connect to the MySQL Database Server in default-vpc with ssh 
# show that MySQL Database Server in default-vpc has connection with  the ec2-in-az1a-public-sn and ec2-in-az1a-private-sn instances in call-lab-vpc-a

