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

# Copy Tomcat's entrypoint script
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

# Expose Tomcat's default port
EXPOSE 8080

# Use the entrypoint to initialize and start Tomcat
ENTRYPOINT ["/entrypoint.sh"]
CMD ["catalina.sh", "run"]
