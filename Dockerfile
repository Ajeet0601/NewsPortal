FROM tomcat:9.0-jdk11-openjdk-slim

# Remove default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy web files
COPY src/main/webapp/ /usr/local/tomcat/webapps/ROOT/

# Compile Java Servlets & DAOs
COPY src/main/java/ /tmp/src/
RUN mkdir -p /usr/local/tomcat/webapps/ROOT/WEB-INF/classes && \
    find /tmp/src -name "*.java" > /tmp/sources.txt && \
    javac -cp "/usr/local/tomcat/lib/*:/usr/local/tomcat/webapps/ROOT/WEB-INF/lib/*" -d /usr/local/tomcat/webapps/ROOT/WEB-INF/classes @/tmp/sources.txt && \
    rm -rf /tmp/src /tmp/sources.txt

EXPOSE 8080
CMD ["catalina.sh", "run"]