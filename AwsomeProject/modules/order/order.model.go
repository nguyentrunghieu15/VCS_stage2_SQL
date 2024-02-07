package order

import (
	"time"

	"github.com/nguyentrunghieu15/VCS_stage2_SQL/modules/account"
	"gorm.io/gorm"
)

type Order struct {
	gorm.Model
	Date     time.Time        `gorm:"type:timestamp;not null"`
	Status   string           `gorm:"size:45,not null"`
	Customer account.Customer `gorm:"foreignKey:customer_id;references:id"`
}

type Department struct {
	gorm.Model
	Name string `gorm:"size:45;not null"`
}

type Category struct {
	Name       string     `gorm:"size:45;not null"`
	Department Department `gorm:"foreignKey:department_id,references:id"`
}

type Product struct {
	gorm.Model
	Name        string   `gorm:"size:45;not null"`
	Description string   `gorm:"size:255;not null"`
	Price       float64  `gorm:"not null"`
	Image       string   `gorm:"size:255;not null"`
	Category    Category `gorm:"foreignKey:category_id,references:id"`
}

type OrderItem struct {
	gorm.Model
	Quantity     int     `gorm:"not null"`
	Subtotal     float64 `gorm:"not null"`
	ProductPrice float64 `gorm:"not null"`
	Order        Order   `gorm:"foreignKey:order_id,references:id"`
	Product      Product `gorm:"foreignKey:product_id,references:id"`
}

func (Category) TableName() string {
	return "categories"
}
