###
# Dockerfile for Unidata Tomcat
###
FROM tomcat:9.0-jdk11

LABEL maintainer="Unidata"

# Install necessary packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        gosu \
        zip \
        unzip && \
    # Cleanup
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    # Restore default web applications (including ROOT for the index page)
    cp -r ${CATALINA_HOME}/webapps.dist/ROOT ${CATALINA_HOME}/webapps/ && \
    echo "Tomcat Default Webapps Restored" && \
    # Obscure server info
    cd ${CATALINA_HOME}/lib && \
    mkdir -p org/apache/catalina/util/ && \
    unzip -j catalina.jar org/apache/catalina/util/ServerInfo.properties \
        -d org/apache/catalina/util/ && \
    sed -i 's/server.info=.*/server.info=Apache Tomcat/g' \
        org/apache/catalina/util/ServerInfo.properties && \
    zip -ur catalina.jar \
        org/apache/catalina/util/ServerInfo.properties && \
    rm -rf org && cd ${CATALINA_HOME} && \
    # Set restrictive umask container-wide
    echo "session optional pam_umask.so" >> /etc/pam.d/common-session && \
    sed -i 's/UMASK.*022/UMASK           007/g' /etc/login.defs

# Copy security-enhanced configuration files
COPY web.xml ${CATALINA_HOME}/conf/
COPY server.xml ${CATALINA_HOME}/conf/

# Copy the entrypoint script
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

# Expose Tomcat's default port
EXPOSE 8080

# Define entrypoint and default command
ENTRYPOINT ["/entrypoint.sh"]
CMD ["catalina.sh", "run"]
