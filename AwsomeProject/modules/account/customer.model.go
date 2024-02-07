package account

import (
	"gorm.io/gorm"
)

type Customer struct {
	gorm.Model
	Fname    string `gorm:"size:45;not null"`
	Lname    string `gorm:"size:45;not null"`
	Email    string `gorm:"size:45;not null"`
	Password string `gorm:"size:45;not null"`
	Street   string `gorm:"size:255;not null"`
	City     string `gorm:"size:45;not null"`
	State    string `gorm:"size:45;not null"`
	Zipcode  string `gorm:"size:45;not null"`
}
