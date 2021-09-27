# django项目升级
本次将2016/17年编写的，基于django1.8的程序，改成基于django3.2的版本，稍加修改后，已经能在python3.8虚拟环境中运行了，暂时没再发现问题

## 容器化
改造该项目的目的，是为django项目的容器化部署，离线部署，提供完整的解决方案

* 有了这个经验，后续简单的python3应用的容器化部署，就成小儿科了

1. 软件版本：django==3.2.6，python==3.8, mysql==8.0


echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  focal stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null