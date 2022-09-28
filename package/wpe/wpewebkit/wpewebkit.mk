################################################################################
#
# WPEWebKit
#
################################################################################

ifeq ($(BR2_PACKAGE_WPEWEBKIT2_22),y)
WPEWEBKIT_VERSION = 2.22
WPEWEBKIT_VERSION_VALUE = c2bbe41520037aa883e6cab9fc40524f6e2e4cd0
endif

ifeq ($(BR2_PACKAGE_WPEWEBKIT2_28),y)
# This is the wpe-2.28-soup3 branch tip.
WPEWEBKIT_VERSION = 2.28
WPEWEBKIT_VERSION_VALUE = fdf2f014629a4b4e93f43cec0be4698aa640b826
endif

ifeq ($(BR2_PACKAGE_WPEWEBKIT2_38),y)
WPEWEBKIT_VERSION = 2.38.0
WPEWEBKIT_SITE = http://www.wpewebkit.org/releases
WPEWEBKIT_SOURCE = wpewebkit-$(WPEWEBKIT_VERSION).tar.xz
else
WPEWEBKIT_SITE = $(call github,WebPlatformForEmbedded,WPEWebKit,$(WPEWEBKIT_VERSION_VALUE))
endif

WPEWEBKIT_INSTALL_STAGING = YES
WPEWEBKIT_LICENSE = LGPL-2.1+, BSD-2-Clause
WPEWEBKIT_LICENSE_FILES = \
	Source/WebCore/LICENSE-APPLE \
	Source/WebCore/LICENSE-LGPL-2.1

WPEWEBKIT_DEPENDENCIES = host-gperf host-ninja host-python host-ruby \
	harfbuzz cairo icu jpeg libepoxy libgcrypt libgles libsoup libtasn1 \
	libpng libxslt openjpeg webp wpebackend

WPEWEBKIT_CONF_OPTS = \
	-GNinja \
	-DPORT=WPE \
	-DCMAKE_EXPORT_COMPILE_COMMANDS=ON

ifeq ($(BR2_PACKAGE_WPEWEBKIT2_22),y)

WPEWEBKIT_CONF_OPTS += \
	-DENABLE_ACCELERATED_2D_CANVAS=ON \
	-DENABLE_DATABASE_PROCESS=OFF \
	-DENABLE_DEVICE_ORIENTATION=OFF \
	-DENABLE_FETCH_API=OFF \
	-DENABLE_FTL_JIT=OFF \
	-DENABLE_FULLSCREEN_API=OFF \
	-DENABLE_GAMEPAD=OFF \
	-DENABLE_GEOLOCATION=OFF \
	-DENABLE_INDEXED_DATABASE=OFF \
	-DENABLE_MATHML=OFF \
	-DENABLE_MEDIA_STATISTICS=OFF \
	-DENABLE_METER_ELEMENT=OFF \
	-DENABLE_NOTIFICATIONS=OFF \
	-DENABLE_SAMPLING_PROFILER=ON \
	-DENABLE_SUBTLE_CRYPTO=OFF \
	-DENABLE_SVG_FONTS=OFF \
	-DENABLE_TOUCH_EVENTS=OFF \
	-DENABLE_WEBASSEMBLY=OFF \
	-DENABLE_WEBDRIVER=ON \
	-DEXPORT_DEPRECATED_WEBKIT2_C_API=ON

WPEWEBKIT_DEPENDENCIES += gstreamer1 gst1-plugins-base \
	gst1-plugins-good gst1-plugins-bad
WPEWEBKIT_CONF_OPTS += \
	-DENABLE_VIDEO=ON \
	-DENABLE_VIDEO_TRACK=ON

ifeq ($(BR2_PACKAGE_WPEWEBKIT_ENABLE_NATIVE_VIDEO),y)
WPEWEBKIT_CONF_OPTS += -DENABLE_NATIVE_VIDEO=ON
else
WPEWEBKIT_CONF_OPTS += -DENABLE_NATIVE_VIDEO=OFF
endif

ifeq ($(BR2_PACKAGE_WPEWEBKIT_ENABLE_NATIVE_AUDIO),y)
WPEWEBKIT_CONF_OPTS += -DENABLE_NATIVE_AUDIO=ON
else
WPEWEBKIT_CONF_OPTS += -DENABLE_NATIVE_AUDIO=OFF
endif

ifeq ($(BR2_PACKAGE_WPEWEBKIT_ENABLE_TEXT_SINK),y)
WPEWEBKIT_CONF_OPTS += -DENABLE_TEXT_SINK=ON
else
WPEWEBKIT_CONF_OPTS += -DENABLE_TEXT_SINK=OFF
endif

