#!/system/bin/sh

mount -o remount,rw -t auto /system
mount -o remount,rw -t auto /data
mount -t rootfs -o remount,rw rootfs

#-------------------------
# FAKE KNOX 0
#-------------------------

/sbin/resetprop -v -n ro.boot.warranty_bit "0"
/sbin/resetprop -v -n ro.warranty_bit "0"


#-------------------------
# FLAGS FOR SAFETYNET
#-------------------------

/sbin/resetprop -n ro.boot.veritymode "enforcing"
/sbin/resetprop -n ro.boot.verifiedbootstate "green"
/sbin/resetprop -n ro.boot.flash.locked "1"
/sbin/resetprop -n ro.boot.ddrinfo "00000001"


if [ ! -e /system/etc/init.d ]; then
   mkdir /system/etc/init.d
   chown -R root.root /system/etc/init.d
   chmod -R 755 /system/etc/init.d
fi

for FILE in /system/etc/init.d/*; do
   sh $FILE >/dev/null
done;

mount -t rootfs -o remount,ro rootfs
mount -o remount,rw -t auto /data
mount -o remount,ro -t auto /system