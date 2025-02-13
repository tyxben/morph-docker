#!/bin/bash


 # 设置变量
if [ $# -eq 0 ]; then
  echo "Error: No directory argument provided."
  echo "Usage: $0 <data_directory>"
  exit 1
fi

# Use the provided directory argument
DATA_DIR=$1

# 保存当前目录
CURRENT_DIR=$(pwd)

DATA_ZIP_URL="https://raw.githubusercontent.com/morph-l2/config-template/main/holesky/data.zip"

# 删除旧的数据目录
if [ -d "$DATA_DIR" ]; then
  echo "删除旧的数据目录：$DATA_DIR"
  rm -rf "$DATA_DIR"
fi

# 创建新的数据目录
echo "创建新的数据目录：$DATA_DIR"
mkdir -p "$DATA_DIR"

# 下载并解压数据
cd "$DATA_DIR"
echo "下载数据文件：$DATA_ZIP_URL"
wget "$DATA_ZIP_URL"

echo "解压数据文件"
unzip data.zip
# rand -hex 32 生成一个 32 字节的随机十六进制字符串
openssl rand -hex 32 > jwt-secret.txt

# 切回原始目录
cd "$CURRENT_DIR"

# 构建 Docker 镜像
echo "构建 Docker 镜像"
docker-compose build

# 启动 Docker 容器
echo "启动 Docker 容器"
docker-compose up 

echo "所有步骤完成。服务正在后台运行。"