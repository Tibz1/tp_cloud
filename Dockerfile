# Étape 1 : Utiliser une image Maven officielle pour la construction du projet
FROM maven:latest AS build

# Définir le répertoire de travail
WORKDIR /app

# Copier les fichiers `pom.xml` et les sources du projet dans le conteneur
COPY pom.xml .
COPY src ./src

# Télécharger les dépendances Maven et compiler le projet
RUN mvn clean package -DskipTests

# Étape 2 : Utiliser une image OpenJDK pour exécuter l'application
FROM openjdk:21

# Définir le répertoire de travail
WORKDIR /app

# Copier le fichier JAR généré depuis l'étape précédente
COPY --from=build /app/target/tp-cloud-0.0.1-SNAPSHOT.jar app.jar

# Exposer le port 8081(ou tout autre port utilisé par votre application)
EXPOSE 8081

# Commande pour exécuter l'application Spring Boot
CMD ["java", "-jar", "app.jar"]
