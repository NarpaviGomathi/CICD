###
# Dockerfile for Unidata Tomcat.
###

# Use Bitnami Tomcat 9.0 as base image
FROM bitnami/tomcat:9.0

# Expose Tomcat's default port
EXPOSE 8080

# Copy Tomcat's entrypoint script
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

# Use the entrypoint to initialize and start Tomcat
ENTRYPOINT ["/entrypoint.sh"]
CMD ["catalina.sh", "run"]

