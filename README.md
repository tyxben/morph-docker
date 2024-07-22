# Morph Node Docker 使用说明文档

[TOC]



## Linux/Mac

### 运行新节点

1. 启动新节点：

   ```sh
   sh start_new_node.sh /path/to/data_directory
   ```

   - **/path/to/data_directory** 需要替换成自己的目录
   - **注意**：`start_new_node.sh` 会删除本地节点数据。请先备份 `jwt-secret.txt` 和相关数据。

2. 修改 `docker-compose` 文件中的映射目录。目录修改为您自己的目录，设置的目录需要一致。

   ```yaml
   version: '3.8'
   services:
     morph:
       build: .
       container_name: morph
       volumes:
         - /path/to/data_directory:/data   # 替换为自己的目录
       ports:
         - "8545:8545"
         - "8551:8551"
         - "26658:26658"
         - "26657:26657"
         - "26656:26656"
         - "26660:26660"
       environment:
         - TZ=UTC
   ```
3. 重启
    进入到当前目录 执行 `docker-compose up`

## Windows

### 准备工作

1. 安装必要工具：

   ```powershell
   choco install openssl
   choco install dos2unix
   choco install unzip
   choco install wget
   ```

2. 打开 PowerShell

3. 切换到 `morph-docker` 目录。

4. 运行以下命令启动新节点，并将 `DATA_DIR` 更换为您的目录：

   ```powershell
   .\start_new_node_win.ps1 -DATA_DIR "J:\data"
   ```

5. 修改 `docker-compose` 文件中的 `volumes`，将 `[自己的目录]:/data` 修改为您的目录，例如 `J:\data:/data`。

   ```yaml
   version: '3.0'
   services:
     morph:
       build: .
       container_name: morph
       volumes:
         - J:\data:/data
       ports:
         - "8545:8545"
         - "8551:8551"
         - "26658:26658"
         - "26657:26657"
         - "26656:26656"
         - "26660:26660"
       environment:
         - TZ=UTC
   ```
3. 重启
    进入到当前目录 执行 `docker-compose up`

## Docker Image

- Windows: 执行 `.\start_docker_image_win.ps1 -DATA_DIR "J:\data"`
  - 替换**"J:\data"** 为本地目录
- Mac/Linux: 执行 `sh start_docker_image_unix.sh /path/to/data_directory`
  - 替换**/path/to/data_directory** 为本地目录

## 重启

对于使用 Docker 镜像版本的节点：

1. 可以通过以下命令重启：

   ```sh
   docker restart morph
   ```

2. 或者通过 Docker 图形化界面进行重启。

## 脚本说明

- `start_new_node.sh` 和 `start_new_node_win.ps1`：用于启动新节点。请注意，此脚本会删除现有的本地节点数据。

## 备份注意事项

- 在运行 `start_new_node.sh` 和 `start_new_node_win.ps1` 之前，请确保备份重要的配置文件，例如 `jwt-secret.txt`。
