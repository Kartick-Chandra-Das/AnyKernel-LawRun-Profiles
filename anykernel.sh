# AnyKernelx Ramdisk Mod Script
# osm0sis @ xda-developers
# negrroo
# LawRun-Kernel Edit.

## AnyKernel setup
# begin properties
properties() {
do.cleanup=1
do.cleanuponabort=0
} # end properties

# shell variables
block=

## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak3-core.sh;

## AnyKernel permissions
# set permissions for included ramdisk files
set_perm_recursive 0 0 755 750 $ramdisk/*;
chmod +x $ramdisk/sbin/spa;


# Find boot partition
find_boot;

## AnyKernel install
dump_boot;

# begin ramdisk changes

# migrate from /overlay to /overlay.d to enable SAR Magisk
if [ -d $ramdisk/overlay ]; then
  rm -rf $ramdisk/overlay;
fi;

# Magisk Check..
if [ -d $ramdisk/.backup ]; then
    ui_print "Running LawRun Ramdisk Tweaks";
else
    ui_print "ALWAYS BE READY TO RUN!!...";
fi;

# end ramdisk changes

write_boot;

# end install
