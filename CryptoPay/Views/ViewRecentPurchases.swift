//
//  ViewRecentPurchases.swift
//  CryptoPay
//
//  Created by JamesJoseph Burch on 7/1/20.
//  Copyright © 2020 James Burch. All rights reserved.
//

import SwiftUI

struct ViewRecentPurchases: View {
    @EnvironmentObject var userData: UserData
    @State private var ShowPurchaseSummary = true

    
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("DarkElectronBlue"), Color("MidGrey")]), startPoint: .topLeading, endPoint: .bottomTrailing)
            VStack {
                VStack {
                    PurchaseSummary(ShowPurchaseSummary: $ShowPurchaseSummary)
                        .padding(.horizontal)
                    RecentPurchases(ShowPurchaseSummary: $ShowPurchaseSummary)
                        .padding(.horizontal)
                }
            }
        }//ZStack
    }
}



struct RecentPurchases: View {
    @EnvironmentObject var userData: UserData
    @State private var showFilters = false
    @Binding var ShowPurchaseSummary: Bool

    
    
    func CollapseShowPurchaseSummary() {
        ShowPurchaseSummary = false

    }
    
    var body: some View {
        //RecentPurchases
        VStack{
        VStack {
            VStack {
            HStack {
                Spacer()
                Text("RECENT PURCHASES")
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .padding()
                Spacer()
                Button(action: {
                    self.showFilters.toggle()
                }) {
                    VStack{
                        Text("Filter")
                        .padding(.trailing)

                    }
                }
            }
            }
        }
            Divider()
            if showFilters {
                if ShowPurchaseSummary {
                    PurchaseFilters(showFilters: $showFilters).onAppear(perform: self.CollapseShowPurchaseSummary)
                }else {
                PurchaseFilters(showFilters: $showFilters)
                }
                    
                }else {
                    Purchases()
                }
    }.onAppear(perform: userData.setFilteredPurchaseArray)
        .background(Color("lightGreyColor"))
        .cornerRadius(15.0)
        .modifier(DismissingKeyboard())
        //.padding()

    }
    struct PurchaseFilters: View {
        @EnvironmentObject var userData: UserData
        @Binding var showFilters: Bool
        @State var searchName = ""
        @State var minDate = Date()
        @State var maxDate = Date()
        @State var selectedStartDate = Date()
        @State var selectedEndDate = Date()

        
        func setStartingDateRange() {
            let purchases = userData.sitePurchaseDict[userData.SelectedSiteID]
            
            

            let lastPurchase = (purchases![purchases!.count - 1]).time
            minDate = userData.getDateTime(lastPurchase)
           


            let firstPurchase = (purchases![0]).time
            maxDate = userData.getDateTime(firstPurchase)
            
            

            selectedStartDate = minDate
        

            selectedEndDate = maxDate
        }
        
        func getFilteredPurchasesArray() {
            userData.FilteredPurchasesArray.removeAll()
            let purchases = userData.sitePurchaseDict[userData.SelectedSiteID]!
            userData.FilteredPurchasesArray.removeAll()
            if searchName != "" {
                for purchase in purchases {
                    print(purchase)
                    if purchase.name.contains(searchName.uppercased()) {
                        userData.FilteredPurchasesArray.append(purchase)
                        print("Appending: ", purchase.name)
                    }
                }
                userData.FilteredPurchasesArray = userData.filterTransactionsByDate(ArraytoFilter: userData.FilteredPurchasesArray,StartDate: selectedStartDate, EndDate: selectedEndDate)
            }
            else {
                userData.FilteredPurchasesArray = userData.filterTransactionsByDate(ArraytoFilter: purchases ,StartDate: selectedStartDate, EndDate: selectedEndDate)
            }
            self.showFilters.toggle()
        }
        
        
        
        
        var body: some View {
            ScrollView {
                LabelTextField(label: "NAME", placeHolder: "Enter a name to search", userInput: $searchName)
                VStack {
                    DateSelector(selectedDate: $selectedStartDate, minDate: minDate, maxDate: maxDate, label: "START DATE")
                    DateSelector(selectedDate: $selectedEndDate, minDate: minDate, maxDate: maxDate, label: "END DATE")
                    HStack {
                        Button (action: {self.showFilters.toggle()}) {
                            VStack{
                                Text("Cancel")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                    .background(Color.red)
                                .cornerRadius(15.0)
                                .padding(.trailing, 20)
                            }
                        }
                        
                        Button (action: {self.getFilteredPurchasesArray()}) {
                            VStack{
                                Text("Apply")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color("MintLeaf"))
                                .cornerRadius(15.0)
                                .padding(.leading, 20)
                            }
                        }
                    }.padding()
                }
            }.onAppear(perform: self.setStartingDateRange)
        }
    }
    
    struct Purchases: View {
        @EnvironmentObject var userData: UserData
        @State var PurchaseDetail = [Purchase]()
        @State var TransID = ""

        
        init(){

            UITableView.appearance().backgroundColor = .clear
            UITableViewCell.appearance().backgroundColor = .clear
            UITableView.appearance().tableFooterView = UIView()
            UITableView.appearance().separatorStyle = .none
        }
        
        
        func addToPurchaseDetail(purchaseToAdd: Purchase) {
            PurchaseDetail.removeAll()
            PurchaseDetail.append(purchaseToAdd)
        }
        
        
        func getPurchaseDetails() {
            if PurchaseDetail[0].transidfinal != nil {
            TransID = String(PurchaseDetail[0].transidfinal!)
            }
            
            userData.getTransactions(String(PurchaseDetail[0].purchaseid))
            
        }
        
        var body: some View {
            VStack {
                List (userData.FilteredPurchasesArray, id: \.id) { purchase in
                            VStack(alignment: .leading) {
                                Button(action: {self.addToPurchaseDetail(purchaseToAdd: purchase)}) {
                                    VStack {
                                    HStack {
                                        Text(purchase.name)
                                        Spacer()
                                        Text(intToStringAmount(purchase.totalcharge))

                                    }
                                }
                                HStack {
                                    Text(self.userData.getTime(purchase.time))
                                    Text(self.userData.getDate(purchase.time))
                                    Spacer()
                                }
                                }
                                if self.PurchaseDetail.contains(purchase) {
                                    VStack {
                                        //Text("Test")
                                        Divider()
                                        HStack {
                                            Text("Transaction ID:")
                                            Spacer()
                                            Text(self.TransID)
                                        }
                                        
                                        ForEach (self.userData.transactions, id: \.id) {transaction in
                                            HStack {
                                                Text(self.userData.getSwiperName(transaction.macaddr))
                                                Spacer()
                                                Text(intToStringAmount(transaction.charge))
                                            }
                                        }
                                    }.onAppear(perform: self.getPurchaseDetails)
                                        .padding(.top, 4)
                                        .padding(.horizontal, 20)
                                    }
                            }
                            .padding(.vertical, 2)
                            .padding(.horizontal, 10)
                            .background(Color("LightMintLeaf"))
                            .cornerRadius(15.0)
                    }.id(UUID()) //https://www.hackingwithswift.com/articles/210/how-to-fix-slow-list-updates-in-swiftui
                
               Spacer()
            }
        }
    }
}


