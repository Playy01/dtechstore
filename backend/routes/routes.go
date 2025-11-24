package routes

import (
	"ecommerce-backend/handlers"
	"ecommerce-backend/middleware"

	"github.com/gin-gonic/gin"
)

func SetupRoutes(r *gin.Engine) {
	api := r.Group("/api")
	{
		// Auth
		auth := api.Group("/auth")
		{
			auth.POST("/register", handlers.Register)
			auth.POST("/login", handlers.Login)
			auth.GET("/profile", middleware.AuthMiddleware(), handlers.GetProfile)
		}

		// Products
		products := api.Group("/products")
		{
			products.GET("", handlers.GetProducts)
			products.GET("/categories", handlers.GetCategories)
			products.GET("/:id", handlers.GetProduct)

			// Admin only
			admin := products.Group("")
			admin.Use(middleware.AuthMiddleware(), middleware.AdminMiddleware())
			{
				admin.POST("", handlers.CreateProduct)
				admin.PUT("/:id", handlers.UpdateProduct)
				admin.DELETE("/:id", handlers.DeleteProduct)
			}
		}

		// Orders
		orders := api.Group("/orders")
		orders.Use(middleware.AuthMiddleware())
		{
			orders.POST("", handlers.CreateOrder)
			orders.GET("", handlers.GetOrders)
			orders.GET("/:id", handlers.GetOrder)
			
			// Admin only
			orders.PUT("/:id/status", middleware.AdminMiddleware(), handlers.UpdateOrderStatus)
		}

		// Users (Admin only)
		users := api.Group("/users")
		users.Use(middleware.AuthMiddleware(), middleware.AdminMiddleware())
		{
			users.GET("", handlers.GetUsers)
			users.GET("/:id", handlers.GetUser)
			users.POST("", handlers.CreateUserByAdmin)
			users.PUT("/:id", handlers.UpdateUser)
			users.DELETE("/:id", handlers.DeleteUser)
		}
	}

	r.GET("/health", func(c *gin.Context) {
		c.JSON(200, gin.H{"status": "ok"})
	})
}
