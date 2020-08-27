//  
//  LoginServiceProtocol.swift
//  BankShift
//
//  Created by Parth on 27/08/20.
//  Copyright © 2020 Wednesday. All rights reserved.
//

import Foundation

protocol LoginServiceProtocol {

    func login(success: @escaping(_ data: User) -> (), failure: @escaping() -> ())

}
