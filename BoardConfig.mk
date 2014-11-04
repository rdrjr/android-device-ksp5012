#
# Copyright (C) 2011 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# define OMAP_ENHANCEMENT variables
include device/phytec/pcm049/Config.mk

# These two variables are set first, so they can be overridden
# by BoardConfigVendor.mk
BOARD_USES_GENERIC_AUDIO := false
USE_CAMERA_STUB := true

OMAP_ENHANCEMENT := true
OMAP_ENHANCEMENT_MULTIGPU := true

# Use the non-open-source parts, if they're present
#-include vendor/phytec/pcm049/BoardConfigVendor.mk

ENHANCED_DOMX := true
BLTSVILLE_ENHANCEMENT := true
BOARD_USES_DVP := true
BOARD_USES_ARX := true

TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_SMP := true
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
ARCH_ARM_HAVE_TLS_REGISTER := true

#BOARD_HAVE_BLUETOOTH := true
#BOARD_HAVE_BLUETOOTH_TI := true
#BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/phytec/pcm049/bluetooth

TARGET_NO_BOOTLOADER := true
TARGET_NO_RECOVERY := true
TARGET_NO_KERNEL := true

BOARD_KERNEL_BASE := 0x80000000

TARGET_NO_RADIOIMAGE := true
TARGET_BOARD_PLATFORM := omap4
TARGET_BOOTLOADER_BOARD_NAME := pcm049 

BOARD_EGL_CFG := device/phytec/pcm049/egl.cfg

USE_OPENGL_RENDERER := true

TARGET_USERIMAGES_USE_EXT4 := true
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 268435456
#BOARD_SYSTEMIMAGE_PARTITION_SIZE := 16777216
BOARD_USERDATAIMAGE_PARTITION_SIZE := 536870912
BOARD_CACHEIMAGE_PARTITION_SIZE := 268435456
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_FLASH_BLOCK_SIZE := 4096

USES_TI_MAC80211 := true
BOARD_WPA_SUPPLICANT_DRIVER      := NL80211
WPA_SUPPLICANT_VERSION           := VER_0_8_X_TI
BOARD_HOSTAPD_DRIVER             := NL80211
BOARD_WLAN_DEVICE                := wl12xx_mac80211
BOARD_SOFTAP_DEVICE              := wl12xx_mac80211
WIFI_DRIVER_MODULE_PATH          := "/system/lib/modules/wlcore_sdio.ko"
WIFI_DRIVER_MODULE_NAME          := "wlcore_sdio"
WIFI_FIRMWARE_LOADER             := ""
COMMON_GLOBAL_CFLAGS += -DUSES_TI_MAC80211

#BOARD_GPS_LIBRARIES := gps.pcm049

#Set 32 byte cache line to true
ARCH_ARM_HAVE_32_BYTE_CACHE_LINES := true

# Common device independent definitions
include device/ti/common-open/BoardConfig.mk
