# Stage 1: Build the Maven project
FROM maven:3.8.8-eclipse-temurin-21 AS builder

# Set the working directory
WORKDIR /build

# Copy the Maven project files to the container
COPY pom.xml ./
COPY src ./src

# Install external dependencies into local repository
RUN mvn clean package -DskipTests -q

# Stage 2: Create the runtime image
FROM maven:3.8.8-eclipse-temurin-21

# Set the working directory
WORKDIR /app

# Copy the built jar from the builder stage
COPY --from=builder /build/target/airplane-management-system-0.0.1-SNAPSHOT.jar app.jar

# Expose the application port
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "app.jar"]