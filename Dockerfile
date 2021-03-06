FROM percona:5.7.23-stretch
LABEL creater="barnett"
ENV MYSQL_VERSION=5.7.23
ENV TZ=Asia/Shanghai
ENV MYSQLC_MYSQLD_datadir=/data
ENV MYSQLC_CLIENT_default-character-set=utf8
ENV MYSQLC_MYSQLD_character_set_server=utf8
ENV MYSQLC_MYSQL_default-character-set=utf8
ADD docker-entrypoint.sh /run/docker-entrypoint.sh
RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list; \
    rm -rf /etc/apt/sources.list.d/percona.list && apt-get update; \
    apt-get install -y --no-install-recommends wget net-tools; \
    rm -rf /var/lib/apt/lists/*; \
    wget -O /usr/local/bin/env2file -q https://github.com/barnettZQG/env2file/releases/download/0.1.1/env2file-linux; \
    chmod +x /run/docker-entrypoint.sh && chmod +x /usr/local/bin/env2file;
EXPOSE 3306
VOLUME ["/var/lib/mysql", "/var/log/mysql"]
# change ENTRYPOINT exec some custom command
ENTRYPOINT [ "/run/docker-entrypoint.sh" ]
CMD [ "mysqld" ]
