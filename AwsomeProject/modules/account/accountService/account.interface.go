package accountservice

import (
	"github.com/nguyentrunghieu15/VCS_stage2_SQL/modules/account"
	"gorm.io/gorm"
)

type CustomerSchema struct {
	Fname    string `json:"first_name"`
	Lname    string `json:"last_name"`
	Email    string `json:"email"`
	Password string `json:"password"`
	Street   string `json:"street"`
	City     string `json:"city"`
	State    string `json:"state"`
	Zipcode  string `json:"zipcode"`
}

func CreateCustomerObj(v CustomerSchema) *account.Customer {
	return &account.Customer{
		Fname:    v.Fname,
		Lname:    v.Lname,
		Email:    v.Email,
		Password: v.Password,
		City:     v.City,
		Street:   v.Street,
		State:    v.State,
		Zipcode:  v.Zipcode,
	}
}

type CustomerUdtSchema struct {
	Id       uint   `json:"id"`
	Fname    string `json:"first_name"`
	Lname    string `json:"last_name"`
	Email    string `json:"email"`
	Password string `json:"password"`
	Street   string `json:"street"`
	City     string `json:"city"`
	State    string `json:"state"`
	Zipcode  string `json:"zipcode"`
}

func CreateCustomerUdtObj(v CustomerUdtSchema) account.Customer {
	return account.Customer{
		Model:    gorm.Model{ID: v.Id},
		Fname:    v.Fname,
		Lname:    v.Lname,
		Email:    v.Email,
		Password: v.Password,
		City:     v.City,
		Street:   v.Street,
		State:    v.State,
		Zipcode:  v.Zipcode,
	}
}
