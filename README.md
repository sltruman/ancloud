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
| 前端 |    webrtc学习  |                |      |     周兴邦   |
|      |               | 本地视频播放示例页面  |   2021.10.24   |        |
|      |               |  webrtc 实现云播放   |      |        |
|      |               |  串流播放            |      |        |
|      |               |  推流学习            |      |        |
|      |               |  前后端交互          |      |        |
|      |               |  远程链接            |      |        |
|      |               |  app开发             |      |        |

## anbox运行环境

- 采用Linux kernel 5.4，在配置中添加binderfs文件系统支持，在文件`kernel/kallsyms.c`中添加`EXPORT_SYMBOL(kallsyms_lookup_name)`导出符号。
- 
