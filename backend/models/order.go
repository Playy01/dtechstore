package models

import "time"

type Order struct {
	ID        int         `json:"id"`
	UserID    int         `json:"user_id"`
	Total     float64     `json:"total"`
	Status    string      `json:"status"` // "pending", "completed", "cancelled"
	CreatedAt time.Time   `json:"created_at"`
	Items     []OrderItem `json:"items,omitempty"`
}

type OrderItem struct {
	ID        int     `json:"id"`
	OrderID   int     `json:"order_id"`
	ProductID int     `json:"product_id"`
	Quantity  int     `json:"quantity"`
	Price     float64 `json:"price"`
	Product   *Product `json:"product,omitempty"`
}

type CreateOrderRequest struct {
	Items []OrderItemRequest `json:"items" binding:"required,min=1"`
}

type OrderItemRequest struct {
	ProductID int `json:"product_id" binding:"required"`
	Quantity  int `json:"quantity" binding:"required,gt=0"`
}