struct PurchaseSummary: View {
    @EnvironmentObject var userData: UserData
    @Binding var ShowPurchaseSummary: Bool
    @State var TotalLastMonth = 0
    @State var TotalMonthToDate = 0
    @State var TotalYesterday = 0
    @State var TotalToday = 0
    
    func getSummaryValues() {
        TotalLastMonth = userData.sitePurchaseSummary[userData.SelectedSiteID]!.TotalLastMonth
        TotalMonthToDate = userData.sitePurchaseSummary[userData.SelectedSiteID]!.TotalMonthToDate
        TotalYesterday = userData.sitePurchaseSummary[userData.SelectedSiteID]!.TotalYesterday
        TotalToday = userData.sitePurchaseSummary[userData.SelectedSiteID]!.TotalToday
    }
    
    var body: some View {
        VStack {
        VStack {
            Button(action: {
                self.ShowPurchaseSummary.toggle()
            }) {
                HStack {
                    HStack{
                        Spacer()
                        Text("PURCHASE SUMMARY")
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                            .padding()
                        Spacer()
                        if ShowPurchaseSummary {
                            Image("PullUpArrow")
                            .resizable()
                            .frame(width: 20.0, height: 20.0)
                            .padding(.horizontal)
                        }
                        else {
                            Image("DropDownArrow")
                            .resizable()
                            .frame(width: 20.0, height: 20.0)
                                .padding(.horizontal)
                        }
                    }
                }
            }
            if ShowPurchaseSummary {
                Divider()
                    VStack {
                        PurchaseSummaryContent(label: "Last Month:", amount: $TotalLastMonth)
                            .padding(.bottom, 4)
                        PurchaseSummaryContent(label: "Month to Date:", amount: $TotalMonthToDate)
                            .padding(.bottom, 4)
                        PurchaseSummaryContent(label: "Yesterday:", amount: $TotalYesterday)
                            .padding(.bottom, 4)
                        
                        PurchaseSummaryContent(label: "Today:", amount: $TotalToday)
                    }.padding()
            }
        }
        .background(Color("lightGreyColor"))
        .cornerRadius(15.0)
        }
        .padding(.vertical, 7)
        .onAppear(perform: getSummaryValues)
    }
    struct PurchaseSummaryContent: View {
        var label: String
        @Binding var amount: Int
        var body: some View {
            HStack {
                Text(label)
                    .padding(.leading, 40)
                Spacer()
                Text(intToStringAmount(amount))
                    .padding(.trailing, 40)
            }
        }
    }
}



struct sitePurchases: View {
    @EnvironmentObject var userData: UserData
    
    init(){
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {

        List(userData.sitePurchaseDict[userData.SelectedSiteID]!, id: \.id) { purchase in
                VStack {

                        HStack {
                            Text(purchase.name)
                            Spacer()
                            Text("Total: $")
                            Text(String(purchase.totalcharge))
                            
                        }

                    Text(purchase.time)

                }
        }
    }
}



struct ViewRecentPurchases_Previews: PreviewProvider {
    static var previews: some View {
        ViewRecentPurchases()
    }
}
