###
# Dockerfile for Unidata Tomcat.
###

# Use Bitnami Tomcat 9.0 as base image
FROM bitnami/tomcat:9.0

# Copy Tomcat's entrypoint script
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

# Expose Tomcat's default port
EXPOSE 8080

ENTRYPOINT [ "/opt/bitnami/scripts/tomcat/entrypoint.sh" ]
CMD [ "/opt/bitnami/scripts/tomcat/run.sh" ]


