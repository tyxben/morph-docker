#!/bin/bash

# 设置数据目录变量
GETH_DATA_DIR=/data/geth-data
NODE_DATA_DIR=/data/node-data
JWT_SECRET_FILE=/data/jwt-secret.txt

# 检查共享密钥文件是否存在
if [ ! -f "$JWT_SECRET_FILE" ]; then
  echo "共享密钥文件不存在：$JWT_SECRET_FILE"
  exit 1
fi

# 创建数据目录
mkdir -p $GETH_DATA_DIR $NODE_DATA_DIR

# 启动 Geth
/morph_t/morph/go-ethereum/build/bin/geth --morph-holesky \
    --datadir "$GETH_DATA_DIR" \
    --http.api="web3,debug,eth,txpool,net,engine" \
    --authrpc.addr="localhost" \
    --authrpc.vhosts="localhost" \
    --authrpc.port="8551" \
    --authrpc.jwtsecret="$JWT_SECRET_FILE" \
    --miner.gasprice="1000000000" \
    --log.filename="$GETH_DATA_DIR/geth.log" &

# 启动 Morph Node
/morph_t/morph/node/build/bin/morphnode --home $NODE_DATA_DIR \
    --l2.jwt-secret $JWT_SECRET_FILE \
    --l2.eth http://localhost:8545 \
    --l2.engine http://localhost:8551 \
    --log.filename $NODE_DATA_DIR/node.log
