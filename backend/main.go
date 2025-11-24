package main

import (
	"database/sql"
	"log"
	"os"
	"strings"

	"ecommerce-backend/routes"
	"ecommerce-backend/database"

	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
	_ "github.com/go-sql-driver/mysql"
)

// Helper function para dividir y limpiar strings
func splitAndTrim(s, sep string) []string {
	parts := strings.Split(s, sep)
	result := []string{}
	for _, part := range parts {
		trimmed := strings.TrimSpace(part)
		if trimmed != "" {
			result = append(result, trimmed)
		}
	}
	return result
}

func main() {
	// Conexión a MySQL
	dsn := os.Getenv("DB_DSN")
	if dsn == "" {
		dsn = "danny:2077@tcp(localhost:3306)/ecommerce?parseTime=true"
	}

	db, err := sql.Open("mysql", dsn)
	if err != nil {
		log.Fatal("Error conectando a la base de datos:", err)
	}
	defer db.Close()

	if err := db.Ping(); err != nil {
		log.Fatal("Error verificando conexión:", err)
	}

	database.DB = db
	log.Println("Conexión a MySQL exitosa")

	// Configurar Gin
	r := gin.Default()

	// CORS - Configuración dinámica para desarrollo y producción
	allowedOrigins := os.Getenv("ALLOWED_ORIGINS")
	if allowedOrigins == "" {
		allowedOrigins = "http://localhost:4321,http://localhost:3000"
	}
	
	origins := []string{}
	for _, origin := range splitAndTrim(allowedOrigins, ",") {
		origins = append(origins, origin)
	}

	r.Use(cors.New(cors.Config{
		AllowOrigins:     origins,
		AllowMethods:     []string{"GET", "POST", "PUT", "DELETE", "OPTIONS"},
		AllowHeaders:     []string{"Origin", "Content-Type", "Authorization"},
		ExposeHeaders:    []string{"Content-Length"},
		AllowCredentials: true,
	}))

	// Health check endpoint
	r.GET("/api/health", func(c *gin.Context) {
		c.JSON(200, gin.H{"status": "ok", "message": "API is running"})
	})

	// Rutas
	routes.SetupRoutes(r)

	// Iniciar servidor
	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}
	log.Printf("Servidor corriendo en puerto %s", port)
	r.Run(":" + port)
}
