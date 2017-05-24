WPEFRAMEWORK_OPEN_VERSION = 55d201c6c0f4d0e82d6eb3cdf3d36bb120e3ee83
WPEFRAMEWORK_OPEN_SITE_METHOD = git
WPEFRAMEWORK_OPEN_SITE = git@github.com:Metrological/webbridge.git
WPEFRAMEWORK_OPEN_INSTALL_STAGING = YES
WPEFRAMEWORK_OPEN_DEPENDENCIES = WPEFramework libpng

WPEFRAMEWORK_OPEN_CONF_OPTS += -DBUILD_REFERENCE=${WPEFRAMEWORK_OPEN_VERSION}

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_DEBUG),y)
# TODO: This recently stopped working, for now pass debug flags explicitly.
#WPEFRAMEWORK_OPEN_CONF_OPTS += -DCMAKE_BUILD_TYPE=Debug
WPEFRAMEWORK_OPEN_CONF_OPTS += -DCMAKE_CXX_FLAGS='-g -Og'
endif

ifeq ($(BR2_PACKAGE_BCM_REFSW),y)
WPEFRAMEWORK_OPEN_DEPENDENCIES = bcm-refsw
endif 

# libprovision

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_OPEN_COMMANDER),y)
WPEFRAMEWORK_OPEN_CONF_OPTS += -DOPEN_PLUGIN_COMMANDER=ON
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_OPEN_DEVICEINFO),y)
WPEFRAMEWORK_OPEN_CONF_OPTS += -DOPEN_PLUGIN_DEVICEINFO=ON
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_OPEN_LOCATIONSYNC),y)
WPEFRAMEWORK_OPEN_CONF_OPTS += -DOPEN_PLUGIN_LOCATIONSYNC=ON
WPEFRAMEWORK_OPEN_CONF_OPTS += -DOPEN_PLUGIN_LOCATIONSYNC_URI=${BR2_PACKAGE_WPEFRAMEWORK_OPEN_LOCATIONSYNC_URI}
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_OPEN_MONITOR),y)
WPEFRAMEWORK_OPEN_CONF_OPTS += -DOPEN_PLUGIN_MONITOR=ON
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_OPEN_REMOTECONTROL),y)
WPEFRAMEWORK_OPEN_CONF_OPTS += -DOPEN_PLUGIN_REMOTECONTROL=ON
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_REMOTECONTROL_PLUGIN_IRNEXUS),y)
WPEFRAMEWORK_OPEN_CONF_OPTS += -DOPEN_PLUGIN_REMOTECONTROL_IRNEXUS=ON
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_REMOTECONTROL_PLUGIN_IRNEXUS_MODE),)
WPEFRAMEWORK_OPEN_CONF_OPTS += -DOPEN_PLUGIN_REMOTECONTROL_IRMODE="$(call qstrip,$(BR2_PACKAGE_WPEFRAMEWORK_REMOTECONTROL_PLUGIN_IRNEXUS_MODE))"
endif
endif
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_OPEN_SNAPSHOT),y)
WPEFRAMEWORK_OPEN_DEPENDENCIES += libpng
WPEFRAMEWORK_OPEN_CONF_OPTS += -DOPEN_PLUGIN_SNAPSHOT=ON
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_OPEN_TIMESYNC),y)
WPEFRAMEWORK_OPEN_CONF_OPTS += -DOPEN_PLUGIN_TIMESYNC=ON
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_OPEN_TRACECONTROL),y)
WPEFRAMEWORK_OPEN_CONF_OPTS += -DOPEN_PLUGIN_TRACECONTROL=ON
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_OPEN_WEBKITBROWSER),y)
WPEFRAMEWORK_OPEN_DEPENDENCIES += wpewebkit 
WPEFRAMEWORK_OPEN_CONF_OPTS += -DOPEN_PLUGIN_WEBKITBROWSER=ON
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_OPEN_WEBKITBROWSER_AUTOSTART),y)
WPEFRAMEWORK_OPEN_CONF_OPTS += -DOPEN_PLUGIN_WEBKITBROWSER_AUTOSTART=true
else
WPEFRAMEWORK_OPEN_CONF_OPTS += -DOPEN_PLUGIN_WEBKITBROWSER_AUTOSTART=false
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_OPEN_WEBKITBROWSER_STARTURL),)
WPEFRAMEWORK_OPEN_CONF_OPTS += -DOPEN_PLUGIN_WEBKITBROWSER_STARTURL=$(BR2_PACKAGE_WPEFRAMEWORK_PLUGIN_WEBKITBROWSER_STARTURL)
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_OPEN_WEBKITBROWSER_USERAGENT),)
WPEFRAMEWORK_OPEN_CONF_OPTS += -DOPEN_PLUGIN_WEBKITBROWSER_USERAGENT=$(BR2_PACKAGE_WPEFRAMEWORK_PLUGIN_WEBKITBROWSER_USERAGENT)
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_OPEN_WEBKITBROWSER_MEMORYPROFILE),)
WPEFRAMEWORK_OPEN_CONF_OPTS += -DOPEN_PLUGIN_WEBKITBROWSER_MEMORYPROFILE=$(BR2_PACKAGE_WPEFRAMEWORK_PLUGIN_WEBKITBROWSER_MEMORYPROFILE)
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_OPEN_WEBKITBROWSER_MEMORYPRESSURE),)
WPEFRAMEWORK_OPEN_CONF_OPTS += -DOPEN_PLUGIN_WEBKITBROWSER_MEMORYPRESSURE=$(BR2_PACKAGE_WPEFRAMEWORK_PLUGIN_WEBKITBROWSER_MEMORYPRESSURE)
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_OPEN_WEBKITBROWSER_MEDIADISKCACHE),y)
WPEFRAMEWORK_OPEN_CONF_OPTS += -DOPEN_PLUGIN_WEBKITBROWSER_MEDIADISKCACHE=true
endif
ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_OPEN_WEBKITBROWSER_DISKCACHE),)
WPEFRAMEWORK_OPEN_CONF_OPTS += -DOPEN_PLUGIN_WEBKITBROWSER_DISKCACHE=$(BR2_PACKAGE_WPEFRAMEWORK_PLUGIN_WEBKITBROWSER_DISKCACHE)
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_OPEN_WEBKITBROWSER_XHRCACHE),)
WPEFRAMEWORK_OPEN_CONF_OPTS += -DOPEN_PLUGIN_WEBKITBROWSER_XHRCACHE=false
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_OPEN_WEBKITBROWSER_TRANSPARENT),y)
WPEFRAMEWORK_OPEN_CONF_OPTS += -DOPEN_PLUGIN_WEBKITBROWSER_TRANSPARENT=true
else
WPEFRAMEWORK_OPEN_CONF_OPTS += -DOPEN_PLUGIN_WEBKITBROWSER_TRANSPARENT=false
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_OPEN_YOUTUBE),y)
WPEFRAMEWORK_OPEN_CONF_OPTS += -DOPEN_PLUGIN_WEBKITBROWSER_YOUTUBE=ON
endif
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_OPEN_WEBPROXY),y)
WPEFRAMEWORK_OPEN_CONF_OPTS += -DOPEN_PLUGIN_WEBPROXY=ON
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_OPEN_WEBSERVER),y)
WPEFRAMEWORK_OPEN_CONF_OPTS += -DOPEN_PLUGIN_WEBSERVER=ON
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_OPEN_WEBSHELL),y)
WPEFRAMEWORK_OPEN_CONF_OPTS += -DOPEN_PLUGIN_WEBSHELL=ON
endif

$(eval $(cmake-package))

