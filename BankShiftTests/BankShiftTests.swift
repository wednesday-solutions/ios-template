//
//  BankShiftTests.swift
//  BankShiftTests
//
//  Created by Parth on 27/08/20.
//  Copyright © 2020 Wednesday. All rights reserved.
//

import XCTest
@testable import BankShift

class BankShiftTests: XCTestCase {
    
    let loginVm = LoginViewModel.init()
    var currentUser:User!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        currentUser = nil
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoginViewModel() throws {
        //        loginFlow(username: "test", password: "123456")
        loginFlow(username: "Test", password: "test")
    }
    
    func testRegisterViewModel() throws {
        register(username: "Parth1234", password: "123456", name: "test")
    }
   
    
    func getAllPets() {
        var pets:[Pet]!
        let petExpectation = expectation(description: "pets")
        let petVm = PetListViewModel.init()
        petVm.getAllAvaiblePets()
        petVm.didGetAllPets = { petArray in
            pets = petArray
            petExpectation.fulfill()
        }
        petVm.showAlertClosure = { error in
            petVm.alertMessage = error
            petExpectation.fulfill()
        }
        waitForExpectations(timeout: 10) { (error) in
            XCTAssertNotNil(pets,self.loginVm.alertMessage ?? "")
        }
    }
    
    func register(username:String,password:String,name:String) {
        let userExpectation = expectation(description: "user")
        loginVm.createAccountRequest(userName: username, password: password, name: name)
        loginVm.didGetData = { user in
            self.currentUser = user
            userExpectation.fulfill()
        }
        loginVm.showAlertClosure = { error in
            self.loginVm.alertMessage = error
            userExpectation.fulfill()
        }
        waitForExpectations(timeout: 10) { (error) in
            XCTAssertNotNil(self.currentUser,self.loginVm.alertMessage ?? "")
        }
    }
   
    func loginFlow(username:String,password:String) {
        let userExpectation = expectation(description: "user")
        loginVm.loginRequest(userName: username, password: password)
        loginVm.didGetData = { user in
            self.currentUser = user
            userExpectation.fulfill()
        }
        loginVm.showAlertClosure = { error in
            self.loginVm.alertMessage = error
            userExpectation.fulfill()
        }
        waitForExpectations(timeout: 10) { (error) in
            XCTAssertNotNil(self.currentUser,self.loginVm.alertMessage ?? "")
        }
    }
    

}
