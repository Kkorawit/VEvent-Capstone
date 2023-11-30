FROM maven:3.9.5 AS build
WORKDIR /vevent-app
COPY . .
RUN mvn clean install -U -DskipTests
# CMD mvn spring-boot:run

FROM openjdk:17
COPY --from=build /vevent-app/target/*.jar app.jar
ENV TZ=Asia/Bangkok
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]