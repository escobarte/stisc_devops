## Version :A 
#fdisk /dev/sdb
	n, p, 1, Enter, Enter, t, 8e 	//The partition table has been altered.
pvcreate /dev/sdb1 				//  Physical volume "/dev/sdb1" successfully created.
vgcreate vg_app2 /dev/sdb1		//  Volume group "vp_app2" successfully created
	// I did an error in name, so I rename it [vgrename vp_app2 vg_app2, vgs]
lvcreate -n www -L 5G vg_app2   //  Logical volume "www" created.
mkfs.ext4 /dev/vg_app2/www		// Creating filesystems
mkdir -p /var/www
echo '/dev/vg_app2/www /var/www ext4 defaults 2 0' | sudo tee -a /etc/fstab //For mounting at machine boot
mount -a
sysmtectl daemon-reload
 