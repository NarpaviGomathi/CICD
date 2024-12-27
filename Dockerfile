# Copyright Broadcom, Inc. All Rights Reserved.
# SPDX-License-Identifier: APACHE-2.0

# Use Bitnami Tomcat 10.1 as the base image
FROM docker.io/bitnami/tomcat:10.1

# Set environment variable to allow empty passwords
#ENV ALLOW_EMPTY_PASSWORD=yes
ENV USERNAME=demo
ENV PASSWORD=demo@123



# Expose the default Tomcat port
EXPOSE 8080




