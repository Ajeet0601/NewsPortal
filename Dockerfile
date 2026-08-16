FROM tomcat:9.0-jdk11-openjdk-slim

# Download MySQL connector in Tomcat
RUN apt-get update && apt-get install -y wget && \
    wget https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.33/mysql-connector-java-8.0.33.jar -P /usr/local/tomcat/lib/ && \
    rm -rf /var/lib/apt/lists/*

# Clean default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy web files (JSPs, HTML, CSS, WEB-INF)
COPY src/main/webapp/ /usr/local/tomcat/webapps/ROOT/

# Compile Java Servlets & DAOs
COPY src/main/java/ /tmp/src/
RUN mkdir -p /usr/local/tomcat/webapps/ROOT/WEB-INF/classes && \
    find /tmp/src -name "*.java" > /tmp/sources.txt && \
    javac -cp "/usr/local/tomcat/lib/*:/usr/local/tomcat/webapps/ROOT/WEB-INF/lib/*" -d /usr/local/tomcat/webapps/ROOT/WEB-INF/classes @/tmp/sources.txt && \
    rm -rf /tmp/src /tmp/sources.txt

EXPOSE 8080
CMD ["catalina.sh", "run"]