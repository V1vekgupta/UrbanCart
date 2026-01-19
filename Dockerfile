# =========================
# Build stage
# =========================
FROM maven:3.9.9-eclipse-temurin-22 AS build

WORKDIR /app

COPY pom.xml .
RUN mvn dependency:go-offline

COPY src ./src
RUN mvn clean package -DskipTests

# =========================
# Runtime stage
# =========================
FROM eclipse-temurin:22-jre

WORKDIR /app

COPY --from=build /app/target/sb-ecom-0.0.1-SNAPSHOT.jar .

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "sb-ecom-0.0.1-SNAPSHOT.jar"]
