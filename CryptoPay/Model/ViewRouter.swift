//
//  ViewRouter.swift
//  CryptoPay
//
//  Created by JamesJoseph Burch on 6/6/20.
//  Copyright © 2020 James Burch. All rights reserved.
//

import Foundation
import Combine
import SwiftUI



//https://www.hackingwithswift.com/quick-start/swiftui/how-to-use-objectbinding-to-create-object-bindings
//https://www.blckbirds.com/post/how-to-navigate-between-views-in-swiftui-by-using-an-bindableobject

class ViewRouter: ObservableObject {
    
    let objectWillChange = PassthroughSubject<ViewRouter,Never>()
    
    var currentPage: String = "page1" {
        didSet {
            objectWillChange.send(self)
        }
    }
    
    

    
//    //ViewSiteStatus, RecentPurchases
//    var TabViewSelection: String = "ViewSiteStatus" {
//        didSet {
//            objectWillChange.send(self)
//        }
//    }
//}

}
