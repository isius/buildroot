################################################################################
#
# wpebackend-rdk
#
################################################################################

WPEBACKEND_RDK_VERSION = 6083f2b58f6a6e43ed4d51b1489b4d55425bda29
WPEBACKEND_RDK_SITE = $(call github,WebPlatformForEmbedded,WPEBackend-rdk,$(WPEBACKEND_RDK_VERSION))
WPEBACKEND_RDK_INSTALL_STAGING = YES
WPEBACKEND_RDK_DEPENDENCIES = wpebackend libglib2

WPEBACKEND_RDK_FLAGS = 

ifeq ($(BR2_PACKAGE_LIBXKBCOMMON),y)
WPEBACKEND_RDK_DEPENDENCIES += libxkbcommon xkeyboard-config
endif


ifeq ($(BR2_PACKAGE_WPEBACKEND_RDK_BACK_BCM_NEXUS),y)
WPEBACKEND_RDK_DEPENDENCIES += nexus
WPEBACKEND_RDK_CONF_OPTS += -DUSE_BACKEND_BCM_NEXUS=ON
else
WPEBACKEND_RDK_CONF_OPTS += -DUSE_BACKEND_BCM_NEXUS=OFF
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_VIRTUALINPUT),y)
WPEBACKEND_RDK_DEPENDENCIES += wpeframework
WPEBACKEND_RDK_FLAGS += -DUSE_VIRTUAL_KEYBOARD=ON
endif

ifeq ($(BR2_PACKAGE_WPEBACKEND_RDK_BACK_WESTEROS),y)
WPEBACKEND_RDK_DEPENDENCIES += westeros
WPEBACKEND_RDK_CONF_OPTS += -DUSE_BACKEND_WESTEROS=ON
else
WPEBACKEND_RDK_DEPENDENCIES += libegl
WPEBACKEND_RDK_FLAGS += -DUSE_BACKEND_BCM_RPI=ON
endif

# USE_BACKEND_BCM_NEXUS_WAYLAND or USE_BACKEND_BCM_NEXUS
else ifeq ($(BR2_PACKAGE_HAS_NEXUS),y)

ifeq ($(BR2_PACKAGE_BCM_WESTON),y)
	WPEBACKEND_RDK_DEPENDENCIES += bcm-weston
	WPEBACKEND_RDK_FLAGS += -DUSE_BACKEND_BCM_NEXUS_WAYLAND=ON
else ifeq ($(BR2_PACKAGE_WAYLAND)$(BR2_PACKAGE_WESTEROS)$(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITORCLIENT),yyn)
	WPEBACKEND_RDK_DEPENDENCIES += wayland westeros
	WPEBACKEND_RDK_FLAGS +=-DUSE_BACKEND_WESTEROS=ON -DUSE_HOLE_PUNCH_GSTREAMER=OFF -DUSE_WESTEROS_SINK=OFF
else ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITORCLIENT),y)
    WPEBACKEND_RDK_DEPENDENCIES += wpeframework wpeframework-plugins wpeframework-clientlibraries
    WPEBACKEND_RDK_FLAGS +=-DUSE_BACKEND_WPEFRAMEWORK=ON -DUSE_HOLE_PUNCH_GSTREAMER=OFF -DUSE_VIRTUAL_KEYBOARD=OFF -DUSE_INPUT_LIBINPUT=OFF

    ifeq ($(BR2_PACKAGE_WAYLAND)$(BR2_PACKAGE_WESTEROS),yy)
       WPEBACKEND_RDK_DEPENDENCIES += wayland westeros wayland-egl-bnxs 
    endif
else
    WPEBACKEND_RDK_FLAGS += -DUSE_BACKEND_BCM_NEXUS=ON 
    ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_VIRTUALINPUT),y)
        WPEBACKEND_RDK_FLAGS += -DUSE_INPUT_LIBINPUT=OFF
    else
        WPEBACKEND_RDK_FLAGS += -DUSE_INPUT_LIBINPUT=ON
    endif
endif

# USE_BACKEND_WAYLAND_EGL
else ifeq ($(BR2_PACKAGE_KYLIN_GRAPHICS),y)
WPEBACKEND_RDK_FLAGS += -DUSE_BACKEND_WAYLAND_EGL=ON

# USE_BACKEND_INTEL_CE
else ifeq ($(BR2_PACKAGE_HORIZON_SDK)$(BR2_PACKAGE_INTELCE_SDK),y)
WPEBACKEND_RDK_FLAGS += -DUSE_BACKEND_INTEL_CE=ON

else ifeq ($(BR2_PACKAGE_ACN_SDK)$(BR2_PACKAGE_UMA_SDK),y)
    WPEBACKEND_RDK_FLAGS += -DUSE_BACKEND_BCM_NEXUS=ON
endif

ifeq ($(BR2_PACKAGE_VSS_SDK),y)
    WPEBACKEND_RDK_FLAGS += -DNEXUS_CLIENT_MODE=ON \
                            -DUSE_BACKEND_BCM_NEXUS=ON
endif

endif

ifeq ($(BR2_PACKAGE_WPEBACKEND_RDK_ADDITIONAL_PATCHES)x,yx)
WPEBACKEND_RDK_POST_PATCH_HOOKS += WPEBACKEND_RDK_PATCHES
define WPEBACKEND_RDK_PATCHES
	patch -d $(@D)/ -p1 < package/wpe/wpebackend-rdk/0001-restore-communication-loop.patch.additional
endef
endif

WPEBACKEND_RDK_CONF_OPTS = \
	$(WPEBACKEND_RDK_FLAGS)

$(eval $(cmake-package))
