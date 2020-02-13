FROM registry.access.redhat.com/openjdk/openjdk-11-rhel7:latest
# VOLUME /tmp

EXPOSE 8080


ARG common_services_skeleton_version
# ADD ${JAR_FILE} app.jar

ENV CSS_HOME=/opt/common-services-skeleton
ENV LOG_DIR=/opt/common-services-skeleton/logs
ENV COMMON_SERVICES_SKELETON_VERSION=${common_services_skeleton_version}

RUN mkdir -p ${LOG_DIR}
ADD common-services-skeleton-${COMMON_SERVICES_SKELETON_VERSION}-SNAPSHOT.jar ${CSS_HOME}/app.jar

WORKDIR ${CSS_HOME}

# ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]
ENTRYPOINT ["java", "-jar","app.jar"]

