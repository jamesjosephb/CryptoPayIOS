//
//  MotherView.swift
//  CryptoPay
//
//  Created by JamesJoseph Burch on 6/6/20.
//  Copyright © 2020 James Burch. All rights reserved.
//

import Foundation
import SwiftUI

struct MotherView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    
    var body: some View {
        VStack {
            if viewRouter.currentPage == "page1" {
                LoginPage()
            } else if viewRouter.currentPage == "page2" {
                LoadLogin()
            } else if viewRouter.currentPage == "page3" {
                HomeView()
            }
        }
    }
}



struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView().environmentObject(ViewRouter())
    }
}



//struct FatherView: View {
//    @EnvironmentObject var viewRouter: ViewRouter
//
//
//    var body: some View {
//        VStack {
//            if viewRouter.TabViewSelection == "ViewSiteStatus" {
//                LoginPage()
//            } else if viewRouter.TabViewSelection == "RecentPurchases" {
//                HomeView()
//            }
//        }
//    }
//}
