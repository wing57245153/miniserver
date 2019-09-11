FROM ubuntu:16.04

# build--
# sudo docker build --tag=miniserver:core .
# 基础服务服，只包含nginx  php 以及其他扩展
# sudo docker run -d --name miniserver miniserver:core

WORKDIR /data_soft
COPY . /data_soft

# 添加资源镜像
RUN cp /etc/apt/sources.list /etc/apt/sources.list.bak
RUN cp /data_soft/sources.list /etc/apt/sources.list

RUN apt-get update
# 安装基础软件：
# 安装ping
RUN apt-get -y install iputils-ping
# 安装ssh服务 22端口
RUN apt-get -y install openssh-server
# 支持sudo
RUN apt-get -y install sudo
# 先改root密码
RUN echo "root:maoer123" | chpasswd
# ssh配置
RUN sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config
# 添加测试用户ubuntu，密码ubuntu，并且将此用户添加到sudoers里 
RUN useradd ubuntu
RUN echo "ubuntu:maoer123" | chpasswd
RUN echo "ubuntu   ALL=(ALL)       ALL" >> /etc/sudoers
# 创建用户目录
RUN mkdir /home/ubuntu

# RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key 
# RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key 

# ifconfig 
RUN apt-get -y install net-tools 
# 安装vim编辑器
RUN apt-get -y install vim

# 安装开发软件
# nginx服务器 (1.10.3版本)
RUN apt-get -y install nginx
# php (7.0版本)
RUN apt-get -y install php php-dev
# mysql (5.7版本)
#RUN  apt-get -y install mysql-server mysql-client
# redis
#RUN apt-get -y install redis-server
# 安装git
# RUN apt-get -y install git
# 安装zip
RUN apt-get -y install zip

# redis扩展
RUN cp /data_soft/redis.so /usr/lib/php/20151012
RUN echo "extension=redis.so" >> /etc/php/7.0/fpm/conf.d/redis.ini

# 让 MySQL 获得 PHP 7支持
RUN apt-get -y install php7.0-mysql php7.0-curl php7.0-gd php-bcmath php7.0-intl php-pear php-imagick php7.0-imap php7.0-mcrypt php-memcache  php7.0-pspell php7.0-recode php7.0-sqlite3 php7.0-tidy php7.0-xmlrpc php7.0-xsl php7.0-mbstring php-gettext

# 服务配置
# php
COPY ./php/php.ini /etc/php/7.0/fpm/php.ini
COPY ./php/www.conf /etc/php/7.0/fpm/pool.d

# nginx 端口服务


# 启动服务
# 启动ssh服务
# RUN /etc/init.d/ssh start
# # 启动 fpm - php
# RUN /etc/init.d/php7.0-fpm start
# # 启动nginx
# RUN nginx
# # 启动mysql
# RUN /etc/init.d/mysql
# CMD [ "bash", "/data/start.sh" ]

# 启动sshd服务并且暴露22端口
RUN mkdir /var/run/sshd
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"] 