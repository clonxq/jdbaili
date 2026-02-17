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

# --- 定义通用局部拉取函数 ---
function extract_pkg() {
    local repo_url=$1
    local repo_path=$2
    local local_path=$3
    local branch=${4:-""}
    local tmp_dir="tmp_extract_$(date +%s)"

    echo ">>> 正在提取: $repo_path (分支: ${branch:-默认})"
    local clone_args="--depth 1 --filter=blob:none --sparse"
    [ -n "$branch" ] && clone_args="$clone_args -b $branch"

    git clone $clone_args "$repo_url" "$tmp_dir"
    if [ $? -eq 0 ]; then
        cd "$tmp_dir" || return
        git sparse-checkout set "$repo_path"
        cd ..
        mkdir -p "$(dirname "$local_path")"
        [ -d "$local_path" ] && rm -rf "$local_path"
        if [ -d "$tmp_dir/$repo_path" ]; then
            cp -r "$tmp_dir/$repo_path" "$local_path"
            echo ">>> 成功保存至: $local_path"
        fi
        rm -rf "$tmp_dir"
    fi
}


# --- 插件拉取列表 (全部存放至 package/diy) ---
mkdir -p package/diy

extract_pkg "https://github.com/nikkinikki-org/OpenWrt-nikki.git" "luci-app-nikki" "package/diy/luci-app-nikki"
extract_pkg "https://github.com/nikkinikki-org/OpenWrt-nikki.git" "nikki" "package/diy/nikki"

git clone -b js github.com/0x676e67/luci-theme-design.git package/diy/luci-theme-design
# git clone https://github.com/sirpdboy/luci-app-lucky.git package/diy/lucky
git clone https://github.com/sirpdboy/luci-app-advanced.git package/diy/luci-app-advanced
# git clone https://github.com/KFERMercer/luci-app-tcpdump.git package/diy/luci-app-tcpdump
find ./ | grep Makefile | grep v2ray-geodata | xargs rm -f
find ./ | grep Makefile | grep mosdns | xargs rm -f
git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/diy/mosdns
git clone https://github.com/sbwml/v2ray-geodata package/diy/v2ray-geodata
git clone https://github.com/w9315273/luci-app-adguardhome package/luci-app-adguardhome
extract_pkg "https://github.com/kenzok8/openwrt-packages" "adguardhome" "package/adguardhome"

