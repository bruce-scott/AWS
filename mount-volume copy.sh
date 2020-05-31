
----------------------------------------------------------------
#STEP-1 Check volumes on instance 
lsblk

#STEP-2 Check file system
df -h

#STEP-3 Check if volume has any data
sudo file -s /dev/xvd*
# if no data -> /dev/xvdf:data

#STEP-4 Format volume
sudo mkfs -t ext4 /dev/xvdf

#STEP-5 Create mount directory
sudo mkdir /mp

#STEP-6 Mount the volume
sudo mount /dev/xvdf /mp

#STEP-7 Check volume content
cd /mp
ls
# lost+found for empty volume

# STEP-8 Creating file
cd /mp
sudo touch index.html
ls 
--------------------------

-Stop the Instance-

#STEP-1 Check the volume
lsblk
df -h 

#STEP-2 Mount the volume
sudo mount /dev/xvdf /mp

#STEP-3 Check volume content
cd /mp
ls
# you'll see (lost+found) and index.html
---------------------------

-Automount EBS Volume on Reboot-

#Step 1: Back up the /etc/fstab file.
sudo cp /etc/fstab /etc/fstab.backup

#OPTINAL Step 2: copy UUID
sudo file -s /dev/xvdf OR sudo blkid
#copy the UUDI

#Step 3: Open /etc/fstab file and make an entry in the following format.
sudo vim /etc/fstab 
/dev/xvdf       /mp   ext4    defaults,nofail        0       0

#Step 4: Execute the following command to check id the fstab file has any error.
sudo mount -a
lslbk
ls /mp # you'll see (lost+found)

#Step 5: reboot the instance and check the file 
sudo reboot now
#connect again
lsblk
cd /mp
ls
# you'll see (lost+found) and index.html

---------------------------------

-EXTEND THE SIZE-Without Partition-
#Resize EBS

sudo resize2fs /dev/xvdf
lsblk
df -h
cd /mp
ls
# you'll see (lost+found) and index.html

---------------------------------

-EXTEND THE SIZE- With Partition-

Create new volume and instace

#Resize EBS

#Step 0:
lsblk # you2ll see that there is no partiton of dev/xvdf

#Step 1: Umont if it is mounted .Suggest you to crate new volume and don't mount.
sudo umount /dev/xvdf

#Step 2: Make partition

sudo fdisk /dev/xvdf
# n -> add new partition
# p -> primary
# w -> write partition table

#Step 3: Control 
lsblk # you'll see the partition but Not mounted

#Step :4 Format the partition .Be carefull .If you format /xvdf you'll loose the partition.
sudo mkfs -t ext4 /dev/xvdf1  #(1 is important)


#Step 5:mount the /dev/xvdf1 #(1 is important)
sudo mkdir /mp2 
sudo mount /dev/xvdf1 /mp2


#Step 6: From console, modify te volume:

#Step 7: show that dsik size and logical volume siz different to extend the partition 
#on each volume 
lsblk 
sudo growpart /dev/xvdf 1 #(attention for space)(1 is important)


#Step 8: Extending the file system
df -h
sudo resize2fs /dev/xvdf1 #(1 is important)
df -h








