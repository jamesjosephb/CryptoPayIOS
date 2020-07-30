//
//  SplashScreen.swift
//  CryptoPay
//
//  Created by JamesJoseph Burch on 6/11/20.
//  Copyright © 2020 James Burch. All rights reserved.
//

import SwiftUI

struct LoadLogin: View {

    @EnvironmentObject var userData: UserData
    @ViewBuilder
    var body: some View {
        if userData.sites.isEmpty {
            LoadingScreen()
        }
        else {
            HomeView()
        }
    }
}



struct LoadPurchases: View {

    @EnvironmentObject var userData: UserData
    @ViewBuilder
    var body: some View {
        //if userData.purchases.isEmpty {
        if userData.sitePurchaseSummary[userData.SelectedSiteID] == nil && userData.sitePurchaseDict[userData.SelectedSiteID] == nil  {
            LoadingScreen()
        }
        else {
            ViewRecentPurchases()
        }
    }
}


struct LoadSwiperConfigurations: View {

    @EnvironmentObject var userData: UserData
    @ViewBuilder
    var body: some View {
        if userData.SelectedSwipers.isEmpty {
            LoadingScreen()
        }
        

        else {
            ViewConfigureDevices()
        }
    }
}









struct LoadingScreen: View {
    var body: some View {
        ZStack {
        LinearGradient(gradient: Gradient(colors: [Color("DarkElectronBlue"), Color("MidGrey")]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
            VStack {
            LoginImage()
            ActivityIndicator().frame(minWidth: 0, maxWidth: 100, minHeight: 0, maxHeight: 100)
            }
        }
    }
}











struct ActivityIndicator: View {
  @State private var isAnimating: Bool = false
 //@Binding var isAnimating: Bool
  var body: some View {
    GeometryReader { (geometry: GeometryProxy) in
      ForEach(0..<5) { index in
        Group {
          Circle()
            .frame(width: geometry.size.width / 5, height: geometry.size.height / 5)
            .scaleEffect(!self.isAnimating ? 1 - CGFloat(index) / 5 : 0.2 + CGFloat(index) / 5)
            .offset(y: geometry.size.width / 10 - geometry.size.height / 2)
          }.frame(width: geometry.size.width, height: geometry.size.height)
            .rotationEffect(!self.isAnimating ? .degrees(0) : .degrees(360))
            .animation(Animation
              .timingCurve(0.5, 0.15 + Double(index) / 5, 0.25, 1, duration: 1.5)
              .repeatForever(autoreverses: false))
        }
      }
    .aspectRatio(1, contentMode: .fit)
    .onAppear {
        self.isAnimating = true
    }
  }
}


