include $(TOPDIR)/rules.mk
PKG_NAME:=xray-common
PKG_VERSION:=1.0.0
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
include $(INCLUDE_DIR)/package.mk

define Package/xray-common
	CATEGORY:=net
	TITLE:=XRay-Common
	PKGARCH:=all
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR) ./files/usr/share/xray
	wget -O ./files/usr/share/xray/geoip.dat https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat
	wget -O ./files/usr/share/xray/geosite.dat https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat
	$(CP) ./files/* $(PKG_BUILD_DIR)/
endef

define Package/xray/install
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/etc/xray/config.json $(1)/etc
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/etc/config/xray $(1)/etc/config
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/etc/init.d/xray $(1)/etc/init.d
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/usr/bin/v2ray-rules $(1)/usr/bin
	$(INSTALL_DIR) $(1)/usr/share/xray
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/usr/share/xray/geoip.dat $(1)/usr/share/xray
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/usr/share/xray/geosite.dat $(1)/usr/share/xray
endef

$(eval $(call BuildPackage,xray-common))
