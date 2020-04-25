#!/system/bin/sh

## Start Profile

#Stop perfd and remove its default values
#stop perfd
#rm /data/vendor/perfd/default_values

################################################################################
            #=================================================#
            #        **          ******      negrroo          #
            #        **          *    *      **   **          #
            #        **          ******      **  **           #
            #        **          **          *****            #
            #        *******     ** **       **  **           #
            #        *******     **   **     **   **          #
            #=================================================#
##############################LawRun-Balanced###################################

# Profile Log
dt=`date '+%d/%m/%Y %H:%M:%S'`
echo "$dt Battery LRK applied" >> /storage/emulated/0/LawRun-Kernel/log.txt

################################################################################

                          #####################
                          #                   #
                          #        CPU        #
                          #                   #
                          #####################

################################################################################

# SILVER Cluster
echo "blu_schedutil" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo "300000" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
echo "1766400" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq

# GOLD Cluster
echo "blu_schedutil" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
echo "825600" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
echo "1766400" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq

#BOost
echo "0" > /sys/devices/system/cpu/cpu0/cpufreq/blu_schedutil/hispeed_freq
echo "0" > /sys/devices/system/cpu/cpu4/cpufreq/blu_schedutil/hispeed_freq
echo "979200" > /sys/module/cpu_input_boost/parameters/input_boost_freq_lp
echo "0" > /sys/module/cpu_input_boost/parameters/input_boost_freq_hp
echo "32" > /sys/module/cpu_input_boost/parameters/input_boost_duration

# Dynamic Schedtune Boost
echo "0" > /sys/module/cpu_input_boost/parameters/dynamic_stune_boost_duration
echo "0" > /sys/module/cpu_input_boost/parameters/dynamic_stune_boost

################################################################################

                          #####################
                          #                   #
                          #        GPU        #
                          #                   #
                          #####################

################################################################################

# Low Freq
echo "180000000" > /sys/class/kgsl/kgsl-3d0/devfreq/min_freq 
echo "180000000" > /sys/class/kgsl/kgsl-3d0/min_gpuclk

# High Freq
echo "520000000" > /sys/class/kgsl/kgsl-3d0/devfreq/max_freq 
echo "520000000" > /sys/class/kgsl/kgsl-3d0/max_gpuclk

# Limiter
echo "1" > /sys/class/kgsl/kgsl-3d0/throttling
echo "8" > /sys/class/kgsl/kgsl-3d0/default_pwrlevel
echo "powersave" > /sys/class/kgsl/kgsl-3d0/devfreq/governor

################################################################################

                          #####################
                          #                   #
                          #    Schedulers     #
                          #                   #
                          #####################

################################################################################

# IO Scheduler
echo "anxiety" > /sys/block/sda/queue/scheduler
echo "anxiety" > /sys/block/sdb/queue/scheduler
echo "anxiety" > /sys/block/sdc/queue/scheduler
echo "anxiety" > /sys/block/sdd/queue/scheduler
echo "anxiety" > /sys/block/sde/queue/scheduler
echo "anxiety" > /sys/block/sdf/queue/scheduler

################################################################################

                          #####################
                          #                   #
                          #      Battery      #
                          #                   #
                          #####################

################################################################################

# Charging mode
echo "2800000" > /sys/class/power_supply/battery/constant_charge_current_max

# Power
echo "Y" > /sys/module/workqueue/parameters/power_efficient

# Thermal
echo "-1" > /sys/class/thermal/thermal_message/sconfig

################################################################################

                          #####################
                          #                   #
                          #       Extra       #
                          #                   #
                          #####################

################################################################################

# Ram Management
# 2048 x 4 /1024 = 8
# lower number * higher multitasking
echo "0" > /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
echo "0" > /sys/module/lowmemorykiller/parameters/lmk_fast_run
echo "1" > /sys/module/lowmemorykiller/parameters/oom_reaper
echo "18432,23040,27648,32256,85296,120640" > /sys/module/lowmemorykiller/parameters/minfree

# zRam
swapoff /dev/block/zram0
echo 1 > /sys/block/zram0/reset
echo 0 > /sys/block/zram0/disksize
echo 0 > /proc/sys/vm/swappiness

################################LawRun-END#######################################

#start perfd back
#start perfd

## End Profile