ifeq ($(BR2_PACKAGE_WPEWEBKIT_USE_WEB_AUDIO),y)
WPEWEBKIT_CONF_OPTS += -DENABLE_WEB_AUDIO=ON
else
WPEWEBKIT_CONF_OPTS += -DENABLE_WEB_AUDIO=OFF
endif

ifeq ($(BR2_PACKAGE_WPEWEBKIT_ENABLE_MEDIA_SOURCE),y)
WPEWEBKIT_CONF_OPTS += -DENABLE_MEDIA_SOURCE=ON
else
WPEWEBKIT_CONF_OPTS += -DENABLE_MEDIA_SOURCE=OFF
endif

ifeq ($(BR2_PACKAGE_WPEWEBKIT_USE_ENCRYPTED_MEDIA),y)
WPEWEBKIT_CONF_OPTS += -DENABLE_ENCRYPTED_MEDIA=ON
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_CDM),y)
WPEWEBKIT_DEPENDENCIES += wpeframework-clientlibraries
WPEWEBKIT_CONF_OPTS += -DENABLE_OPENCDM=ON
endif

ifeq ($(BR2_PACKAGE_WPEWEBKIT_USE_GSTREAMER_GL),y)
WPEWEBKIT_CONF_OPTS += -DUSE_GSTREAMER_GL=ON
else
WPEWEBKIT_CONF_OPTS += -DUSE_GSTREAMER_GL=OFF
endif

ifeq ($(BR2_PACKAGE_WPEWEBKIT_USE_GSTREAMER_WEBKIT_HTTP_SRC),y)
WPEWEBKIT_CONF_OPTS += -DUSE_GSTREAMER_WEBKIT_HTTP_SRC=ON
else
WPEWEBKIT_CONF_OPTS += -DUSE_GSTREAMER_WEBKIT_HTTP_SRC=OFF
endif

endif

ifeq ($(BR2_PACKAGE_WPEWEBKIT2_28),y)

WPEWEBKIT_CONF_OPTS += \
	-DENABLE_ACCELERATED_2D_CANVAS=ON \
	-DENABLE_ACCESSIBILITY=OFF \
	-DENABLE_API_TESTS=OFF \
	-DENABLE_BUBBLEWRAP_SANDBOX=OFF \
	-DENABLE_MINIBROWSER=OFF \
	-DSILENCE_CROSS_COMPILATION_NOTICES=ON \
	-DUSE_WOFF2=OFF

ifeq ($(BR2_PACKAGE_WPEWEBKIT_MULTIMEDIA),y)
WPEWEBKIT_CONF_OPTS += \
	-DENABLE_ENCRYPTED_MEDIA=ON \
	-DENABLE_MEDIA_SOURCE=ON \
	-DENABLE_MEDIA_STATISTICS=ON \
	-DENABLE_THUNDER=ON \
	-DENABLE_VIDEO=ON \
	-DENABLE_WEB_AUDIO=ON
WPEWEBKIT_DEPENDENCIES += gstreamer1 gst1-plugins-base gst1-plugins-good
else
WPEWEBKIT_CONF_OPTS += \
	-DENABLE_ENCRYPTED_MEDIA=OFF \
	-DENABLE_MEDIA_SOURCE=OFF \
	-DENABLE_THUNDER=OFF \
	-DENABLE_VIDEO=OFF \
	-DENABLE_WEB_AUDIO=OFF
endif

ifeq ($(BR2_PACKAGE_WPEWEBKIT_USE_GSTREAMER_GL),y)
WPEWEBKIT_CONF_OPTS += -DUSE_GSTREAMER_GL=ON
else
WPEWEBKIT_CONF_OPTS += -DUSE_GSTREAMER_GL=OFF
endif

ifeq ($(BR2_PACKAGE_WPEWEBKIT_WEBDRIVER),y)
WPEWEBKIT_CONF_OPTS += -DENABLE_WEBDRIVER=ON
else
WPEWEBKIT_CONF_OPTS += -DENABLE_WEBDRIVER=OFF
endif

endif

ifeq ($(BR2_PACKAGE_WPEWEBKIT_DEBUG)$(BR2_PACKAGE_WPEWEBKIT_SYMBOLS),y)
WPEWEBKIT_SYMBOL_FLAGS = -g
endif

