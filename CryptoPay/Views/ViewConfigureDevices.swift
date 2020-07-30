//
//  ViewConfigureDevices.swift
//  CryptoPay
//
//  Created by JamesJoseph Burch on 7/1/20.
//  Copyright © 2020 James Burch. All rights reserved.
//

import SwiftUI

struct ViewConfigureDevices: View {
    @EnvironmentObject var userData: UserData
        @State private var selectedSwiperIndex = -0
        @State private var showConfiguration = false
        
        var body: some View {
            ZStack {
                    LinearGradient(gradient: Gradient(colors: [Color("DarkElectronBlue"), Color("MidGrey")]), startPoint: .topLeading, endPoint: .bottomTrailing)

                    VStack {
                        Text("Select a card reader from below to configure.")
                        .font(.caption)
                        .padding()
                        
                        ScrollView {
                        ForEach(userData.SelectedSwipers) {swiper in
                            Button(action: {
                                self.selectedSwiperIndex = self.userData.SelectedSwipers.firstIndex(of: swiper)!
                                self.showConfiguration.toggle()
                            }) {
                                VStack {
                                    HStack{
                                        VStack(alignment: .leading) {
                                            Text(swiper.name)
                                            Text(swiper.macaddr).font(.caption)
                                        }
                                        Spacer()
                                        Text(swiper.SwiperProfile)
                                    }
                                }
                            }
                            .padding(.vertical, 5)
                            .padding(.horizontal)
                            .background(Color("lightGreyColor"))
                            .cornerRadius(12.0)
                            Spacer()
                        }
                        }.padding(.horizontal, 15)
                    }

                if showConfiguration {
                    ViewConfigureSwiper(selectedSwiperIndex: $selectedSwiperIndex, showConfiguration: $showConfiguration)
                }
            }
        }
    }


    struct ViewConfigureDevices_Previews: PreviewProvider {
        static var previews: some View {
            ViewConfigureDevices()
        }
    }


    struct ViewConfigureSwiper: View {
        @EnvironmentObject var userData: UserData
        @Binding var selectedSwiperIndex: Int
        @Binding var showConfiguration: Bool
        
        @State private var swiperName = "NoName"
        @State private var swiperProfile = "NoProfile"
        @State private var swiperProfileOptions = ["Count Down Coin", "Count Down Card", "Count Up", "Vend", "Auto"]
        @State private var swiperPurchType = "NoType"
        @State private var swiperPurchOptions = ["Wash Bay", "Vac", "Vend", "Pet Wash", "Dryer", "None"]

        @State private var swiperRate = 999
        @State private var swiperMin = 999
        @State private var swiperMax = 999
        @State private var swiperAmex = "NoAmex"
        @State private var swiperBnsCoin = 999
        
        @State private var ProfilePickerToggle = false
        @State private var TypePickerToggle = false
        
        func setLocalConfigVariables() {
            swiperName = userData.SelectedSwipers[selectedSwiperIndex].name
            swiperProfile = userData.SelectedSwipers[selectedSwiperIndex].SwiperProfile
            swiperPurchType = userData.SelectedSwipers[selectedSwiperIndex].PrchTyp
            swiperRate = userData.SelectedSwipers[selectedSwiperIndex].Rate
            swiperMin = userData.SelectedSwipers[selectedSwiperIndex].MinCh
            swiperMax = userData.SelectedSwipers[selectedSwiperIndex].MaxCh
            swiperAmex = userData.SelectedSwipers[selectedSwiperIndex].Amex
            swiperBnsCoin = userData.SelectedSwipers[selectedSwiperIndex].BnsCoin
        }
        
        
        var body: some View {
            ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("DarkElectronBlue"), Color("MidGrey")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                ScrollView {
                    Text("To configure a card reader, please provide the following information:")
                    .font(.caption)
                    .padding()
                    LabelTextField(label: "NAME", placeHolder: swiperName, userInput: $swiperName)
                    DropDownPicker(label: "PROFILE", activeOption: $swiperProfile, dropDownOptions: swiperProfileOptions)
                    DropDownPicker(label: "PURCHASE TYPE", activeOption: $swiperPurchType, dropDownOptions: swiperPurchOptions)
                    LabelNumField(label: "RATE", placeHolder: $swiperRate, userInput: $swiperRate)
                    LabelNumField(label: "MIN CHARGE", placeHolder: $swiperMin, userInput: $swiperMin)
                    LabelNumField(label: "MAX CHARGE", placeHolder: $swiperMax, userInput: $swiperMax)
                    LabelNumField(label: "COINS PER PRESS", placeHolder: $swiperBnsCoin, userInput: $swiperBnsCoin)

                    HStack {
                        Button (action: {self.showConfiguration.toggle()}) {
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
                        
                        Button (action: {self.showConfiguration.toggle()}) {
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
                }.modifier(DismissingKeyboard())
            } .onAppear(perform: setLocalConfigVariables)
        }
    }
