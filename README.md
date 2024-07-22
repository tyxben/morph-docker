# morph-node-docker

## linux/mac
    - sh start_new_node.sh

    - note : 如果程序重启请使用restart.sh, start_new_node.sh会删除本地节点数据。请自行备份jwt-secret.txt
    
    - docker-composer中映射目录需要自行更改，start_new_node 中的 DATA_DIR=./data 的目录请自行更改为自己的目录
    ```
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

## windows
    提前准备：需要下载openssl dos2unix unzip wget
    choro install openssl
    choro install dos2unix
    choro install unzip
    choro install wget
   打开powershell 
    start_new_node_win.ps1.也需要$DATA_DIR = "J:\data" 字段更换为自己的目录
    切换目录到morph-daocker的目录下
    更换docker-compose.volumes [自己的目录]:/data
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
    
