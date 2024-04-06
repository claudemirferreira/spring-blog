# Use a imagem oficial do OpenJDK como base
FROM adoptopenjdk:17-jdk-hotspot

# Configuração do diretório de trabalho dentro do container
WORKDIR /app

# Copiar o arquivo JAR da aplicação para o diretório de trabalho do container
COPY ./target/spring-blog.jar /app

# Comando padrão para executar a aplicação quando o container for iniciado
CMD ["java", "-jar", "spring-blog.jar"]
