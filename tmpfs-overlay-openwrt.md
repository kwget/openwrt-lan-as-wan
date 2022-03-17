# Use TMPFS as Overlay on your OpenWRT
* Sometimes we need just space to play, even if we now the TMPFS will be destroyed after a reboot :D

How to do this under the openWRT.


# create directories and setup a dedicated tmpfs for the overlay
````
mkdir -p /newroot /oldroot /overlay_tmpfs
mount -t tmpfs tmpfs /overlay_tmpfs
chmod 755 /newroot /oldroot /overlay_tmpfs
mkdir -p /overlay_tmpfs/rom /overlay_tmpfs/lower /overlay_tmpfs/upper /overlay_tmpfs/work
````

# setup read-only bind mounts of '/rom' and '/overlay/upper' into '/overlay_tmpfs'
````
mount -o bind,ro /rom /overlay_tmpfs/rom
mount -o bind,ro /overlay/upper /overlay_tmpfs/lower
````

# setup tmpfs overlay (tmpfs <-- /overlay/upper <-- /rom) at '/newroot'
````
mount -t overlay -o rw,noatime,lowerdir=/overlay_tmpfs/lower:/overlay_tmpfs/rom,upperdir=/overlay_tmpfs/upper,workdir=/overlay_tmpfs/work/ overlayfs:/overlay_tmpfs /newroot
````

# bind-mount everything else into '/newroot'
````
cat /proc/mounts | awk '{print $2}' | grep -Fv '/newroot' | grep -Ev '^\/$' | while read -r nn; do mkdir -p "/newroot${nn}"; findmnt "/newroot${nn}" 1>/dev/null 2>/dev/null || mount -o bind "${nn}" "/newroot${nn}"; done
````

# THIS ENABLES THE TMPFS OVERLAY
# pivot root to '/newroot'
````
pivot_root /newroot /newroot/oldroot
wifi up
/etc/init.d/wpad restart
/etc/init.d/network restart
````

# THIS DISABLES THE TMPFS OVERLAY
# pivot root to '/oldroot'
````
pivot_root /oldroot /oldroot/newroot
wifi up
/etc/init.d/wpad restart
/etc/init.d/network restart
````
