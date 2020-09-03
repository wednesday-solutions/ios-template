//  
//  PetListServiceProtocol.swift
//  BankShift
//
//  Created by Parth on 31/08/20.
//  Copyright © 2020 Wednesday. All rights reserved.
//

import Foundation

protocol PetListServiceProtocol {

    func getAllPets(success: @escaping ([Pet]) -> Void, failure: @escaping (_ errorString: String) -> Void)
}
