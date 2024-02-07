package accountservice

import (
	account "github.com/nguyentrunghieu15/VCS_stage2_SQL/modules/account"
	"gorm.io/gorm"
)

type CustomerRepo struct {
	db *gorm.DB
}

func (c *CustomerRepo) CreateCustomer(customer *account.Customer) (*account.Customer, error) {
	result := c.db.Create(customer)
	return customer, result.Error
}

func (c *CustomerRepo) FindCustomerById(Id uint) (account.Customer, error) {
	var customer account.Customer
	result := c.db.First(&customer, Id)
	return customer, result.Error
}

func (c *CustomerRepo) UpdateCustomerById(customer account.Customer) (account.Customer, error) {
	result := c.db.Save(&customer)
	return customer, result.Error
}
