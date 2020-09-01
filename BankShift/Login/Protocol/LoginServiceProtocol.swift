//  
//  LoginServiceProtocol.swift
//  BankShift
//
//  Created by Parth on 27/08/20.
//  Copyright © 2020 Wednesday. All rights reserved.
//

import Foundation

protocol LoginServiceProtocol {

    func login(userName: String!, password: String, success: @escaping(_ data: LoginRequestMutation.Data?) -> Void, failure: @escaping(_ errorString: String) -> Void)
    func registerAccount(name: String, username: String, password: String, success: @escaping(_ data: User) -> Void, failure: @escaping(_ errorString: String) -> Void)

}
