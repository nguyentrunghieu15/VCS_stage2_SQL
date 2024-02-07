package accountservice

import (
	"github.com/gin-gonic/gin"
	"github.com/nguyentrunghieu15/VCS_stage2_SQL/modules/account"
	"gorm.io/gorm"
)

func autoMigrate(db *gorm.DB) {
	db.AutoMigrate(&account.Customer{})
}

func Init(db *gorm.DB, route *gin.Engine) error {
	autoMigrate(db)
	accountController := AccountController{AccountService: AccountService{CustomerRepo: CustomerRepo{db: db}}}
	accountGroup := route.Group("/account")
	{
		accountGroup.POST("/create", accountController.createCustomer)
		accountGroup.POST("/udt", accountController.updateCustomer)
		accountGroup.GET(":id", accountController.FindCustomerById)
	}
	return nil
}
