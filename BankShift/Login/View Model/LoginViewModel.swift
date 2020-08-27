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

    var alertMessage: String?
    
    //MARK: -- Closure Collection
    var showAlertClosure: ((_ alertMessage:String) -> ())?
    var updateLoadingStatus: ((_ isLoading:Bool) -> ())?
    var didGetData: ((User) -> ())?

    init(withLogin serviceProtocol: LoginServiceProtocol = LoginService() ) {
        self.service = serviceProtocol
    }

    //MARK: -- Example Func
    func loginRequest() {
        updateLoadingStatus?(true)
        self.service.login(success: { (user) in
            self.updateLoadingStatus?(false)
            self.didGetData?(user)
        }) {
            ///API failed
            self.updateLoadingStatus?(true)
        }
    }

}
