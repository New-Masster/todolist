FROM ubuntu:latest AS build

RUN apt-get update
RUN apt-get install openjdk-17-jdk -y

COPY . .

ADD ./pom.xml pom.xml
ADD ./src src/

RUN apt-get install maven -y
RUN mvn clean install

EXPOSE 8080 

FROM openjdk-17-jdk -y

COPY --from=build /target/todolist-1.0.0.jar app.jar

ENTRYPOINT [ "java", "-jar", "app.jar" ]