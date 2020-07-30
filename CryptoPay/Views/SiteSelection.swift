//
//  SiteSelection.swift
//  CryptoPay
//
//  Created by JamesJoseph Burch on 6/11/20.
//  Copyright © 2020 James Burch. All rights reserved.
//

import SwiftUI

struct SiteSelection: View {
    @EnvironmentObject var userData: UserData
    @Binding var ShowSites: Bool

    var body: some View {
        VStack {
            Button(action: {self.ShowSites.toggle()}) {
                VStack {
            Text(userData.SelectedSiteID)//.font(.headline)
            Text(userData.Selectedsitename)//.fontWeight(.semibold)
                }
            .font(.headline)
            .foregroundColor(Color("DarkElectronBlue"))
                .padding(.bottom, 3)
                .padding(.horizontal, 5)
            .background(Color("LightElectronBlue"))
            .cornerRadius(5.0)
            }.padding(.bottom, 4)
            if self.ShowSites {
                VisualEffectView(effect: UIBlurEffect(style: .dark))
                .edgesIgnoringSafeArea(.all)
                ShowSitesMenu(ShowSites: $ShowSites)

                }
        }

    }
}

struct ShowSitesMenu: View {
    @EnvironmentObject var userData: UserData
    @Binding var ShowSites: Bool

    func ButtonResponce(_ siteID: String,
                        _ siteName: String,
                        _ siteAddress: String,
                        _ city: String,
                        _ sitedownstat: String,
                        _ sitepurchemail: String,
                        _ sitepurchstat: String,
                        _ state: String,
                        _ zip: String,
                        _ timezone: String,
                        _ swipers: [Swiper]) {
        userData.SelectedSiteID = siteID
        userData.Selectedsitename = siteName
        userData.Selectedaddress = siteAddress
        userData.Selectedsitedownstat = sitedownstat
        userData.Selectedsitepurchemail = sitepurchemail
        userData.Selectedsitepurchstat = sitepurchstat
        userData.Selectedcity = city
        userData.Selectedstate = state
        userData.Selectedtimezone = timezone
        userData.Selectedzip = zip
        userData.SelectedSwipers = swipers

        userData.getSiteInfo()
        userData.getCoordinatorStatus()
        //userData.getSwiperConfigs()
        if userData.sitePurchaseDict[siteID] == nil {
            userData.getPurchaseList()
        }
        //userData.getSwiperConfigs()
        self.ShowSites.toggle()

    }

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Select A Site Below")
                    .font(.title)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
            ScrollView {
                VStack {
                    ForEach(self.userData.sites) { MPM in
                        Button(action: {self.ButtonResponce(MPM.siteID!, MPM.sitename!,
                                                            MPM.address1!, MPM.city!, MPM.sitedownstat!,
                                                            MPM.sitepurchemail!, MPM.sitepurchstat!, MPM.state!,
                                                            MPM.zip!, MPM.timezone!, MPM.Swipers!
                            )}) {
                            VStack {
                                Text("\(MPM.sitename!)")
                                .font(.headline)
                                .foregroundColor(.white)
                                Text("\(MPM.siteID!)")
                                .font(.headline)
                                .foregroundColor(.white)
                                .font(.subheadline)
                            }
                            .frame(width: geometry.size.width * 0.68)
                            .padding(.top, 10)
                            .padding(.bottom, 10)
                            .background(Color("MintLeaf"))
                            .cornerRadius(5.0)
                        }.padding(10)
                    }
                }
            }

        }
        .frame(width: geometry.size.width * 0.85, height: geometry.size.height * 0.92)
        .padding()
        .cornerRadius(15.0)
        }
    }
}
