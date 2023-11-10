# Stage 1: Build the application
FROM krmp-d2hub-idock.9rum.cc/goorm/gradle:7.3.1-jdk17

WORKDIR project

COPY /sunsu-wedding .

RUN echo "systemProp.http.proxyHost=krmp-proxy.9rum.cc\nsystemProp.http.proxyPort=3128\nsystemProp.https.proxyHost=krmp-proxy.9rum.cc\nsystemProp.https.proxyPort=3128" > /root/.gradle/gradle.properties

RUN ./gradlew clean build -x test

ENV DATABASE_URL=jdbc:mysql://mysql/sunsu_wedding

CMD ["java", "-jar", "-Dspring.profiles.active=prod", "/home/gradle/project/build/libs/sunsu-wedding-0.0.1-SNAPSHOT.jar"]
