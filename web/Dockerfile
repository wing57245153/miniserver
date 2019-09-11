FROM miniserver:core

# sudo docker build --tag=webserver .

WORKDIR /data_soft
COPY ./start.sh /data_soft

# 直接启动服务

CMD [ "bash", "/data_soft/start.sh" ]