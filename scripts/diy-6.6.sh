#!/bin/bash
set -e -o pipefail

WORKSPACE_ROOT="${GITHUB_WORKSPACE:-$(pwd)}"
GOLANG127_SRC_DIR="$WORKSPACE_ROOT/scripts/6.6/golang1.27"
GOLANG127_FEED_DIR="feeds/packages/lang/golang1.27"
rm -rf "$GOLANG127_FEED_DIR"
mkdir -p "$GOLANG127_FEED_DIR"
cp -rf "$GOLANG127_SRC_DIR/." "$GOLANG127_FEED_DIR/"
./scripts/feeds update -f packages
./scripts/feeds install golang1.27

# passwall daed use golang1.27/host
find package/dae package/passwall-packages -name "Makefile" -type f -exec sed -i \
  -e 's|\<golang/golang-package.mk\>|golang1.27/golang-package.mk|g' \
  -e 's|\<golang/host\>|golang1.27/host|g' {} +

# 同步仓库内维护的 patches 目录到 OpenWrt 源码树
if [ -d "$GITHUB_WORKSPACE/patches/6.6" ]; then
  echo "[diy] 同步自定义 patches/6.6 目录到源码树"
  cp -rf "$GITHUB_WORKSPACE/patches/6.6/." ./
else
  echo "[diy] patches/6.6 目录不存在，跳过"
fi
