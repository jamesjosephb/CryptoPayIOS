//
//  DataModel.swift
//  CryptoPay
//
//  Created by JamesJoseph Burch on 6/6/20.
//  Copyright © 2020 James Burch. All rights reserved.
//

import Foundation
//https://www.hackingwithswift.com/quick-start/ios-swiftui/working-with-identifiable-items-in-swiftui

func load<T: Decodable>(_ data: Data, as type: T.Type = T.self) -> T {
    
    //let data = json.data(using: .utf8)!
    do {
        
        let decoder = JSONDecoder()
        let dataString = String(data: data, encoding: String.Encoding.utf8) ?? "Data could not be printed"
        print(dataString)
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(data) as \(T.self):\n\(error)")
    }
}

//
//struct Sites: Codable {
//    var MPMs: Array<String>
//    var OwnerID: Int
//}

//struct SwipersList: Codable {
//    var Swipers = [Swipers]()
//}



//struct SwiperConfig: Codable {
//    var Amex: String
//    var BnsCoin: Int
//    var MaxCh: Int
//    var MinCh: Int
//    var PrchTyp: String
//    var Rate: Int
//    var SwiperName: String
//    var SwiperProfile: String
//}

struct PurchaseSummaryValues {
    var TotalLastMonth = 0
    var TotalMonthToDate = 0
    var TotalYesterday = 0
    var TotalToday = 0
}


struct PurchaseList: Decodable {
    var purchases: [Purchase]
    //func getPurchases() -> [Purchase] {return self.purchases}
}

struct Purchase: Codable, Identifiable, Equatable{
    let id = UUID()
    var cpid: Int
    var name: String
    var purchaseid: Int
    var siteid: String
    var time: String
    var totalcharge: Int
    var transid: String?
    var transidfinal: String?
}

struct TransactionList: Codable {
    var transactions: [Transactions]
}

struct Transactions: Codable, Identifiable {
    let id = UUID()
    var charge: Int
    var macaddr: String
    var purchtype: Int
}

struct SiteInfo: Codable {
    var address1: String?
    var city: String?
    var mqxversion: Int?
    //var setupcomplete: String?
    var sitename: String?
    var state: String?
    var timezone: String?
    var zip: String?
}

struct CoordinatorStatus: Codable {
    //var sitedowndate: String
    var sitedownstat: String
    var sitepurchemail: String
    var sitepurchstat: String
}

struct AlarmConctacts: Codable {
    var email1: String?
    var email2: String?
    var email3: String?
}

struct LoginResponce: Codable {
    var OwnerID: Int
    var SiteArray: [Sites]
}

//struct Swipers: Codable, Identifiable {
//    let id = UUID()
//    //var swiper: Swiper?
//    //var config: SwiperConfig?
//
//    var lastcontact: String
//    var macaddr: String
//    var name: String
//
//    var Amex: String
//    var BnsCoin: Int
//    var MaxCh: Int
//    var MinCh: Int
//    var PrchTyp: String
//    var Rate: Int
//    var SwiperName: String
//    var SwiperProfile: String
//}


struct Swiper: Codable, Identifiable, Equatable {
    let id = UUID()
    var lastcontact: String
    var macaddr: String
    var name: String
    var Amex: String
    var BnsCoin: Int
    var MaxCh: Int
    var MinCh: Int
    var PrchTyp: String
    var Rate: Int
    //var SwiperName: String
    var SwiperProfile: String
}

struct Sites: Codable, Identifiable {
    let id = UUID()
    var siteID: String?
    var Swipers: [Swiper]?
    //var sitedowndate: String?
    var sitedownstat: String?
    var sitepurchemail: String?
    var sitepurchstat: String?
    var address1: String?
    var city: String?
    var mqxversion: Int?
    //var setupcomplete: String?
    var sitename: String?
    var state: String?
    var timezone: String?
    var zip: String?
}
