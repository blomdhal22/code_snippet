Setprop with shell command
==========================

When you set property using "setprop", runs your *.sh

Quick start
-----------

example:

```vim
$ setprop persist.sys.sample 1
Updated your sample shell
1
```

In Detail
----------

### 1. Make your own shell

example:


**sample.sh**

```vim
#!/system/bin/sh

echo 1 > /proc/driver/sample/0/mode
echo "UPDATED sample"
cat /proc/driver/sample/0/mode 
```

### 2. Make your rc

define service and set your shell command.

example:

**init.sample.rc**

```
# register service for log
service sample    /system/bin/sh /system/etc/sample.sh
    disabled
    oneshot

# switches
on property:persist.sys.sample=1
    start sample

on property:persist.sys.sample=0
    stop sample 
```

### 3. Import your rc to init.rc

example:

**init.rc**

```
# import rc in init.rc
import init.otg.rc
```

### 4. Copy your shell command and rc to runtime dir in AndroidProduct.mk

example:

**AndroidProduct.mk**

```
# Android copy files
PRODUCT_COPY_FILES += \
    vendor/sample/device/init.sample.rc:root/init.sample.rc     \
    vendor/sample/device/sample.sh:system/etc/sample.sh         \
```

