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

    
    var logingVm = LoginViewModel.init()
    
    var body: some View {
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
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Error"), message: Text("\(self.logingVm.alertMessage ?? "")"), dismissButton: .default(Text("Ok")))
                    }
                    ActivityIndicator(isAnimating: .constant(true), style: .large)
                    .padding(.top, 30.0)
                }
                    
                .navigationBarTitle("Login")
            }.onAppear {
                self.logingVm.didGetData = { user in
                    
                }
                
                self.logingVm.showAlertClosure = {
                    self.showingAlert = true
                }
            }.onDisappear {
                
            }
            
        }
    }
   
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
