################################################################################
#
# AVN_CLIENT
#
################################################################################

AVN_CLIENT_VERSION = 67dfdb99668cca7242cfd2f02b16bab97ec937bd
AVN_CLIENT_SITE_METHOD = git
AVN_CLIENT_SITE = git@github.com:Metrological/avn-nanoclient.git
AVN_CLIENT_INSTALL_STAGING = YES
AVN_CLIENT_DEPENDENCIES = gstreamer1 gst1-plugins-base \
	gst1-plugins-good gst1-plugins-bad 

export SYSROOTPATH=$(STAGING_DIR)

AVN_CLIENT_MAKE_OPTS = ARCH=$(BR2_ARCH) CC="$(TARGET_CC)" CXX="$(TARGET_CXX)"

define AVN_CLIENT_INSTALL_IMAGE
	cp -a $(@D)/output/linux/release/bin/mclient $(TARGET_DIR)/usr/bin
endef

define AVN_CLIENT_BUILD_CMDS
    	$(MAKE) -C $(@D) clean
    	$(MAKE) -C $(@D) $(AVN_CLIENT_MAKE_OPTS) 
endef

define AVN_CLIENT_INSTALL_TARGET_CMDS
    	$(call AVN_CLIENT_INSTALL_IMAGE)
endef

$(eval $(generic-package))
