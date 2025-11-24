package handlers

import (
	"database/sql"
	"net/http"

	"ecommerce-backend/database"
	"ecommerce-backend/models"

	"github.com/gin-gonic/gin"
)

func CreateOrder(c *gin.Context) {
	userID := c.GetInt("user_id")

	var req models.CreateOrderRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	tx, err := database.DB.Begin()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error iniciando transacción"})
		return
	}
	defer tx.Rollback()

	var total float64
	for _, item := range req.Items {
		var price float64
		var stock int
		err := tx.QueryRow("SELECT price, stock FROM products WHERE id = ?", item.ProductID).Scan(&price, &stock)
		if err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": "Producto no encontrado"})
			return
		}

		if stock < item.Quantity {
			c.JSON(http.StatusBadRequest, gin.H{"error": "Stock insuficiente"})
			return
		}

		total += price * float64(item.Quantity)
	}

	result, err := tx.Exec("INSERT INTO orders (user_id, total, status) VALUES (?, ?, ?)", userID, total, "pending")
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error creando orden"})
		return
	}

	orderID, _ := result.LastInsertId()

	for _, item := range req.Items {
		var price float64
		tx.QueryRow("SELECT price FROM products WHERE id = ?", item.ProductID).Scan(&price)

		_, err := tx.Exec(
			"INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)",
			orderID, item.ProductID, item.Quantity, price,
		)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Error agregando items"})
			return
		}

		_, err = tx.Exec("UPDATE products SET stock = stock - ? WHERE id = ?", item.Quantity, item.ProductID)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Error actualizando stock"})
			return
		}
	}

	if err := tx.Commit(); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error completando orden"})
		return
	}

	c.JSON(http.StatusCreated, gin.H{
		"message":  "Orden creada exitosamente",
		"order_id": orderID,
		"total":    total,
	})
}

func GetOrders(c *gin.Context) {
	userID := c.GetInt("user_id")
	role := c.GetString("user_role")

	query := "SELECT id, user_id, total, status, created_at FROM orders"
	args := []interface{}{}

	if role != "admin" {
		query += " WHERE user_id = ?"
		args = append(args, userID)
	}

	query += " ORDER BY created_at DESC"

	rows, err := database.DB.Query(query, args...)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error obteniendo órdenes"})
		return
	}
	defer rows.Close()

	orders := []models.Order{}
	for rows.Next() {
		var o models.Order
		if err := rows.Scan(&o.ID, &o.UserID, &o.Total, &o.Status, &o.CreatedAt); err != nil {
			continue
		}
		orders = append(orders, o)
	}

	c.JSON(http.StatusOK, orders)
}

func GetOrder(c *gin.Context) {
	orderID := c.Param("id")
	userID := c.GetInt("user_id")
	role := c.GetString("user_role")

	var order models.Order
	err := database.DB.QueryRow(
		"SELECT id, user_id, total, status, created_at FROM orders WHERE id = ?",
		orderID,
	).Scan(&order.ID, &order.UserID, &order.Total, &order.Status, &order.CreatedAt)

	if err == sql.ErrNoRows {
		c.JSON(http.StatusNotFound, gin.H{"error": "Orden no encontrada"})
		return
	}

	if role != "admin" && order.UserID != userID {
		c.JSON(http.StatusForbidden, gin.H{"error": "Acceso denegado"})
		return
	}

	rows, err := database.DB.Query(
		"SELECT oi.id, oi.order_id, oi.product_id, oi.quantity, oi.price, p.name, p.image_url FROM order_items oi JOIN products p ON oi.product_id = p.id WHERE oi.order_id = ?",
		orderID,
	)
	if err == nil {
		defer rows.Close()
		for rows.Next() {
			var item models.OrderItem
			item.Product = &models.Product{}
			rows.Scan(&item.ID, &item.OrderID, &item.ProductID, &item.Quantity, &item.Price, &item.Product.Name, &item.Product.ImageURL)
			order.Items = append(order.Items, item)
		}
	}

	c.JSON(http.StatusOK, order)
}

func UpdateOrderStatus(c *gin.Context) {
	orderID := c.Param("id")

	var req struct {
		Status string `json:"status" binding:"required"`
	}

	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// Validar que el status sea válido
	validStatuses := map[string]bool{
		"pending":   true,
		"completed": true,
		"cancelled": true,
	}

	if !validStatuses[req.Status] {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Estado inválido"})
		return
	}

	_, err := database.DB.Exec(
		"UPDATE orders SET status = ? WHERE id = ?",
		req.Status, orderID,
	)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error actualizando orden"})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Estado actualizado exitosamente"})
}
