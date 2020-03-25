FROM docker.io/httpd
LABEL io.k8s.description="Simple HTTP Webserver" \
      io.k8s.display-name="Simple HTTP Webserver" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,http" \
      io.openshift.s2i.scripts-url="image:///usr/libexec/s2i"
      
COPY assemble /usr/libexec/s2i/
COPY run /usr/libexec/s2i/
COPY usage /usr/libexec/s2i/

RUN chmod -R 777 /usr/local/apache2/htdocs/ && \
    chmod -R 777 /usr/local/apache2/logs/ && \
    sed -i 's/Listen 80/Listen 8080/g' /usr/local/apache2/conf/httpd.conf

USER 1001

EXPOSE 8080

CMD ["/usr/libexec/s2i/usage"]
