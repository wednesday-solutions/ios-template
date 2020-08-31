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
                success(User(username: customer.username, name: customer.name, dateCreated: customer.dateCreated, currentPets: customer.currentPets.compactMap { Pet.init(id: $0.id, name: $0.name, weight: $0.weight, category: $0.category, status: $0.status, photo: (full: $0.photo?.full ?? "", thumb: $0.photo?.thumb ?? ""))}))

            case .failure(let error):
                print("Failure! Error: \(error)")
                failure(error.localizedDescription)
            }
        }
    }
    
    func registerAccount(name:String,username:String,password:String,success: @escaping(_ data: User) -> (), failure: @escaping(_ errorString:String) -> ()) {
        Network.shared.apollo.perform(mutation: CreateAccountMutation(input: CreateAccountInput.init(name: name, username: username, password: password))){
            result in
            switch result {
            case .success(let graphQLResult):
                if let error = graphQLResult.errors?.first?.description {
                    failure(error)
                    return;
                }
                guard let customer = try? result.get().data?.createAccount else { return }
                success(User(username: customer.username, name: customer.name, dateCreated: customer.dateCreated, currentPets: customer.currentPets.compactMap { Pet.init(id: $0.id, name: $0.name, weight: $0.weight, category: $0.category, status: $0.status, photo: (full: $0.photo?.full ?? "", thumb: $0.photo?.thumb ?? ""))}))
            case .failure(let error):
                print("Failure! Error: \(error)")
                failure(error.localizedDescription)
            }
        }
    }
    
}
