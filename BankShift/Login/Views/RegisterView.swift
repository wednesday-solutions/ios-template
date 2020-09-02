//
//  RegisterView.swift
//  BankShift
//
//  Created by Parth on 28/08/20.
//  Copyright © 2020 Wednesday. All rights reserved.
//

import SwiftUI

struct RegisterView: View {
    @State var userName: String = ""
    @State var name: String = ""
    @State var passWord: String = ""
    @State var showingAlert = false
    @State var showingLoading = false
    @State var alert = ""
    @State var successFullyLogin = false

    var logingVm = LoginViewModel.init()

    var body: some View {
        ZStack {
            VStack {
                VStack(alignment: .center, spacing: 15.0) {
                    TextField("Enter Name", text: $name)
                        .padding([.top, .leading, .trailing], 30.0)
                    .frame(height: 30, alignment: .center)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                    TextField("Enter Username", text: $userName)
                        .padding([.top, .leading, .trailing], 30.0)
                        .frame(height: 30, alignment: .center)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    SecureField("Enter Password", text: $passWord)
                        .padding([.top, .leading, .trailing], 30.0)
                        .frame(height: 30, alignment: .center)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    Button(action: {
                        self.logingVm.createAccountRequest(userName: self.userName, password: self.passWord, name: self.name)

                    }) {
                        Text("Submit")
                    }
                    .padding(.top, 30.0)

                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Bankshift"), message: Text(alert), dismissButton: .default(Text("Ok")))
                    }
                    NavigationLink(destination: PetList(), isActive: self.$successFullyLogin) {
                        EmptyView()
                    }.hidden()

                }.onAppear {
                    self.logingVm.didGetData = { user in
                        self.successFullyLogin = true
                    }
                    self.logingVm.updateLoadingStatus = { isLoading in
                        self.showingLoading = isLoading
                    }

                    self.logingVm.showAlertClosure = { alert in
                        self.alert = alert
                        self.showingAlert = true
                    }
                }

            }

            ActivityIndicator(isAnimating: .constant(showingLoading), style: .large)
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
