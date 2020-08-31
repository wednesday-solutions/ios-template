//
//  PetList.swift
//  BankShift
//
//  Created by Parth on 31/08/20.
//  Copyright © 2020 Wednesday. All rights reserved.
//

import SwiftUI
import Combine

struct PetList: View {
    
    @ObservedObject var petListVM = PetListViewModel.init()
    @State var isLoading = false
    

    var body: some View {
        VStack {
            List(petListVM.pets,id: \.name) { Row(pet: $0) }
            ActivityIndicator(isAnimating: .constant(isLoading), style: .large)
            
        }.onAppear {
            self.petListVM.getAllAvaiblePets()
            self.petListVM.updateLoadingStatus = { isLoading in
                self.isLoading = isLoading
            }

        }

    }
}


struct Row : View {
    var pet: Pet
    var body: some View {
        HStack {
            Text(pet.name)
        }
    }
}

struct PetList_Previews: PreviewProvider {
    static var previews: some View {
        PetList()
    }
}
