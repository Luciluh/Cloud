# Usamos una imagen base de OpenJDK 17
FROM eclipse-temurin:17-jre-alpine

# Ponemos el jar en la imagen
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar

# Puerto en que corre la app
EXPOSE 8080

# Ejecutamos el jar
ENTRYPOINT ["java","-jar","/app.jar"]
