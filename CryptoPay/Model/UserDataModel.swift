//
//  UserDataModel.swift
//  CryptoPay
//
//  Created by JamesJoseph Burch on 6/6/20.
//  Copyright © 2020 James Burch. All rights reserved.
//

import Foundation
import Combine

public protocol LosslessStringConvertible: CustomStringConvertible {
  init? (_ description: String)
}

public protocol CustomStringConvertible {
  var description: String { get }
}

class UserData: ObservableObject {

    @Published var errorMessage = ""
    @Published var SelectedSiteID = ""
    @Published var SelectedSwipers = [Swiper]()
    @Published var Selectedsitedownstat = ""
    @Published var Selectedsitepurchemail = ""
    @Published var Selectedsitepurchstat = ""
    @Published var Selectedaddress = ""
    @Published var Selectedcity = ""
    @Published var Selectedsitename = ""
    @Published var Selectedstate = ""
    @Published var Selectedtimezone = ""
    @Published var Selectedzip = ""
    @Published var purchases = [Purchase]()
    @Published var transactions = [Transactions]()
    @Published var siteInfo: SiteInfo?
    @Published var coordinatorStatus: CoordinatorStatus?
    @Published var alarmContacts: AlarmConctacts?
    @Published var sites = [Sites]()
    @Published var FilteredPurchasesArray = [Purchase]()
    @Published var siteInfoDict: [String: SiteInfo] = [:]
    @Published var sitePurchaseDict = [String: [Purchase]]()
    @Published var sitePurchaseSummary = [String: PurchaseSummaryValues]()

    func setFilteredPurchaseArray() {
        FilteredPurchasesArray = sitePurchaseDict[SelectedSiteID]!
    }

    func getSwiperName(_ SwiperMac: String) -> String {
        var name = SwiperMac
        for swiper in SelectedSwipers where swiper.macaddr == SwiperMac {
            name = swiper.name
        }
        return name
    }

    func filterTransactionsByDate(ArraytoFilter: [Purchase], StartDate: Date, EndDate: Date) -> [Purchase] {
        var filteredDate = [Purchase]()
        for purchase in ArraytoFilter {
            let purchDate = getDateTime(purchase.time)
            if purchDate > StartDate && purchDate <= EndDate {
                filteredDate.append(purchase)
            }
        }
        //print(filteredDate)
        return filteredDate
    }

    func getDateTime(_ strDateTime: String) -> Date {
        let DateTime = String(strDateTime.dropFirst(5))
        let formatter = DateFormatter()
        //formatter.dateStyle = .medium
        //formatter.timeStyle = .medium
        formatter.dateFormat = "dd MM yyyy HH:mm:ss Z"
        return formatter.date(from: DateTime)!

    }

