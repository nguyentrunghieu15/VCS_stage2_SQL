package accountservice

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

type AccountController struct {
	AccountService AccountService
}

func (t *AccountController) createCustomer(tx *gin.Context) {
	var param CustomerSchema
	tx.ShouldBindJSON(&param)
	c, e := t.AccountService.CreateCustomer(CreateCustomerObj(param))
	if e != nil {
		tx.JSON(http.StatusBadRequest, gin.H{"error": e.Error()})
		return
	}
	tx.JSON(http.StatusOK, gin.H{"message": "Customer created", "data": c})
}

func (t *AccountController) updateCustomer(tx *gin.Context) {
	var param CustomerUdtSchema
	tx.ShouldBindJSON(param)

	_, e := t.AccountService.UpdateCustomerById(CreateCustomerUdtObj(param))
	if e != nil {
		tx.JSON(http.StatusBadRequest, gin.H{"error": e.Error()})
		return
	}
	tx.JSON(http.StatusOK, gin.H{"message": "Customer created"})
}

func (t *AccountController) FindCustomerById(tx *gin.Context) {
	var id uint
	tx.ShouldBindUri(id)

	r, e := t.AccountService.FindCustomerById(id)

	if e != nil {
		tx.JSON(http.StatusNotFound, gin.H{"error": e.Error()})
		return
	}

	tx.JSON(http.StatusOK, gin.H{"data": r})
}
