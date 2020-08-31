//  
//  PetListService.swift
//  BankShift
//
//  Created by Parth on 31/08/20.
//  Copyright © 2020 Wednesday. All rights reserved.
//

import Foundation

class PetListService: PetListServiceProtocol {
    func getAllPets(success: @escaping ([Pet]) -> (), failure: @escaping (_ errorString:String) -> ()) {
        
        Network.shared.apollo.fetch(query: GetAllPetsQuery.init(status: .available)) { (result) in
            switch result {
            case .success(let graphQLResult):
                if let error = graphQLResult.errors?.first?.description {
                    failure(error)
                    return;
                }
                guard let pets = try? result.get().data?.allPets else { return }
                let petArray = pets.compactMap{ Pet(id: $0.id, name: $0.name, weight: $0.weight, category: $0.category, status: $0.status, photo: (full: $0.photo?.full ?? "", thumb: $0.photo?.thumb ?? ""))}
                success(petArray)
            case .failure(let error):
                print("Failure! Error: \(error)")
                failure(error.localizedDescription)
            }
        }
    }
    
}
