//  
//  LoginViewModel.swift
//  BankShift
//
//  Created by Parth on 27/08/20.
//  Copyright © 2020 Wednesday. All rights reserved.
//

import Foundation

class LoginViewModel {

    private let service: LoginServiceProtocol

    /// Update the loading status, use HUD or Activity Indicator UI
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }

    /// Showing alert message, use UIAlertController or other Library
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }

    //MARK: -- Closure Collection
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var didGetData: ((User) -> ())?

    init(withLogin serviceProtocol: LoginServiceProtocol = LoginService() ) {
        self.service = serviceProtocol
    }

    //MARK: -- Example Func
    func loginRequest() {
        self.isLoading = true
        self.service.login(success: { (user) in
            self.isLoading = false
            self.didGetData?(user)
        }) {
            ///API failed
            self.alertMessage = "Please enter valid username and password"
        }
    }

}
