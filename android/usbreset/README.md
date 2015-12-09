USB RESET
=========

ref: http://askubuntu.com/questions/645/how-do-you-reset-a-usb-device-from-the-command-line

```c
// usbreset.c

#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/ioctl.h>

#include <linux/usbdevice_fs.h>


int main(int argc, char **argv)
{
    const char *filename;
    int fd;
    int rc;

    if (argc != 2) {
        fprintf(stderr, "Usage: usbreset device-filename\n");
        return 1;
    }
    filename = argv[1];

    fd = open(filename, O_WRONLY);
    if (fd < 0) {
        perror("Error opening output file");
        return 1;
    }

    printf("Resetting USB device %s\n", filename);
    rc = ioctl(fd, USBDEVFS_RESET, 0);
    if (rc < 0) {
        perror("Error in ioctl");
        return 1;
    }
    printf("Reset successful\n");

    close(fd);
    return 0;
}
```

Quick Start
-------------

*On your android device*

```vim
root@android:/system/bin # ./usbreset /dev/bus/usb/001/030

Resetting USB device /dev/bus/usb/001/030
[70479.265198 / 01-26 11:06:48.250] usb 1-1.1.1: reset high speed USB device number 30 using fsl-ehci
Error in ioctl[70479.306384 / 01-26 11:06:48.290] usb 1-1.1.1: USB disconnect, device number 30
: No such device
1|root@android:/system/bin # [70479.565197 / 01-26 11:06:48.550] usb 1-1.1.1: new high speed USB device number 31 using fsl-ehci
[70480.953259 / 01-26 11:06:49.930] usb 1-1.1.1: USB disconnect, device number 31
[70481.215149 / 01-26 11:06:50.200] usb 1-1.1.1: new high speed USB device number 32 using fsl-ehci
```

How to Build
-------------

* Use Android mm or mmm build. Assume that 'usbtest' folder is "vendor/test/usbtest".

```vim
$ mmm vendor/test/usbtest
```

* adb push to /system/bin/

```vim
$ cd <mydroid>/out/target/product/<your device>/system/bin/
$ adb push usbtest /system/bin
```

* change mode and run with usb device path.

```vim
root@android:/system/bin # chmod 755 usbreset
root@android:/system/bin # ./usbreset /dev/bus/usb/001/030
```
