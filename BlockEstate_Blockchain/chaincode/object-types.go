/*
 * SPDX-License-Identifier: Apache-2.0
 */

package main

// Define structs to be used by chaincode

type User struct {
	UserID    string `json:"userId,required"`
	Name      string `json:"name"`
	Password  string `json:"password,required"`
	Address   string `json:"address"`
	Phone     string `json:"phone"`
	Email     string `json:"email"`
	PaymentID string `json:"paymentID"`
	Timestamp string `json:"timeStamp"`
}

type Employee struct {
	FirstName string `json:"firstName"`
	LastName  string `json:"lastName"`
	PropID        string `json:"PropID"`
	Type    string `json:"Type"`
	// DOB       string `json:"dob"`
	Price string `json:"Price"`
	Mobile    string `json:"mobile"`
	Address   string `json:"address"`
}

type EmpPrivateData struct {
	PropID        string `json:"PropID"`
	IdType string `json:"idType"`
	NationalID string `json:"nationalID"`
	Dob string `"json:dob"`
	ImageUrl string`"json:imageUrl"`
}