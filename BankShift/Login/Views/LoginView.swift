//
//  ContentView.swift
//  BankShift
//
//  Created by Parth on 27/08/20.
//  Copyright © 2020 Wednesday. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    
    @State var userName: String = ""
    @State var passWord: String = ""
    @State var showingAlert = false
    @State var showingLoading = false
    @State var alert = ""
    @State var successFullyLogin = false
    
    var logingVm = LoginViewModel.init()
    
    var body: some View {
        ZStack {
            VStack {
                NavigationView {
                    VStack(alignment: .center, spacing: 15.0) {
                        TextField("Enter Username", text: $userName)
                            .padding(.horizontal, 30.0)
                            .frame(height: 30,alignment: .center)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .accessibility(identifier: "loginUserName")
            
                        
                        SecureField("Enter Password", text: $passWord)
                            .padding([.top, .leading, .trailing], 30.0)
                            .frame(height: 30,alignment: .center)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .accessibility(identifier: "loginPassword")
                        
                        VStack(alignment: .center, spacing: 30.0) {
                            Button(action: {
                                ///Api request
                                self.logingVm.loginRequest(userName: self.userName, password: self.passWord)
                                
                            }) {
                                Text("Submit")
                            }
                            .accessibility(identifier: "btnLoginSubmit")

                            NavigationLink(destination: RegisterView()) {
                                Text("Create Account")
                            }
                            .padding(.top, 30.0)
                                
                        }
                        .padding(.top, 30.0)
                        
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("Bankshift"), message: Text(alert), dismissButton: .default(Text("Ok")))
                        }
                        
                        NavigationLink(destination: PetList(), isActive: self.$successFullyLogin) {
                           EmptyView()
                         }.hidden()
                    }
                        
                    .navigationBarTitle("Login",displayMode: .inline)
                    
                }.onAppear {
                    self.logingVm.didGetData = { user in
                        guard let _ = user else { return }
                        self.successFullyLogin = true
                    }
                    self.logingVm.updateLoadingStatus = { isLoading in
                        self.showingLoading = isLoading
                    }
                    
                    self.logingVm.showAlertClosure = { alert in
                        self.alert = alert
                        self.showingAlert = true
                    }
                }.onDisappear {
                    
                }
                
            }
            
            
            ActivityIndicator(isAnimating: .constant(showingLoading), style: .large)
            
        }
    }
   
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
