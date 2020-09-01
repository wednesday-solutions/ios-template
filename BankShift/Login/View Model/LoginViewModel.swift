//  
//  LoginViewModel.swift
//  BankShift
//
//  Created by Parth on 27/08/20.
//  Copyright © 2020 Wednesday. All rights reserved.
//

import Foundation
import Apollo

class LoginViewModel {

    private let service: LoginServiceProtocol

    var alertMessage: String?

    // MARK: - - Closure Collection
    var showAlertClosure: ((_ alertMessage: String) -> Void)?
    var updateLoadingStatus: ((_ isLoading: Bool) -> Void)?
    var didGetData: ((User?) -> Void)?

    init(withLogin serviceProtocol: LoginServiceProtocol = LoginService() ) {
        self.service = serviceProtocol
    }

    // MARK: - - Login Func
    func loginRequest(userName: String, password: String) {
        guard userName != "" || password != "" else {
            showAlertClosure?(Constant.Error.ENTERVALIDINFORMATION.rawValue)
            return
        }

        updateLoadingStatus?(true)
        self.service.login(userName: userName, password: password, success: { (loginData) in
            self.updateLoadingStatus?(false)
            self.didGetData?(self.self.initWithLoginMutuation(loginData))
        }) { error in
            self.showAlertClosure?(error)
            self.updateLoadingStatus?(false)
        }
    }

    // MARK: - - Register Func
    func createAccountRequest(userName: String, password: String, name: String) {
        guard userName != "" || password != "" || name != "" else {
            showAlertClosure?(Constant.Error.ENTERVALIDINFORMATION.rawValue)
            return
        }
        updateLoadingStatus?(true)
        self.service.registerAccount(name: name, username: userName, password: password, success: { (user) in
            self.updateLoadingStatus?(false)
            self.didGetData?(user)
        }) { (error) in
            self.showAlertClosure?(error)
            self.updateLoadingStatus?(false)
        }
    }

    func initWithLoginMutuation(_ login: LoginRequestMutation.Data!) -> User? {
        if let customer = login.logIn.customer {
            let pets = customer.currentPets.compactMap { Pet.init(id: $0.id, name: $0.name, weight: $0.weight, category: $0.category, status: $0.status, photo: (full: $0.photo?.full ?? "", thumb: $0.photo?.thumb ?? ""))}
            let user = User(username: customer.username, name: customer.name, dateCreated: customer.dateCreated, currentPets: pets)
            return user
        } else {
            return nil
        }

    }

}
