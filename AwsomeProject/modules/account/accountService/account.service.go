package accountservice

import (
	"github.com/nguyentrunghieu15/VCS_stage2_SQL/modules/account"
	"gorm.io/gorm"
)

type AccountService struct {
	CustomerRepo *gorm.DB
}

func (c *AccountService) CreateCustomer(cus *account.Customer) (*account.Customer, error) {
	res := c.CustomerRepo.Transaction(func(tx *gorm.DB) error {
		if err := tx.Create(cus).Error; err != nil {
			return err
		}
		return nil
	})
	return cus, res
}

func (c *AccountService) FindCustomerById(Id uint) (*account.Customer, error) {
	var customer *account.Customer
	res := c.CustomerRepo.First(customer, Id)
	return customer, res.Error

}

func (c *AccountService) UpdateCustomerById(cus *account.Customer) (*account.Customer, error) {
	res := c.CustomerRepo.Transaction(func(tx *gorm.DB) error {
		if err := tx.Save(cus).Error; err != nil {
			return err
		}
		return nil
	})
	return cus, res
}