    func getDate(_ dateTime: String) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        let DateTime = getDateTime(dateTime)
        return formatter.string(from: DateTime)
    }

    func getTime(_ dateTime: String) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        let DateTime = getDateTime(dateTime)
        return formatter.string(from: DateTime)
    }

    func isConnected(_ strDateTime: String) -> Bool { //Checks to see if date is greater then the last 24 hours.
        let lastConnected = getDateTime(strDateTime)

        let dayAgo = DateComponents(calendar: Calendar.current, year: 2019, month: 11, day: 2, hour: 00, minute: 00, second: 00).date!

        if lastConnected > dayAgo {
            return true
        } else {
            return false
        }
    }

    func getLogin(_ userName: String) {
        //let userName = "dswashes"
        let searchString = "/login=" + userName
        NetworkRequests().getSearchResults(searchString) { results, errorMessage in
            let jsonData = load(results, as: LoginResponce.self)
            self.sites = jsonData.SiteArray
            if !errorMessage.isEmpty {
                self.errorMessage = ("Search error: " + errorMessage)
            }
        }
    }

    func getAlarmConctacts() {
        NetworkRequests().getSearchResults("/alarmcontacts=MPM084938123") { results, errorMessage in
            self.alarmContacts = load(results, as: AlarmConctacts.self)
            if !errorMessage.isEmpty {
                self.errorMessage = ("Search error: " + errorMessage)
            }
        }
    }

    func getCoordinatorStatus() {
        let searchString = "/coordinatorstatus=" + self.SelectedSiteID
        NetworkRequests().getSearchResults(searchString) { results, errorMessage in
            self.coordinatorStatus = load(results, as: CoordinatorStatus.self)
            //print(self.coordinatorStatus)
            if !errorMessage.isEmpty {
                self.errorMessage = ("Search error: " + errorMessage)
            }
        }
    }

    func getSiteInfo() {
        let searchString = "/siteinfo=" + self.SelectedSiteID
        NetworkRequests().getSearchResults(searchString) { results, errorMessage in
            self.siteInfo = load(results, as: SiteInfo.self)
            //print(self.siteInfo)
            if !errorMessage.isEmpty {
                self.errorMessage = ("Search error: " + errorMessage)
            }
        }
    }

    func getSiteInfo(_ MPM: String, _ AddtoDict: String) {
        self.siteInfo = nil
        let searchString = "/siteinfo=" + MPM
        NetworkRequests().getSearchResults(searchString) { results, errorMessage in
            self.siteInfo = load(results, as: SiteInfo.self)
            if AddtoDict == "Yes" {
                //self.setSiteInfoDict(MPM, self.siteInfo!)
                self.siteInfoDict = [MPM: self.siteInfo!]
            }
            //print(self.siteInfo)
            if !errorMessage.isEmpty {
                self.errorMessage = ("Search error: " + errorMessage)
            }
        }
    }

    func getTransactions(_ purchID: String) {
        let search = "/transaction="
        NetworkRequests().getSearchResults(search+purchID) { results, errorMessage in
            let transactionList = load(results, as: TransactionList.self)
            self.transactions = transactionList.transactions

            if !errorMessage.isEmpty {
                self.errorMessage = ("Search error: " + errorMessage)
            }
        }
    }

    func getPurchaseList() {
        //self.purchases.removeAll()
        let search = "/purchases="
        NetworkRequests().getSearchResults(search+self.SelectedSiteID) { results, errorMessage in
            let purchasesList = load(results, as: PurchaseList.self)
            let site = self.SelectedSiteID
            let purchases = purchasesList.purchases
            self.sitePurchaseDict.updateValue(purchases, forKey: site)
            self.getPurchaseSummary()
            //print(self.purchases)
            if !errorMessage.isEmpty {
                self.errorMessage = ("Search error: " + errorMessage)
            }
        }
    }

    func getPurchaseSummary() {
            var TotalLastMonth = 0
            var TotalMonthToDate = 0
            var TotalYesterday = 0
            var TotalToday = 0

            let currentEndOfDay = DateComponents(calendar: Calendar.current, year: 2019, month: 11, day: 1, hour: 24, minute: 60, second: 00).date!
            let beginningOfDay = Calendar.current.date(byAdding: .hour, value: -24, to: currentEndOfDay)!
            var TotalAmount = 0
                for purchase in filterTransactionsByDate(ArraytoFilter: sitePurchaseDict[self.SelectedSiteID]!, StartDate: beginningOfDay, EndDate: currentEndOfDay) {
                TotalAmount += purchase.totalcharge

            }
            TotalToday = TotalAmount

            let endOfYesterday = Calendar.current.date(byAdding: .day, value: -1, to: currentEndOfDay)!
            let bigginingOfYesterday = Calendar.current.date(byAdding: .hour, value: -24, to: endOfYesterday)!
            TotalAmount = 0
            for purchase in filterTransactionsByDate(ArraytoFilter: sitePurchaseDict[self.SelectedSiteID]!, StartDate: bigginingOfYesterday, EndDate: endOfYesterday) {
                TotalAmount += purchase.totalcharge
            }
            TotalYesterday = TotalAmount

            var dateComponents = Calendar.current.dateComponents(Set(arrayLiteral: .timeZone, .year, .month, .day, .hour, .minute, .second), from: currentEndOfDay)
            dateComponents.day = 0
            let beginningOfMonth = Calendar.current.date(from: dateComponents)!

            TotalAmount = 0
            for purchase in filterTransactionsByDate(ArraytoFilter: sitePurchaseDict[self.SelectedSiteID]!, StartDate: beginningOfMonth, EndDate: currentEndOfDay) {
                TotalAmount += purchase.totalcharge
            }
            TotalMonthToDate = TotalAmount

            let endOfLastMonth = Calendar.current.date(byAdding: .day, value: -1, to: beginningOfMonth)!
            let BegOfLastMonth = Calendar.current.date(byAdding: .month, value: -1, to: beginningOfMonth)!
            TotalAmount = 0
            for purchase in filterTransactionsByDate(ArraytoFilter: sitePurchaseDict[self.SelectedSiteID]!, StartDate: BegOfLastMonth, EndDate: endOfLastMonth) {
                TotalAmount += purchase.totalcharge
            }
            TotalLastMonth = TotalAmount

            let summary = PurchaseSummaryValues(TotalLastMonth: TotalLastMonth, TotalMonthToDate: TotalMonthToDate, TotalYesterday: TotalYesterday, TotalToday: TotalToday)

        self.sitePurchaseSummary.updateValue(summary, forKey: self.SelectedSiteID)
}

    func getSiteInfoDict(_ MPM: String) {
        let searchString = "/siteinfo=" + MPM
        NetworkRequests().getSearchResults(searchString) { results, errorMessage in

            self.siteInfoDict = [MPM: (load(results, as: SiteInfo.self))]
            if !errorMessage.isEmpty {
                self.errorMessage = ("Search error: " + errorMessage)
            }
        }
    }
}
