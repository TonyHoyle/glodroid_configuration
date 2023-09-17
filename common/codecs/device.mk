# SPDX-License-Identifier: Apache-2.0
#
# GloDroid project (https://github.com/GloDroid)
#
# Copyright (C) 2022 Roman Stratiienko (r.stratiienko@gmail.com)

PRODUCT_SOONG_NAMESPACES += glodroid/vendor/v4l2_codec2

PRODUCT_PACKAGES += \
    android.hardware.media.c2@1.0-service \

PRODUCT_PACKAGES += \
    android.hardware.media.c2@1.2-service-ffmpeg \
    android.hardware.media.c2@1.2-service-ffmpeg.rc \
    android.hardware.media.c2@1.2-service-ffmpeg.xml \
    media_codecs_ffmpeg_c2.xml \

# Create input surface on the framework side
PRODUCT_VENDOR_PROPERTIES += \
    debug.stagefright.c2inputsurface=-1 \

GD_MEDIACODECS_FILE ?= $(LOCAL_PATH)/media_codecs.xml

# Copy media codecs config file
PRODUCT_COPY_FILES += \
    $(GD_MEDIACODECS_FILE):$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_c2_video.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_c2_video.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_c2_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_c2_audio.xml \
    $(LOCAL_PATH)/media_profiles_V1_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_V1_0.xml \
    $(LOCAL_PATH)/media_codecs_v4l2_c2.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_v4l2_c2.xml \

# Vendor seccomp policy files:
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/mediaswcodec.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/mediaswcodec.policy \
    $(LOCAL_PATH)/mediacodec.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/mediacodec.policy \

# Codec2.0 poolMask:
#   ION(16)
#   GRALLOC(17)
#   GRALLOC/BUFFERQUEUE(18)
#   GRALLOC/BLOB(19)
#   V4L2_BUFFERQUEUE(20)
#   V4L2_BUFFERPOOL(21)
#   SECURE_LINEAR(22)
#   SECURE_GRAPHIC(23)
# For HW codecs we need GRALLOC/BQ + GRALLOC/BLOB.
# When all are selected, it looks like the correct ones are used.
PRODUCT_VENDOR_PROPERTIES += \
    debug.stagefright.c2-poolmask=0xffffff \

# V4L2 codec2
PRODUCT_PACKAGES += \
    android.hardware.media.c2@1.0-service-v4l2 \
    libv4l2_codec2_vendor_allocator            \
    libc2plugin_store                          \

PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.v4l2_codec2.decode_concurrent_instances=8 \
    ro.vendor.v4l2_codec2.encode_concurrent_instances=8 \
