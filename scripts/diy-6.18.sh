#!/bin/bash
set -e -o pipefail

# 同步仓库内维护的 patches 目录到 OpenWrt 源码树
if [ -d "$GITHUB_WORKSPACE/patches/6.18" ]; then
  echo "[diy] 同步自定义 patches/6.18 目录到源码树"
  cp -rf "$GITHUB_WORKSPACE/patches/6.18/." ./
else
  echo "[diy] patches/6.18 目录不存在，跳过"
fi
