# ancloud

## 工作计划

| 项目 | 任务          | 问题                 | 时间 | 人员   |
| ---- | ------------- | -------------------- | ---- | ------ |
| 后端 | anbox源码研究 | ~~编译&运行&原理~~   |      | 刘楚门 |
|      |               | ~~LXC学习&使用~~     |      |        |
|      |               | SDL2学习&使用        |      |        |
|      |               | 用LXC启动Android镜像 |      |        |
|      |               | 采集视频流           |      |        |
|      |               | 中转触控事件         |      |        |
|      |               | ~~iptables学习&使用~~ |      |        |
| |  | ~~anbox-container-manager原理~~ | | |
| | | anbox-session-manager原理 | | |
| | | dbus学习&使用 | | |
| | | protobuf学习&使用 | | |
| | | android镜像编译 | | |
| 前端 |    webrtc学习  |                |      |     周兴邦   |
|      |               | 本地视频播放示例页面  |   2021.10.24   |        |
|      |               |  webrtc 实现云播放   |      |        |
|      |               |  串流播放            |      |        |
|      |               |  推流学习            |      |        |
|      |               |  前后端交互          |      |        |
|      |               |  远程链接            |      |        |
|      |               |  app开发             |      |        |

## anbox运行原理

- 采用Linux kernel 5.4，在配置中添加binderfs文件系统支持，在文件`kernel/kallsyms.c`中添加`EXPORT_SYMBOL(kallsyms_lookup_name)`导出符号。
- 编译并加载驱动：`binder`，`ashmem`

## container-manager运行原理

- 关闭SELinux`setenforce 0`
- 创建虚拟网桥`ip link add dev ancloud type bridge`
- 设置虚拟网桥地址` ip addr add 192.168.240.1/24 dev ancloud`
- 启用`ip link set dev ancloud up`
- 启用IP转发`echo 1 > /proc/sys/net/ipv4/ip_forward`
- 设置虚拟网络NAT👇
- `iptables -t nat -A POSTROUTING -s 192.168.240.0/24 ! -d 192.168.240.0/24 -j MASQUERADE`
- `iptables -I INPUT -i ancloud -p udp --dport 67 -j ACCEPT`
- `iptables -I INPUT -i ancloud -p tcp --dport 67 -j ACCEPT`
- `iptables -I INPUT -i ancloud -p udp --dport 53 -j ACCEPT`
- `iptables -I INPUT -i ancloud -p tcp --dport 53 -j ACCEPT`
- `iptables -I FORWARD -i ancloud -j ACCEPT`
- `iptables -I FORWARD -o ancloud -j ACCEPT`
- `iptables -t mangle -A POSTROUTING -o ancloud -p udp -m udp --dport 68 -j CHECKSUM --checksum-fill`
- 创建binderfs文件系统目录`mkdir /path/to/binderfs && mount -t binder none /path/to/binderfs`
- 创建数据目录`mkdir /path/to/common`
- 创建根目录`mkdir /path/to/common/rootfs`
- 挂载android镜像到根目录`mount -t squshfuse -o loop /path/to/android.img /path/to/common/rootsfs`
- 创建混合根目录`mkdir /path/to/common/combined-rootfs`
- 创建可写根目录`mkdir /path/to/common/rootfs-overlay`
- 合并根目录`mount -t overlay overlay -o lowerdir=/path/to/common/rootfs:/path/to/common/rootfs-overlay /path/to/common/combined-rootfs`
- 监听套接字地址`/path/to/common/sockets/anbox-container.socket`
- 创建容器配置&状态&日志目录`mkdir /path/to/common/containers && mkdir /path/to/common/state && mkdir /path/to/common/logs`
- 等待消息`start_container`,`stop_container`
- 创建容器配置文件`/path/to/common/conainers/default/config`并启动容器

一键启动命令`sudo SNAP_COMMON=/home/sl.truman/Desktop/anbox-data anbox container-manager --data-path=/home/sl.truman/Desktop/anbox-data --privileged`

## session-manager运行原理

- 创建会话套接字目录`mkdir /path/to/common/anbox/sockets`
- 创建输入设备套接字目录`mkdir /path/to/common/anbox/input`
- 创建图形平台
- 创建窗口管理器
- 创建GL渲染器
- 监听套接字地址`/path/to/common/anbox/sockets/qemu_pipe`
- 监听套接字地址`/path/to/common/anbox/sockets/anbox_bridge`
- 

一键启动命令`SNAP_USER_COMMON=/home/sl.truman/Desktop/anbox-data anbox session-manager --single-window`
