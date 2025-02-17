################################################################################
#
# wpeframework-cdmi-playready
#
################################################################################

ifeq ($(BR2_PACKAGE_PLAYREADY4),y)
WPEFRAMEWORK_CDMI_PLAYREADY_VERSION = bf177dadf75fbf7783f9fe3717796772860b361a
else
WPEFRAMEWORK_CDMI_PLAYREADY_VERSION = 59b3deba0710b9f372fd333fcc7aca2ebed483a6
endif

WPEFRAMEWORK_CDMI_PLAYREADY_SITE = $(call github,rdkcentral,OCDM-Playready,$(WPEFRAMEWORK_CDMI_PLAYREADY_VERSION))
WPEFRAMEWORK_CDMI_PLAYREADY_INSTALL_STAGING = YES
WPEFRAMEWORK_CDMI_PLAYREADY_DEPENDENCIES = wpeframework-clientlibraries
WPEFRAMEWORK_CDMI_PLAYREADY_CONF_OPTS = -DPERSISTENT_PATH=${BR2_PACKAGE_WPEFRAMEWORK_PERSISTENT_PATH}

ifeq ($(BR2_PACKAGE_PLAYREADY4),y)
WPEFRAMEWORK_CDMI_PLAYREADY_DEPENDENCIES += playready4
WPEFRAMEWORK_CDMI_PLAYREADY_CONF_OPTS += -DNETFLIX_EXTENSION=OFF
else
WPEFRAMEWORK_CDMI_PLAYREADY_DEPENDENCIES += playready
WPEFRAMEWORK_CDMI_PLAYREADY_CONF_OPTS += -DNETFLIX_EXTENSION=ON
endif

$(eval $(cmake-package))
