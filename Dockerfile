# Use the official Kotlin image as base
FROM gradle:jdk17 AS build

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Grant execute permission to gradlew
RUN chmod +x ./gradlew

# Build the application
RUN ./gradlew build

# Use the final image
FROM openjdk:17
WORKDIR /app

# Copy the built application
COPY --from=build /app/build/libs/*.jar app.jar

# Expose the application port
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "app.jar"]
