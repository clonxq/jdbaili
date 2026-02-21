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
rm -rf feeds/packages/net/{xray-core,v2ray-geodata,sing-box,chinadns-ng,dns2socks,hysteria,ipt2socks,microsocks,naiveproxy,shadowsocks-libev,shadowsocks-rust,shadowsocksr-libev,simple-obfs,tcping,trojan-plus,tuic-client,v2ray-plugin,xray-plugin,geoview,shadow-tls}
git clone https://github.com/Openwrt-Passwall/openwrt-passwall-packages package/diy/passwall-packages
rm -rf feeds/luci/applications/luci-app-passwall
git clone https://github.com/Openwrt-Passwall/openwrt-passwall package/diy/passwall-luci

# 自动化清理冲突包 (核心完善版)
function auto_remove_conflicts() {
    local diy_dir="package/diy"
    [ ! -d "$diy_dir" ] && return
    echo ">>> 开始自动扫描 package/diy 并清理 feeds 冲突..."
    for pkg in $(find "$diy_dir" -maxdepth 1 -mindepth 1 -type d -exec basename {} \;); do
        # 在 feeds 全目录搜索同名包并删除
        find feeds/ -type d -name "$pkg" | xargs -r rm -rf
    done
}
auto_remove_conflicts

rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 25.x feeds/packages/lang/golang
