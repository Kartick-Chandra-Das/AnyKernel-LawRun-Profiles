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
echo "$dt Balanced LRK applied" >> /storage/emulated/0/LawRun-Kernel/log.txt

################################################################################

                          #####################
                          #                   #
                          #        CPU        #
                          #                   #
                          #####################

################################################################################

# SILVER Cluster
echo "schedutil" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo "300000" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
echo "1766400" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq

# GOLD Cluster
echo "blu_schedutil" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
echo "825600" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
echo "2323200" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq

# BOost
echo "1132800" > /sys/module/cpu_input_boost/parameters/input_boost_freq_lp
echo "902400" > /sys/module/cpu_input_boost/parameters/input_boost_freq_hp
echo "100" > /sys/module/cpu_input_boost/parameters/input_boost_duration

# Dynamic Schedtune Boost
echo "1500" > /sys/module/cpu_input_boost/parameters/dynamic_stune_boost_duration
echo "25" > /sys/module/cpu_input_boost/parameters/dynamic_stune_boost

# SILVER Cluster Limiter
echo "20000" > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/down_rate_limit_us
echo "0" > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_freq
echo "90" > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_load
echo "0" > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/iowait_boost_enable
echo "1" > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/pl
echo "500" > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/up_rate_limit_us

# GOLD Cluster Limiter
echo "20000" > /sys/devices/system/cpu/cpu4/cpufreq/blu_schedutil/down_rate_limit_us
echo "0" > /sys/devices/system/cpu/cpu4/cpufreq/blu_schedutil/hispeed_freq
echo "90" > /sys/devices/system/cpu/cpu4/cpufreq/blu_schedutil/hispeed_load
echo "0" > /sys/devices/system/cpu/cpu4/cpufreq/blu_schedutil/iowait_boost_enable
echo "1" > /sys/devices/system/cpu/cpu4/cpufreq/blu_schedutil/pl
echo "500" > /sys/devices/system/cpu/cpu4/cpufreq/blu_schedutil/up_rate_limit_us

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
echo "710000000" > /sys/class/kgsl/kgsl-3d0/devfreq/max_freq 
echo "710000000" > /sys/class/kgsl/kgsl-3d0/max_gpuclk

# Limiter
echo "1" > /sys/class/kgsl/kgsl-3d0/throttling
echo "8" > /sys/class/kgsl/kgsl-3d0/default_pwrlevel
echo "msm-adreno-tz" > /sys/class/kgsl/kgsl-3d0/devfreq/governor

################################################################################

                          #####################
                          #                   #
                          #    Schedulers     #
                          #                   #
                          #####################

################################################################################

# IO Scheduler
echo "deadline" > /sys/block/sda/queue/scheduler
echo "deadline" > /sys/block/sdb/queue/scheduler
echo "deadline" > /sys/block/sdc/queue/scheduler
echo "deadline" > /sys/block/sdd/queue/scheduler
echo "deadline" > /sys/block/sde/queue/scheduler
echo "deadline" > /sys/block/sdf/queue/scheduler

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

# Thermals
echo -1 > /sys/class/thermal/thermal_message/sconfig

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
echo "2048,3072,11520,16640,24320,42240" > /sys/module/lowmemorykiller/parameters/minfree

# zRam
swapoff /dev/block/zram0
echo 1 > /sys/block/zram0/reset
echo 0 > /sys/block/zram0/disksize
echo 1610612736 > /sys/block/zram0/disksize
echo 1536M > /sys/block/zram0/mem_limit
echo 8 > /sys/block/zram0/max_comp_streams
mkswap /dev/block/zram0
swapon /dev/block/zram0 -p 32758
echo 65 > /proc/sys/vm/swappiness
echo 10 > /proc/sys/vm/dirty_background_ratio
echo 60 > /proc/sys/vm/vfs_cache_pressure
echo 3000 > /proc/sys/vm/dirty_writeback_centisecs

################################LawRun-END#######################################

#start perfd back
#start perfd

## End Profile