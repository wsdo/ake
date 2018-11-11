#!/bin/bash
rdtool_path=/usr/local/bin/rdtool
if [ ! -w /usr/local/bin ]; then
  echo 为了安装 rdtool，请输入密码 ：
  sudo chown $(whoami) /usr/local/bin
fi
echo 开始下载 Oh My rdtool...
curl -o $rdtool_path https://raw.githubusercontent.com/rdhub-lib/rdtool/master/rdtool.sh
if [ 0 -eq $? ]; then
  chmod 755 $rdtool_path
  echo 成功安装 rdtool，现在可以运行 rdtool 打开微信了
else
  echo 下载 rdtool 时失败，请稍后重试。
  exit 1
fi