package accountservice

import "github.com/nguyentrunghieu15/VCS_stage2_SQL/modules/account"

type AccountService struct {
	CustomerRepo CustomerRepo
}

func (c *AccountService) CreateCustomer(cus *account.Customer) (*account.Customer, error) {
	return c.CustomerRepo.CreateCustomer(cus)
}

func (c *AccountService) FindCustomerById(Id uint) (account.Customer, error) {
	return c.CustomerRepo.FindCustomerById(Id)
}

func (c *AccountService) UpdateCustomerById(cus account.Customer) (account.Customer, error) {
	return c.CustomerRepo.UpdateCustomerById(cus)
}
