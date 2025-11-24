FROM golang:1.21-alpine AS builder

WORKDIR /app

# Copiar archivos de dependencias
COPY go.mod go.sum ./
RUN go mod download

# Copiar código fuente
COPY . .

# Compilar aplicación
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o dtech-api main.go

# Imagen final
FROM alpine:latest

RUN apk --no-cache add ca-certificates

WORKDIR /root/

# Copiar binario compilado
COPY --from=builder /app/dtech-api .

# Exponer puerto (Railway usa PORT variable)
EXPOSE 8080

# Comando de inicio
CMD ["./dtech-api"]
