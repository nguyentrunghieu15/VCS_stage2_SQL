package model

type Customer struct {
	customerId       uint   `gorm:"primary key;not null;type:int"`
	customerFname    string `gorm:"type:varchar;size:45;not null"`
	customerLname    string `gorm:"type:varchar;size:45;not null"`
	customerEmail    string `gorm:"type:varchar;size:45;not null"`
	customerPassword string `gorm:"type:varchar;size:45;not null"`
	customerStreet   string `gorm:"type:varchar;size:255;not null"`
	customerCity     string `gorm:"type:varchar;size:45;not null"`
	customerState    string `gorm:"type:varchar;size:45;not null"`
	customerZipcode  string `gorm:"type:varchar;size:45;not null"`
}

func (Customer) TableName() string {
	return "customers"
}
