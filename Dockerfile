# Use a base image with Java pre-installed
FROM adoptopenjdk:11-jre-hotspot

# Set the working directory
WORKDIR /app

# Copy the JAR file to the working directory
COPY target/*.jar app.war

# Expose the desired port for the application
EXPOSE 8080

# Set the command to run the application
CMD ["java", "-jar", "app.war"]
