#!/bin/bash

# Check if a directory argument is passed
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

docker pull crazywty/morph-docker-morph:latest

docker run -d --name morph \
   -v "${DATA_DIR}:/data" \
   -p 8545:8545 \
   -p 8551:8551 \
   -p 26658:26658 \
   -p 26657:26657 \
   -p 26656:26656 \
   -p 26660:26660 \
   -e TZ=UTC \
   crazywty/morph-docker-morph