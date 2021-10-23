# ancloud

## 工作计划

| 项目 | 任务          | 问题                 | 时间 | 人员   |
| ---- | ------------- | -------------------- | ---- | ------ |
| 后端 | anbox源码研究 | 编译&运行&原理       |      | 刘楚门 |
|      |               | LXC学习&使用         |      |        |
|      |               | SDL2学习&使用        |      |        |
|      |               | 用LXC启动Android镜像 |      |        |
|      |               | 采集视频流           |      |        |
|      |               | 中转触控事件         |      |        |
|      |               | iptables学习&使用    |      |        |
| |  | anbox-container-manager原理 | | |
| | | anbox-session-manager原理 | | |
| | |  | | |
| | | | | |
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
- 编译并加载驱动：`binder`，`ashmem`。
- 44 7824754863 

## container-manager运行原理

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
- 创建binderfs文件系统目录：`mkdir /path/to/binderfs && mount -t binder none /path/to/binderfs`
- 挂载android镜像：`mount -t fuse.squshfuse -o allow_other /path/to/android.img /path/to/rootsfs`

## session-manager运行原理

