//
//  ViewAddNewSite.swift
//  CryptoPay
//
//  Created by JamesJoseph Burch on 7/1/20.
//  Copyright © 2020 James Burch. All rights reserved.
//

import SwiftUI

struct ViewAddNewSite: View {
    @State var siteNamePlaceHolder = "Fill in the name of the Site"
    @State var siteCodePlaceHolder = "Fill in the CPY Number"
    @State var siteTypePlaceHolder = "Select the Site Type"
    @State var siteAddressPlaceHolder = "Fill in Address of the Site"
    @State var siteCityPlaceHolder = "Fill in the City"
    @State var siteStatePlaceHolder = "Fill in the State/Province"
    @State var siteZipCodePlaceHolder = "Fill in the Zipcode"
    @State var siteTimeZonePlaceHolder = "Select the TimeZone"
    @State var siteMPMPlaceHolder = "Fill in the MPM Number"
    @State var sitePasswordPlaceHolder = "Fill in the Password"

    @State var siteName = ""
    @State var siteCode = ""
    @State var siteType = ""
    @State var siteAddress = ""
    @State var siteCity = ""
    @State var siteState = ""
    @State var siteZipCode = ""
    @State var siteTimeZone = ""
    @State var siteMPM = ""
    @State var sitePassword = ""

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("DarkElectronBlue"), Color("MidGrey")]), startPoint: .topLeading, endPoint: .bottomTrailing)
            ScrollView {
                Text("To add a new site, please provide the following information:")
                .font(.caption)
                .padding()
                VStack {
                    Text("SITE INFO")
                        //.font(.headline)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .padding(.bottom)
                    SiteInfoForm(siteNamePlaceHolder: $siteNamePlaceHolder,
                                 siteCodePlaceHolder: $siteCodePlaceHolder,
                                 siteTypePlaceHolder: $siteTypePlaceHolder,
                                 siteName: $siteName, siteCode: $siteCode,
                                 siteType: $siteType)
                    Text("SITE ADDRESS")
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .padding()
                    SiteLocationForm(siteAddress: $siteAddress,
                                     siteCity: $siteCity,
                                     siteState: $siteState,
                                     siteZipCode: $siteZipCode,
                                     siteTimeZone: $siteTimeZone,
                                     siteAddressPlaceHolder: $siteAddressPlaceHolder,
                                     siteCityPlaceHolder: $siteCityPlaceHolder,
                                     siteStatePlaceHolder: $siteStatePlaceHolder,
                                     siteZipCodePlaceHolder: $siteZipCodePlaceHolder,
                                     siteTimeZonePlaceHolder: $siteTimeZonePlaceHolder)
                    Text("Merchant Information")
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .padding()
                    MerchantCredentialsForm(siteMPM: $siteMPM, sitePassword: $sitePassword, siteMPMPlaceHolder: $siteMPMPlaceHolder, sitePasswordPlaceHolder: $sitePasswordPlaceHolder)
                    RoundedButton()
                        .scaledToFill()
                        .padding()
                }
            }
        }
    }
}

struct SiteInfoForm: View {
    @Binding var siteNamePlaceHolder: String
    @Binding var siteCodePlaceHolder: String
    @Binding var siteTypePlaceHolder: String

    @Binding var siteName: String
    @Binding var siteCode: String
    @Binding var siteType: String

    var body: some View {
        VStack {
            LabelTextField(label: "NAME", placeHolder: siteNamePlaceHolder, userInput: $siteName)
            LabelTextField(label: "CODE", placeHolder: siteCodePlaceHolder, userInput: $siteCode)
            LabelTextField(label: "TYPE", placeHolder: siteTypePlaceHolder, userInput: $siteType)
        }
    }
}

struct SiteLocationForm: View {
    @Binding var siteAddress: String
    @Binding var siteCity: String
    @Binding var siteState: String
    @Binding var siteZipCode: String
    @Binding var siteTimeZone: String

    @Binding var siteAddressPlaceHolder: String
    @Binding var siteCityPlaceHolder: String
    @Binding var siteStatePlaceHolder: String
    @Binding var siteZipCodePlaceHolder: String
    @Binding var siteTimeZonePlaceHolder: String
    var body: some View {
        VStack {
            LabelTextField(label: "ADRESS", placeHolder: siteAddressPlaceHolder, userInput: $siteAddress)
            LabelTextField(label: "City", placeHolder: siteCityPlaceHolder, userInput: $siteCity)
            LabelTextField(label: "State/Province", placeHolder: siteStatePlaceHolder, userInput: $siteState)
            LabelTextField(label: "Zipcode", placeHolder: siteZipCodePlaceHolder, userInput: $siteZipCode)
            LabelTextField(label: "TimeZone", placeHolder: siteTimeZonePlaceHolder, userInput: $siteTimeZone)
        }
    }
}

struct MerchantCredentialsForm: View {
    @Binding var siteMPM: String
    @Binding var sitePassword: String

    @Binding var siteMPMPlaceHolder: String
    @Binding var sitePasswordPlaceHolder: String
    var body: some View {
        VStack {
            LabelTextField(label: "MPM Number", placeHolder: siteMPMPlaceHolder, userInput: $siteMPM)
            LabelTextField(label: "Password", placeHolder: sitePasswordPlaceHolder, userInput: $sitePassword)
        }
    }
}

struct ViewAddNewSite_Previews: PreviewProvider {
    static var previews: some View {
        ViewAddNewSite()
    }
}
