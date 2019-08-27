#!/bin/bash
ake_path=/usr/local/bin/ake
if [ ! -w /usr/local/bin ]; then
  echo 为了安装 ake，请输入密码 ：
  sudo chown $(whoami) /usr/local/bin
fi
echo 开始下载 Oh My ake...
curl -o $ake_path https://raw.githubusercontent.com/wsdo/ake/master/ake.sh
if [ 0 -eq $? ]; then
  chmod 755 $ake_path
  echo 成功安装 ake，现在可以愉快的使用 ake
else
  echo 下载 ake 时失败，请稍后重试。
  exit 1
fi
