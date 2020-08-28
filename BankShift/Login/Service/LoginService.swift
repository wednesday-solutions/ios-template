//  
//  LoginService.swift
//  BankShift
//
//  Created by Parth on 27/08/20.
//  Copyright © 2020 Wednesday. All rights reserved.
//

import Foundation

class LoginService: LoginServiceProtocol {
    
    func login(userName:String!,password:String,success: @escaping(_ data: User) -> (), failure: @escaping(_ errorString:String) -> ()) {
        Network.shared.apollo.perform(mutation: LoginRequestMutation.init(username: userName, password: password)){
            result in
            switch result {
            case .success(let graphQLResult):
                if let error = graphQLResult.errors?.first?.description {
                    failure(error)
                    return;
                }
                guard let customer = try? result.get().data?.logIn.customer else { return }
                success(User(username: customer.username, name: customer.name, dateCreated: customer.dateCreated))
            case .failure(let error):
                print("Failure! Error: \(error)")
                failure(error.localizedDescription)
            }
        }
    }
    
}
