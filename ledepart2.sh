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

#修改默认IP地址
sed -i 's/192\.168\.[0-9]*\.1/192.168.5.1/g' package/base-files/files/bin/config_generate
##-----------------Del duplicate packages------------------
rm -rf ./feeds/packages/net/adguardhome
rm -rf ./feeds/packages/net/lucky
rm -rf ./feeds/packages/net/mosdns
rm -rf ./feeds/packages/net/nikki
rm -rf ./package/kenzok8-packages/smartdns
rm -rf ./package/kenzok8-packages/luci-app-smartdns
rm -rf ./package/kenzok8-packages/adguardhome
rm -rf ./package/kenzok8-packages/luci-app-adguardhome
rm -rf ./feeds/luci/applications/luci-app-adguardhome
rm -rf ./feeds/luci/applications/luci-app-dockerman
rm -rf ./feeds/luci/applications/luci-app-homeproxy
rm -rf ./feeds/luci/applications/luci-app-lucky
rm -rf ./feeds/luci/applications/luci-app-mosdns
rm -rf ./feeds/luci/applications/luci-app-nikki
rm -rf ./feeds/luci/applications/luci-app-passwall
rm -rf ./feeds/luci/applications/luci-app-passwall2
rm -rf ./feeds/luci/applications/luci-app-openclash
rm -rf ./feeds/luci/applications/luci-app-ssr-plus
##-----------------DIY-----------------

# 下载并替换
curl -sL -o target/linux/mediatek/dts/mt7986a-jdcloud-re-cs-05.dts https://raw.githubusercontent.com/clonxq/jdbaili/refs/heads/main/patch/mt7986a-jdcloud-re-cs-05.dts
