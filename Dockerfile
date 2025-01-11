# Use an official OpenJDK image as the base image
FROM openjdk:17-jdk-slim

# Set the working directory inside the container
WORKDIR /app
RUN mvn clean package -DskipTests -q

# Copy the Spring Boot JAR file into the container
COPY target/airplane-management-system-0.0.1-SNAPSHOT.jar app.jar

# Expose the port on which the Spring Boot application runs
EXPOSE 8080

# Command to run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
