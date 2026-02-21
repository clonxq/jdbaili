#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate
##-----------------Del duplicate packages------------------
rm -rf feeds/packages/net/open-app-filter
##-----------------Manually set CPU frequency for MT7986A-----------------
sed -i '/"mediatek"\/\*|\"mvebu"\/\*/{n; s/.*/\tcpu_freq="2.0GHz" ;;/}' package/emortal/autocore/files/generic/cpuinfo
##-----------------DIY-----------------
rm -rf package/feeds/luci/luci-app-wrtbwmon
rm -rf package/feeds/packages/wrtbwmon
rm -rf ./feeds/packages/net/adguardhome
rm -rf ./feeds/packages/net/mosdns
rm -rf ./feeds/packages/net/alist
# rm -rf ./feeds/packages/net/shadowsocks-libev
# rm -rf ./feeds/packages/net/shadowsocks-rust
# rm -rf ./feeds/packages/net/shadowsocksr-libev
rm -rf ./feeds/luci/applications/luci-app-passwall
rm -rf ./feeds/luci/applications/luci-app-passwall2
# rm -rf ./feeds/packages/net/xray-core/
# rm -rf ./feeds/packages/net/xray-plugin/
rm -rf ./feeds/luci/applications/luci-app-alist
rm -rf ./feeds/luci/applications/luci-app-ssr-plus
rm -rf ./feeds/luci/applications/luci-app-openclash
rm -rf ./feeds/luci/applications/luci-app-wechatpush
rm -rf ./feeds/luci/applications/luci-app-ddns-go
rm -rf ./feeds/luci/applications/luci-app-lucky
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 25.x feeds/packages/lang/golang
