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
        //print("FingersCrossed")
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
//        while userData.sites != nil {
//            if userData.sites!.OwnerID == nil {
//                print("Invalid Login!")
//            }
//            else if userData.sites!.MPMs.count < 1 {
//            viewRouter.currentPage = "page2"
//            }
//            else {
//                for MPM in userData.sites!.MPMs {
//                    userData.getSiteInfo(MPM)
//                    while self.userData.siteInfo != nil {
//                        print("happening")
//                        self.userData.setSiteInfoList(MPM, self.userData.siteInfo!)
//                        //self.userData.siteInfo = nil
//                    }
//                viewRouter.currentPage = "page2"
//                }
//            }
//            viewRouter.currentPage = "page2"
//        }
    }
    
    
    
    var body: some View {
        ZStack {
            //Color("backgroundBlue")
            LinearGradient(gradient: Gradient(colors: [Color("DarkElectronBlue"), Color("MidGrey")]), startPoint: .topLeading, endPoint: .bottomTrailing)
            //RadialGradient(gradient: Gradient(colors: [backgroundBlue, .white]), center: .center, startRadius: 60, endRadius: 300)
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
//                Button(action: {self.Login()}) {
                Button(action: {self.Login()}) {
                Text("LOGIN")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    //.frame(width: 220, height: 60)
                    .background(Color("MintLeaf"))
                    .cornerRadius(15.0)
                }
                
            }
            .padding()
            //.background(Color.green)
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
            //.resizable()
            //.aspectRatio(contentMode: .fill)
            //.frame(width: 150, height: 150)
            //.clipped()
            //.cornerRadius(150)
            //.padding(.bottom, 75)
    }
}




//    ForEach(userData.sites) { MPM in



//    Button(action: {userData.SelectedSite = MPM}) {
//        VStack {
//        Text(MPM.sitename)
//        .lineLimit(1)
//        //.fixedSize(horizontal: false, vertical: true)
//        .foregroundColor(.gray)
//        .font(.headline)
//        Text(MPM.siteID)
//        .foregroundColor(.gray)
//        .font(.subheadline)
//            }.padding(.top, 30)
//    }





//ForEach(userData.sites) { MPM in
//    Button(action: {userData.SelectedSite = MPM}) {
//        Text(MPM.sitename)
//        .lineLimit(1)
//        //.fixedSize(horizontal: false, vertical: true)
//        .foregroundColor(.gray)
//        .font(.headline)
//        Text(MPM.siteID)
//        .foregroundColor(.gray)
//        .font(.subheadline)
//    }.padding(.top, 30)
//
//
//
//
//
//
//{
//    Text(MPM.sitename)
//    .lineLimit(1)
//    //.fixedSize(horizontal: false, vertical: true)
//    .foregroundColor(.gray)
//    .font(.headline)
//    Text(MPM.siteID)
//    .foregroundColor(.gray)
//    .font(.subheadline)
//}
//.padding(.top, 30)
