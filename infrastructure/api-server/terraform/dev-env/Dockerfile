FROM ubuntu:14.04
RUN apt-get update
RUN apt-get install -y openjdk-7-jdk git maven
RUN ln -fs /usr/lib/jvm/java-7-openjdk-amd64/jre/bin/java /etc/alternatives/java
CMD ["git", "clone", "https://github.com/airavata-courses/spring17-API-Server.git"]
CMD ["cd", "spring17-API-Server"]
CMD ["mvn", "clean","install]
CMD ["java", "-jar", "mock-airavata-api-server/target/mock-airavata-api-server-0.15-SNAPSHOT.jar"]
CMD ["bash"]

