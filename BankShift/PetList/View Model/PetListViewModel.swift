//  
//  PetListViewModel.swift
//  BankShift
//
//  Created by Parth on 31/08/20.
//  Copyright © 2020 Wednesday. All rights reserved.
//

import Foundation

class PetListViewModel:ObservableObject {
    
    private let service: PetListServiceProtocol
    
    @Published var pets = [Pet]()
    
    var alertMessage: String?
    
    //MARK: -- Closure Collection
    var showAlertClosure: ((_ alertMessage:String) -> ())?
    var updateLoadingStatus: ((_ isLoading:Bool) -> ())?
    var didGetAllPets: (([Pet]) -> ())?
    
    init(withLogin serviceProtocol: PetListServiceProtocol = PetListService() ) {
        self.service = serviceProtocol
    }
    
    func getAllAvaiblePets() {
        self.service.getAllPets(success: { (pets) in
            self.updateLoadingStatus?(false)
            self.pets = pets
        }) { (error) in
            ///API failed
            self.showAlertClosure?(error)
            self.updateLoadingStatus?(false)
        }
    }
    
    
}

