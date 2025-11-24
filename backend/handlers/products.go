package handlers

import (
	"database/sql"
	"net/http"

	"ecommerce-backend/database"
	"ecommerce-backend/models"

	"github.com/gin-gonic/gin"
)

func GetProducts(c *gin.Context) {
	category := c.Query("category")
	search := c.Query("search")

	query := "SELECT id, name, description, price, stock, image_url, category, created_at FROM products WHERE 1=1"
	args := []interface{}{}

	if category != "" {
		query += " AND category = ?"
		args = append(args, category)
	}

	if search != "" {
		query += " AND (name LIKE ? OR description LIKE ?)"
		searchTerm := "%" + search + "%"
		args = append(args, searchTerm, searchTerm)
	}

	query += " ORDER BY created_at DESC"

	rows, err := database.DB.Query(query, args...)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error obteniendo productos"})
		return
	}
	defer rows.Close()

	products := []models.Product{}
	for rows.Next() {
		var p models.Product
		if err := rows.Scan(&p.ID, &p.Name, &p.Description, &p.Price, &p.Stock, &p.ImageURL, &p.Category, &p.CreatedAt); err != nil {
			continue
		}
		products = append(products, p)
	}

	c.JSON(http.StatusOK, products)
}

func GetProduct(c *gin.Context) {
	id := c.Param("id")

	var p models.Product
	err := database.DB.QueryRow(
		"SELECT id, name, description, price, stock, image_url, category, created_at FROM products WHERE id = ?",
		id,
	).Scan(&p.ID, &p.Name, &p.Description, &p.Price, &p.Stock, &p.ImageURL, &p.Category, &p.CreatedAt)

	if err == sql.ErrNoRows {
		c.JSON(http.StatusNotFound, gin.H{"error": "Producto no encontrado"})
		return
	}

	c.JSON(http.StatusOK, p)
}

func CreateProduct(c *gin.Context) {
	var req models.CreateProductRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	result, err := database.DB.Exec(
		"INSERT INTO products (name, description, price, stock, image_url, category) VALUES (?, ?, ?, ?, ?, ?)",
		req.Name, req.Description, req.Price, req.Stock, req.ImageURL, req.Category,
	)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error creando producto"})
		return
	}

	productID, _ := result.LastInsertId()
	c.JSON(http.StatusCreated, gin.H{
		"message":    "Producto creado exitosamente",
		"product_id": productID,
	})
}

func UpdateProduct(c *gin.Context) {
	id := c.Param("id")

	var req models.CreateProductRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	_, err := database.DB.Exec(
		"UPDATE products SET name=?, description=?, price=?, stock=?, image_url=?, category=? WHERE id=?",
		req.Name, req.Description, req.Price, req.Stock, req.ImageURL, req.Category, id,
	)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error actualizando producto"})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Producto actualizado exitosamente"})
}

func DeleteProduct(c *gin.Context) {
	id := c.Param("id")

	_, err := database.DB.Exec("DELETE FROM products WHERE id = ?", id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error eliminando producto"})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Producto eliminado exitosamente"})
}

func GetCategories(c *gin.Context) {
	rows, err := database.DB.Query("SELECT DISTINCT category FROM products WHERE category != '' ORDER BY category")
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error obteniendo categorías"})
		return
	}
	defer rows.Close()

	categories := []string{}
	for rows.Next() {
		var category string
		if err := rows.Scan(&category); err != nil {
			continue
		}
		categories = append(categories, category)
	}

	c.JSON(http.StatusOK, categories)
}
