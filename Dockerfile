FROM percona:5.7.26
USER root
LABEL creater="barnett"
ENV MYSQL_VERSION=5.7.26
ENV TZ=Asia/Shanghai
ADD docker-entrypoint.sh /run/docker-entrypoint.sh
ADD mysqld.cnf /etc/percona-server.conf.d/
RUN rm -rf /etc/yum.repos.d/percona* \
    yum update && yum install wget net-tools -y; \
    wget -O /usr/local/bin/env2file -q https://github.com/barnettZQG/env2file/releases/download/0.1.1/env2file-linux; \
    chmod +x /run/docker-entrypoint.sh && chmod +x /usr/local/bin/env2file; \
    chmod +rw /var/lib/mysql; \
    chmod 755 /etc/percona-server.conf.d
EXPOSE 3306
VOLUME ["/var/lib/mysql", "/var/log/mysql","/etc/percona-server.conf.d"]
# change ENTRYPOINT exec some custom command
ENTRYPOINT [ "/run/docker-entrypoint.sh" ]
CMD [ "mysqld", "--user=root" ]
