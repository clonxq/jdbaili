#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#
# sed -i 's/KERNEL_PATCHVER:=6.1/KERNEL_PATCHVER:=6.6/g' ./target/linux/x86/Makefile
# sed -i 's/openwrt-23.05/openwrt-25.12/g' feeds.conf.default

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default
function merge_package(){
    repo=`echo $1 | rev | cut -d'/' -f 1 | rev`
    pkg=`echo $2 | rev | cut -d'/' -f 1 | rev`
    # find package/ -follow -name $pkg -not -path "package/custom/*" | xargs -rt rm -rf
    git clone --depth=1 --single-branch $1
    mv $2 package/custom/
    rm -rf $repo
}
function drop_package(){
    find package/ -follow -name $1 -not -path "package/custom/*" | xargs -rt rm -rf
}


# Add a feed source
#echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default
git clone https://github.com/kenzok8/openwrt-packages package/kenzok8-packages
git clone https://github.com/kenzok8/small package/small
git clone https://github.com/sirpdboy/luci-app-advanced.git package/luci-app-advanced
merge_package https://github.com/kiddin9/kwrt-packages kwrt-packages/wrtbwmon
merge_package https://github.com/kiddin9/kwrt-packages kwrt-packages/luci-app-wrtbwmon
