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
                        
                        TextField("Enter Password", text: $passWord)
                            .padding([.top, .leading, .trailing], 30.0)
                            .frame(height: 30,alignment: .center)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Button(action: {
                            ///Api request
                            self.logingVm.loginRequest()
                            
                        }) {
                            Text("Submit")
                        }
                        .padding(.top, 30.0)
                            
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("Bankshift"), message: Text("\(self.logingVm.alertMessage ?? "")"), dismissButton: .default(Text("Ok")))
                        }
                    }
                        
                    .navigationBarTitle("Login")
                }.onAppear {
                    self.logingVm.didGetData = { user in
                        self.showingAlert = true
                        self.logingVm.alertMessage = "Login Successfully"
                    }
                    self.logingVm.updateLoadingStatus = { isLoading in
                        self.showingLoading = isLoading
                    }
                    
                    self.logingVm.showAlertClosure = { _ in
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
