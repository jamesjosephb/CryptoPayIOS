//
//  HomeView.swift
//  CryptoPay
//
//  Created by JamesJoseph Burch on 6/6/20.
//  Copyright © 2020 James Burch. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var viewRouter: ViewRouter
    @State private var TabFunctionSelected = "View Site Status"
    
    @State private var loadingTest = false
    
    
    @State private var ShowSites = true
    
    
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack {
                    Button(action: {self.viewRouter.currentPage = "page1"}) {
                        Text("Logout")
        
                        
                        //.underline()
                            .font(.caption)
                            .foregroundColor(Color("DarkGrey"))
                            //.padding(.bottom, 5)
                        //.background(Color("DarkElectronBlue"))
                        //.cornerRadius(4.0)
                        
                    }.padding(.leading, 7)
                    Spacer()
                    SiteSelection(ShowSites: $ShowSites)
                    Spacer()
                    Button(action: {self.loadingTest.toggle()}) {
                        Text("Account")
                        //.underline()
                            .font(.caption)
                            .foregroundColor(Color("DarkGrey"))
                            //.padding(.bottom, 5)
                        //.background(Color("DarkElectronBlue"))
                        //.cornerRadius(4.0)
                    }.padding(.trailing, 7)
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(Color("lightGreyColor"))
                //.edgesIgnoringSafeArea(.all)
                Divider()
                
                
                
                
            VStack {
                TabView(selection: $TabFunctionSelected) {
                    ViewSiteStatus().tabItem {
                        //Image(systemName: "house")
                        Image("Home")
                        //Text("Site Status")
                        }.tag("View Site Status")
                    LoadPurchases().tabItem {
                        Image("DollarSign")
                        //Text("Purchases")
                        }.tag("Recent Purchases")
                    LoadSwiperConfigurations().tabItem {
                        Image("Gear")
                        //Image(systemName: "gear")
                        //Text("Configure")
                        }.tag("Configure Devices")
                    ViewAddNewSite().tabItem {
                        //Image(systemName: "add")
                        Image("Add")
                        //Text("Add Site")//.foregroundColor(Color("DarkGrey"))
                        }.tag("Add a New Site")
                    
                }//.onAppear { UITableView.appearance().separatorStyle = .none }
                //.background(Color("lightGreyColor"))
                    .foregroundColor(Color.black)
            }
        }
        if self.ShowSites {
            VisualEffectView(effect: UIBlurEffect(style: .dark))
            .edgesIgnoringSafeArea(.all)
            ShowSitesMenu(ShowSites: $ShowSites)
            
            }
            
        }
        
    }
        
}












































struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}


     


        

    



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
