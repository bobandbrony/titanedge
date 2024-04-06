# 前提

本脚本只在乌班图（ubuntu 22.10）系统上用过，Debian和Centos理论上也可以运行，其他系统尚不清楚

对于设置资源空间大小，仍在研究中，目前只能使用默认的资源空间大小（2G）

如果遇到问题，欢迎在issues提出反馈

## 第一步，安装docker

1.使用以下命令下载 Docker 的安装脚本：

```
curl -fsSL https://get.docker.com -o get-docker.sh
```

这条命令会从 Docker 的官方网站下载一个名为 `get-docker.sh` 的安装脚本到你的当前目录。

2. 执行下载的脚本来安装 Docker：

```
sudo sh get-docker.sh
```

这条命令会以管理员权限运行脚本，脚本会自动完成 Docker 的安装和配置过程。

3. （可选，这一步可以忽略）如果你想在不使用 `sudo` 的情况下运行 Docker 命令，可以将你的用户添加到 `docker` 组中：

```
sudo usermod -aG docker ${USER}
```

完成这步操作后，你可能需要注销并重新登录，或者重启你的系统来使改动生效。

4. 安装完成后，你可以运行以下命令来验证 Docker 是否安装成功并正在运行：

```
docker version
```

如果安装成功，这条命令会显示 Docker 的版本信息。

## 第二步，下载脚本

```
wget https://raw.githubusercontent.com/bobandbrony/titanedge/main/run.sh
```

输出是这样的（最后几行）

```
Saving to: ‘run.sh’
run.sh                       100%[==============================================>]   1.73K  --.-KB/s    in 0s

2024-04-06 11:43:42 (12.0 MB/s) - ‘run.sh’ saved [1769/1769]
```

## 第三步，使用脚本

给脚本执行权限

```
chmod +x run.sh
```

运行脚本

```
./run.sh
```

之后根据提示输入对应信息
