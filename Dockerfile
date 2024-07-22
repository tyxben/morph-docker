# 使用官方的 Golang 运行时作为基础镜像
FROM golang:1.21

# 设置工作目录
WORKDIR /morph_t

ENV GONOSUMDB=*
# 安装必要的软件包
RUN apt-get update && apt-get install -y \
    build-essential \
    openssl \
    wget \
    unzip \
    git

# 克隆 Morph 仓库
RUN git clone https://github.com/morph-l2/morph.git 

# 检出特定的 beta 版本
RUN cd morph && git checkout v0.1.0-beta

# 编译必要的组件
RUN cd morph && make nccc_geth
RUN cd morph/node && make build

# 复制入口脚本
RUN mkdir -p /usr/local/app/
COPY entrypoint.sh /usr/local/app/

RUN chmod +x /usr/local/app/entrypoint.sh

# 暴露端口
EXPOSE 8545 8546 8551 26657 30303 30303/udp

# 定义入口脚本
ENTRYPOINT ["/usr/local/app/entrypoint.sh"]