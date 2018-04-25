FROM percona:5.5.59

MAINTAINER zhouyq@goodrain.com

VOLUME ["/data"]

COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 3306
CMD ["mysqld"]