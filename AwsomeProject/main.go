package main

import (
	"fmt"

	"github.com/gin-gonic/gin"
	accountservice "github.com/nguyentrunghieu15/VCS_stage2_SQL/modules/account/accountService"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

func main() {
	host := "localhost"
	port := 5432
	username := "postgre"
	password := "1"
	dbName := "Test"
	dsn := fmt.Sprintf("host=%v user=%v password=%v dbname=%v port=%v", host, username, password, dbName, port)
	db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{})
	if err != nil {
		fmt.Println("Cant connect db")
	} else {
		fmt.Println("Connected database")
	}
	routes := gin.Default()

	accountservice.Init(db, routes)

	routes.Run()
}
