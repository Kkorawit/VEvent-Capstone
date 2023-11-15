FROM maven:3.8.5-jdk-11 AS build
WORKDIR /vevent-app
COPY . .
RUN mvn clean install -DskipTests
# CMD mvn spring-boot:run

FROM openjdk:11
COPY --from=build /vevent-app/target/*.jar app.jar
ENV TZ=Asia/Bangkok
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]