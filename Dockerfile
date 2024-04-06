# Use a imagem oficial do OpenJDK como base
FROM adoptopenjdk:17-jdk-hotspot AS builder

# Atualize o índice de pacotes e instale o Maven
RUN apt-get update && \
    apt-get install -y maven

# Configuração do diretório de trabalho dentro do container
WORKDIR /app

# Copie apenas o arquivo pom.xml para o diretório de trabalho
COPY pom.xml .

# Baixe as dependências do Maven, mas não execute nenhum outro goal de construção
RUN mvn dependency:go-offline

# Copie o restante dos arquivos do projeto para o diretório de trabalho
COPY . .

# Construa a aplicação Java usando o Maven
RUN mvn clean package

# Agora, use a imagem oficial do OpenJDK como base, sem o Maven
FROM adoptopenjdk:17-jdk-hotspot

# Configuração do diretório de trabalho dentro do container
WORKDIR /app

# Copie o arquivo JAR da aplicação do estágio anterior
COPY --from=builder /app/target/spring-blog.jar .

# Comando padrão para executar a aplicação quando o container for iniciado
CMD ["java", "-jar", "spring-blog.jar"]