WPEWEBKIT_BUILD_TYPE = Release
WPEWEBKIT_CXXFLAGS = -O2 -DNDEBUG
ifeq ($(BR2_PACKAGE_WPEWEBKIT_DEBUG),y)
WPEWEBKIT_BUILD_TYPE = Debug
WPEWEBKIT_CONF_OPTS += -DCMAKE_BUILD_TYPE=Debug
WPEWEBKIT_CXXFLAGS = -O0
endif

WPEWEBKIT_COMPILER_FLAGS=$(WPEWEBKIT_SYMBOL_FLAGS) $(WPEWEBKIT_CXXFLAGS) -Wno-cast-align
WPEWEBKIT_CONF_OPTS += \
	-DCMAKE_C_FLAGS_RELEASE="$(WPEWEBKIT_COMPILER_FLAGS)" \
	-DCMAKE_CXX_FLAGS_RELEASE="$(WPEWEBKIT_COMPILER_FLAGS)" \
	-DCMAKE_C_FLAGS_DEBUG="$(WPEWEBKIT_COMPILER_FLAGS)" \
	-DCMAKE_CXX_FLAGS_DEBUG="$(WPEWEBKIT_COMPILER_FLAGS)"

ifeq ($(BR2_PACKAGE_WPEWEBKIT_USE_PUNCH_HOLE_GSTREAMER),y)
WPEWEBKIT_CONF_OPTS += -DUSE_HOLE_PUNCH_GSTREAMER=ON -DUSE_GSTREAMER_HOLEPUNCH=ON
else ifeq ($(BR2_PACKAGE_WPEWEBKIT_USE_PUNCH_HOLE_EXTERNAL),y)
WPEWEBKIT_CONF_OPTS += -DUSE_HOLE_PUNCH_EXTERNAL=ON -DUSE_EXTERNAL_HOLEPUNCH=ON
endif

ifeq ($(BR2_PACKAGE_WESTEROS),y)
WPEWEBKIT_DEPENDENCIES += westeros
WPEWEBKIT_CONF_OPTS += -DUSE_WPEWEBKIT_PLATFORM_WESTEROS=ON
ifeq ($(BR2_PACKAGE_WESTEROS_SINK),y)
WPEWEBKIT_DEPENDENCIES += westeros-sink
WPEWEBKIT_CONF_OPTS += \
	-DUSE_GSTREAMER_HOLEPUNCH=ON \
	-DUSE_HOLE_PUNCH_GSTREAMER=ON \
	-DUSE_WESTEROS_SINK=ON
else
WPEWEBKIT_CONF_OPTS += \
	-DUSE_GSTREAMER_HOLEPUNCH=OFF \
	-DUSE_HOLE_PUNCH_GSTREAMER=OFF
endif
else ifeq ($(BR2_PACKAGE_HAS_NEXUS),y)
WPEWEBKIT_CONF_OPTS += -DUSE_WPEWEBKIT_PLATFORM_BCM_NEXUS=ON
else ifeq ($(BR2_PACKAGE_HORIZON_SDK),y)
WPEWEBKIT_CONF_OPTS += -DUSE_WPEWEBKIT_PLATFORM_INTEL_CE=ON
else ifeq ($(BR2_PACKAGE_INTELCE_SDK),y)
WPEWEBKIT_CONF_OPTS += -DUSE_WPEWEBKIT_PLATFORM_INTEL_CE=ON
else ifeq ($(BR2_PACKAGE_RPI_FIRMWARE),y)
WPEWEBKIT_CONF_OPTS += -DUSE_WPEWEBKIT_PLATFORM_RPI=ON
endif

define WPEWEBKIT_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(WPEWEBKIT_NINJA_ENV) \
		$(BR2_CMAKE) --build $(WPEWEBKIT_BUILDDIR) -- $(NINJA_OPTS) $(WPEWEBKIT_NINJA_OPTS)
endef

define WPEWEBKIT_INSTALL_CMDS
	$(TARGET_MAKE_ENV) $(WPEWEBKIT_NINJA_ENV) \
		$(BR2_CMAKE) --install $(WPEWEBKIT_BUILDDIR)
endef

define WPEWEBKIT_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(WPEWEBKIT_NINJA_ENV) DESTDIR=$(STAGING_DIR) \
		$(BR2_CMAKE) --install $(WPEWEBKIT_BUILDDIR)
endef

define WPEWEBKIT_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(WPEWEBKIT_MAKE_ENV) DESTDIR=$(TARGET_DIR) \
		$(BR2_CMAKE) --install $(WPEWEBKIT_BUILDDIR)
endef

$(eval $(cmake-package))
