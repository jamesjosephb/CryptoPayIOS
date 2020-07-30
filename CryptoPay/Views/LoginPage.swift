//
//  LoginPage.swift
//  CryptoPay
//
//  Created by JamesJoseph Burch on 6/6/20.
//  Copyright © 2020 James Burch. All rights reserved.
//

import SwiftUI

import Foundation
struct LoginPage: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var userData: UserData
    @State private var showingInvalidLogin = false
    @State private var InvalidLoginMessage = ""
    @State private var UserName: String = "dswashes"
    @State private var PassWord: String = "dswashes"
    @State private var saveLoginInfo = false
    
    func Login() {
        if UserName.count < 5 {
            InvalidLoginMessage = "Invalid Username character length"
            showingInvalidLogin = true
            
        }
        else if UserName != PassWord {
            InvalidLoginMessage = "Invalid Username and Password Combination"
            showingInvalidLogin = true
        }
        else {
            
            userData.getLogin(UserName.replacingOccurrences(of: " ", with: "%20"))
            viewRouter.currentPage = "page2"
        }
    }
    
    
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("DarkElectronBlue"), Color("MidGrey")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
                //.opacity(0.57)
            VStack {
                LoginImage()
                HStack {
                Spacer()
                Text("Innovative Payment Solutions")
                    .fontWeight(.semibold)
                }
                .padding(.bottom, 60)
                TextField("Enter your Username", text: $UserName)
                    .padding()
                    .background(Color("lightGreyColor"))
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                SecureField("Enter your Password", text: $PassWord)
                    .padding()
                    .background(Color("lightGreyColor"))
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                
                Toggle(isOn: $saveLoginInfo) {
                    Text("Save Login Credentials")
                }
                Button(action: {self.Login()}) {
                Text("LOGIN")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color("MintLeaf"))
                    .cornerRadius(15.0)
                }
                
            }
            .padding()
        }.alert(isPresented: $showingInvalidLogin) { Alert(title: Text("Login Failed"), message: Text(self.InvalidLoginMessage), dismissButton: .default(Text("Okay")))}
    }
}




struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage().environmentObject(ViewRouter())
    }
}

struct LoginImage: View {
    var body: some View {
        Image("CryptoPayLogo")
    }
}


