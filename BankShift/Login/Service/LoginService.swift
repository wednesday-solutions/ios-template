//  
//  LoginService.swift
//  BankShift
//
//  Created by Parth on 27/08/20.
//  Copyright © 2020 Wednesday. All rights reserved.
//

import Foundation

class LoginService: LoginServiceProtocol {

    func login(success: @escaping(_ data: User) -> (), failure: @escaping() -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            failure()

            success(User.init(userName: "Test", password: "***", email: "abc@gmail.com", userImage: nil))
            
        }
    }

}
