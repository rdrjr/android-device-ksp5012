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

DEVICE_PACKAGE_OVERLAYS := device/phytec/pcm049/overlay

# MultiDisplay
PRODUCT_PACKAGES += \
	TIMultiDisplay

PRODUCT_COPY_FILES += \
	device/phytec/pcm049/init.pcm049.rc:root/init.pcm049.rc \
	device/phytec/pcm049/init.pcm049.usb.rc:root/init.pcm049.usb.rc \
	device/phytec/pcm049/init.pcm049.wifi.rc:root/init.pcm049.wifi.rc \
        device/phytec/pcm049/fstab.pcm049:root/fstab.pcm049 \
	device/phytec/pcm049/ueventd.pcm049.rc:root/ueventd.pcm049.rc \
	device/phytec/pcm049/mixer_paths.xml:system/etc/mixer_paths.xml \
	device/phytec/pcm049/media_profiles.xml:system/etc/media_profiles.xml \
	device/phytec/pcm049/media_codecs.xml:system/etc/media_codecs.xml \
	device/phytec/pcm049/stmpe-ts.idc:system/usr/idc/stmpe-ts.idc \
	device/phytec/pcm049/audio/audio_policy.conf:system/etc/audio_policy.conf \
	device/phytec/pcm049/twl6030_pwrbutton.kl:system/usr/keylayout/twl6030_pwrbutton.kl \
	device/phytec/pcm049/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
        device/phytec/pcm049/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
	frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
	frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
	frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
	frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
	frameworks/native/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml \
	frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml

# to mount the external storage (sdcard)
PRODUCT_COPY_FILES += \
        device/phytec/pcm049/vold.fstab:system/etc/vold.fstab

PRODUCT_PACKAGES += \
	lights.pcm049

PRODUCT_PACKAGES += \
	boardidentity \
	libboardidentity \
	libboard_idJNI \
	Board_id

PRODUCT_PACKAGES += \
	ti_omap4_ducati_bins

PRODUCT_PACKAGES += \
	CameraOMAP \
	Camera \
	camera_test

PRODUCT_PROPERTY_OVERRIDES += \
 	ro.hwui.disable_scissor_opt=true \
	ro.hwui.drop_shadow_cache_size=1 \
	ro.hwui.gradient_cache_size=0.5 \
	ro.hwui.layer_cache_size=4 \
	ro.hwui.patch_cache_size=64 \
	ro.hwui.path_cache_size=1 \
	ro.hwui.r_buffer_cache_size=1 \
	ro.hwui.shape_cache_size=0.5 \
	ro.hwui.text_large_cache_height=512 \
	ro.hwui.text_large_cache_width=2048 \
	ro.hwui.text_small_cache_height=256 \
	ro.hwui.text_small_cache_width=1024 \
	ro.hwui.texture_cache_flushrate=0.4 \
	ro.hwui.texture_cache_size=12 \
	debug.hwui.render_dirty_regions=false

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
        persist.sys.usb.config=mtp

PRODUCT_PROPERTY_OVERRIDES += \
        ro.opengles.version=131072

PRODUCT_PROPERTY_OVERRIDES += \
        ro.sf.lcd_density=240

PRODUCT_PROPERTY_OVERRIDES += \
	persist.hwc.mirroring.region=0:0:800:480

PRODUCT_PACKAGES += \
	com.android.future.usb.accessory

PRODUCT_PROPERTY_OVERRIDES += \
	wifi.interface=wlan0 \

PRODUCT_CHARACTERISTICS := tablet

PRODUCT_PACKAGES += \
	hwcomposer.omap4

PRODUCT_TAGS += dalvik.gc.type-precise

PRODUCT_PACKAGES += \
	audio.primary.pcm049

# tinyalsa utils
PRODUCT_PACKAGES += \
	tinymix \
	tinyplay \
	tinycap

# Audioout libs
PRODUCT_PACKAGES += \
	libaudioutils

# Enable AAC 5.1 decode (decoder)
PRODUCT_PROPERTY_OVERRIDES += \
	media.aac_51_output_enabled=true

PRODUCT_PACKAGES += \
	TQS_D_1.7.ini \
	TQS_D_1.7_127x.ini \
	hostapd.conf \
	wifical.sh \
	wilink7.sh \
	crda \
	regulatory.bin \
	calibrator

# Filesystem management tools
PRODUCT_PACKAGES += \
	e2fsck \
	setup_fs

#DUCATI_TGZ := device/ti/proprietary-open/omap4/ducati_blaze_tablet.tgz
PRODUCT_PACKAGES += ducati-m3-core0.xem3

PRODUCT_PROPERTY_OVERRIDES += \
	dalvik.vm.heapstartsize=5m \
	dalvik.vm.heapgrowthlimit=72m \
	dalvik.vm.heapsize=192m \
	dalvik.vm.heaptargetutilization=0.75 \
	dalvik.vm.heapminfree=512k \
	dalvik.vm.heapmaxfree=2m \
	dalvik.vm.jit.codecachesize=0 \
	persist.sys.dalvik.vm.lib=libdvm.so \
	dalvik.vm.dexopt-flags=m=y

# SMC components for secure services like crypto, secure storage
PRODUCT_PACKAGES += \
	smc_pa.ift \
	smc_normal_world_android_cfg.ini \
	libsmapi.so \
	libtf_crypto_sst.so \
	libtfsw_jce_provider.so \
	tfsw_jce_provider.jar \
	tfctrl

PRODUCT_PACKAGES += \
	pcm049_hdcp_keys

PRODUCT_PROPERTY_OVERRIDES += \
	ro.carrier=wifi-only

#$(call inherit-product, frameworks/native/build/tablet-dalvik-heap.mk)
$(call inherit-product, hardware/ti/omap4xxx/omap4.mk)
$(call inherit-product-if-exists, hardware/ti/wpan/ti-wpan-products.mk)
$(call inherit-product-if-exists, device/ti/proprietary-open/omap4/ti-omap4-vendor.mk)
$(call inherit-product-if-exists, device/ti/proprietary-open/wl12xx/wlan/wl12xx-wlan-fw-products.mk)
$(call inherit-product-if-exists, device/ti/proprietary-open/wl12xx/wpan/wl12xx-wpan-fw-products.mk)
$(call inherit-product-if-exists, device/ti/common-open/wfd/wfd-products.mk)
$(call inherit-product-if-exists, device/ti/common-open/s3d/s3d-products.mk)
#$(call inherit-product-if-exists, device/ti/proprietary-open/omap4/ducati-full_blaze.mk)
#$(call inherit-product-if-exists, device/ti/proprietary-open/omap4/dsp_fw.mk)
#$(call inherit-product-if-exists, hardware/ti/dvp/dvp-products.mk)
#$(call inherit-product-if-exists, hardware/ti/arx/arx-products.mk)

ifdef OMAP_ENHANCEMENT_CPCAM
$(call inherit-product-if-exists, device/ti/common-open/cpcam/cpcam-products.mk)
endif

$(call ti-clear-vars)
