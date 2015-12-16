#!/system/bin/sh

echo 1 > /proc/driver/sample/0/mode
echo "UPDATED sample"
cat /proc/driver/sample/0/mode
