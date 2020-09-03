//  
//  LoginModel.swift
//  BankShift
//
//  Created by Parth on 27/08/20.
//  Copyright © 2020 Wednesday. All rights reserved.
//

import Foundation

struct User {
    let username: String!
    let name: String!
    let dateCreated: String!
    var currentPets: [Pet]?
}

struct Pet {
    let id: String!
    let name: String!
    let weight: Double!
    let category: PetCategory!
    let status: PetStatus!
    let photo: (full: String, thumb: String)

}
