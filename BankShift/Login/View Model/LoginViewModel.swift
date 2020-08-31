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
    
    //MARK: -- Closure Collection
    var showAlertClosure: ((_ alertMessage:String) -> ())?
    var updateLoadingStatus: ((_ isLoading:Bool) -> ())?
    var didGetData: ((User?) -> ())?

    init(withLogin serviceProtocol: LoginServiceProtocol = LoginService() ) {
        self.service = serviceProtocol
    }

    //MARK: -- Login Func
    func loginRequest(userName:String,password:String) {
        guard userName != "" || password != "" else {
            showAlertClosure?(Constant.error.ENTER_VALID_INFORMATION.rawValue)
            return;
        }
        
        updateLoadingStatus?(true)
        self.service.login(userName:userName,password:password,success: { (user) in
            self.updateLoadingStatus?(false)
            self.didGetData?(user)
        }) { error in
            ///API failed
            self.didGetData?(nil)
            self.showAlertClosure?(error)
            self.updateLoadingStatus?(false)
        }
    }

    //MARK: -- Register Func
    func createAccountRequest(userName:String,password:String,name:String) {
        guard userName != "" || password != "" || name != "" else {
            showAlertClosure?(Constant.error.ENTER_VALID_INFORMATION.rawValue)
            return;
        }
        updateLoadingStatus?(true)
        self.service.registerAccount(name: name, username: userName, password: password, success: { (user) in
            self.updateLoadingStatus?(false)
            self.didGetData?(user)
        }) { (error) in
            ///API failed
            self.showAlertClosure?(error)
            self.updateLoadingStatus?(false)
        }
    }
}
