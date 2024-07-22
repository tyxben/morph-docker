
# Morph Node Docker 使用说明文档

## Linux/Mac

1. 运行新节点

    ```sh
    sh start_new_node.sh
    ```

    - **注意**：start_new_node.sh` 会删除本地节点数据。请自行备份 `jwt-secret.txt`和相关数据。

2. 修改 `docker-compose` 文件中的映射目录。将 `start_new_node.sh` 中的 `DATA_DIR=./data` 目录修改为您自己的目录。

    ```yaml
    version: '3.8'
    services:
      morph:
        build: .
        container_name: morph
        volumes:
          - [你自己的目录]:/data
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

## Windows

1. 提前准备：需要下载 `openssl`、`dos2unix`、`unzip` 和 `wget`

    ```powershell
    choco install openssl
    choco install dos2unix
    choco install unzip
    choco install wget
    ```

2. 打开 PowerShell

3. 切换目录到 `morph-docker` 的目录下。

4. 运行 ` .\start_new_node_win.ps1 -DATA_DIR "J:\data" ` 并将 `$DATA_DIR "` 字段更换为自己的目录。

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

## docker image
   windows 执行 start_docker_image_win.ps1
   mac/linus 执行 start_docker_image_unix.ps1  

## restart
    docker-image version
    windows/linux/mac
    1. 直接拉去镜像的版本可以通过 `docker restart morph`命令重启
    2. 或者直接通过图形化界面重启
    local 编译 version
    windows
    1. 
## 脚本说明

- `start_new_node.sh`和`start_new_node_win.ps1`：用于启动新节点。请注意，此脚本会删除现有的本地节点数据。

## 备份注意事项

- 在运行 `start_new_node.sh`和`start_new_node_win.ps1` 之前，请确保备份重要的配置文件，例如 `jwt-secret.txt`。

