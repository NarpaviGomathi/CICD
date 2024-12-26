###
# Dockerfile for Unidata Tomcat.
###

# Use Bitnami Tomcat 9.0 as base image
FROM bitnami/tomcat:9.0

# Expose Tomcat's default port
EXPOSE 8080


CMD ["catalina.sh", "run"]

