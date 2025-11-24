package handlers

import (
	"database/sql"
	"net/http"

	"ecommerce-backend/database"
	"ecommerce-backend/models"

	"github.com/gin-gonic/gin"
	"golang.org/x/crypto/bcrypt"
)

func GetUsers(c *gin.Context) {
	rows, err := database.DB.Query("SELECT id, email, name, role, created_at FROM users ORDER BY created_at DESC")
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error obteniendo usuarios"})
		return
	}
	defer rows.Close()

	users := []models.User{}
	for rows.Next() {
		var u models.User
		if err := rows.Scan(&u.ID, &u.Email, &u.Name, &u.Role, &u.CreatedAt); err != nil {
			continue
		}
		users = append(users, u)
	}

	c.JSON(http.StatusOK, users)
}

func GetUser(c *gin.Context) {
	id := c.Param("id")

	var u models.User
	err := database.DB.QueryRow(
		"SELECT id, email, name, role, created_at FROM users WHERE id = ?",
		id,
	).Scan(&u.ID, &u.Email, &u.Name, &u.Role, &u.CreatedAt)

	if err == sql.ErrNoRows {
		c.JSON(http.StatusNotFound, gin.H{"error": "Usuario no encontrado"})
		return
	}

	c.JSON(http.StatusOK, u)
}

func UpdateUser(c *gin.Context) {
	id := c.Param("id")

	var req struct {
		Name  string `json:"name"`
		Email string `json:"email"`
		Role  string `json:"role"`
	}

	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	_, err := database.DB.Exec(
		"UPDATE users SET name=?, email=?, role=? WHERE id=?",
		req.Name, req.Email, req.Role, id,
	)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error actualizando usuario"})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Usuario actualizado exitosamente"})
}

func DeleteUser(c *gin.Context) {
	id := c.Param("id")

	// No permitir eliminar al usuario actual
	userID := c.GetInt("user_id")
	
	// Convertir id de string a int para comparar
	var targetID int
	database.DB.QueryRow("SELECT id FROM users WHERE id = ?", id).Scan(&targetID)
	
	if userID == targetID {
		c.JSON(http.StatusBadRequest, gin.H{"error": "No puedes eliminar tu propia cuenta"})
		return
	}

	_, err := database.DB.Exec("DELETE FROM users WHERE id = ?", id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error eliminando usuario"})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Usuario eliminado exitosamente"})
}

func CreateUserByAdmin(c *gin.Context) {
	var req models.RegisterRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	hashedPassword, err := bcrypt.GenerateFromPassword([]byte(req.Password), bcrypt.DefaultCost)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error al procesar contraseña"})
		return
	}

	role := "user"
	if req.Email == "admin@tienda.com" {
		role = "admin"
	}

	result, err := database.DB.Exec(
		"INSERT INTO users (email, password, name, role) VALUES (?, ?, ?, ?)",
		req.Email, string(hashedPassword), req.Name, role,
	)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Email ya registrado"})
		return
	}

	userID, _ := result.LastInsertId()
	c.JSON(http.StatusCreated, gin.H{
		"message": "Usuario creado exitosamente",
		"user_id": userID,
	})
}
