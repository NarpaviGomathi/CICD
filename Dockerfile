###
# Dockerfile for Unidata Tomcat.
###

# Use Bitnami Tomcat 9.0 as base image
FROM bitnami/tomcat:9.0

# Install necessary packages and cleanup
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        gosu \
        zip \
        unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Remove default web applications
RUN rm -rf ${CATALINA_HOME}/webapps/* && \
    rm -rf ${CATALINA_HOME}/webapps.dist

# Obscure server information in catalina.jar
RUN cd ${CATALINA_HOME}/lib && \
    mkdir -p org/apache/catalina/util/ && \
    unzip -j catalina.jar org/apache/catalina/util/ServerInfo.properties \
        -d org/apache/catalina/util/ && \
    sed -i 's/server.info=.*/server.info=Apache Tomcat/g' \
        org/apache/catalina/util/ServerInfo.properties && \
    zip -ur catalina.jar org/apache/catalina/util/ServerInfo.properties && \
    rm -rf org && \
    cd ${CATALINA_HOME}

# Copy Tomcat's entrypoint script
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

# Expose Tomcat's default port
EXPOSE 8080

# Use the entrypoint to initialize and start Tomcat
ENTRYPOINT ["/entrypoint.sh"]
CMD ["catalina.sh", "run"]
