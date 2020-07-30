//
//  ViewSiteStatus.swift
//  CryptoPay
//
//  Created by JamesJoseph Burch on 6/25/20.
//  Copyright © 2020 James Burch. All rights reserved.
//

import SwiftUI

struct ViewSiteStatus: View {
    @EnvironmentObject var userData: UserData

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("DarkElectronBlue"), Color("MidGrey")]), startPoint: .topLeading, endPoint: .bottomTrailing)
            ScrollView {

                VStack {
                    HStack {

                        Text("Site Information")
                            .bold()
                        Spacer()
                    }.padding(.bottom)
                    .padding(.leading)

                    Text(userData.Selectedaddress)
                    HStack {
                        Text(userData.Selectedcity)
                        Text(userData.Selectedstate)
                        Text(userData.Selectedzip)
                        //Text(userData. )
                    }
                    Text(userData.Selectedtimezone)
                }
                .padding()
                .background(Color("lightGreyColor"))
                .cornerRadius(5.0)
                .padding(.bottom, 10)

                //Status
                VStack {
                    HStack {

                        Text("Site Status")
                            .bold()
                        Spacer()
                    }.padding(.bottom)
                    .padding(.leading)

                    //Purchase Made
                    if userData.Selectedsitepurchstat == "Yes" {
                        HStack {
                            Text("Purchase Received:")
                            Spacer()
                            Text(userData.Selectedsitepurchstat)
                        }
                        .padding()
                        .background(Color("LightMintLeaf"))
                        .cornerRadius(12.0)

                    } else {
                        HStack {
                            Text("Purchase Received:")
                            Spacer()
                            Text(userData.Selectedsitepurchstat)
                        }
                        .padding()
                        .background(Color.red)
                        .cornerRadius(12.0)
                    }

                    Spacer()

                    if userData.Selectedsitepurchemail == "Yes" {
                        HStack {
                            Text("Alarm Contacts:")
                            Spacer()
                            Text(userData.Selectedsitepurchemail)
                        }
                        .padding()
                        .background(Color("LightMintLeaf"))
                        .cornerRadius(12.0)
                    } else {
                        HStack {
                            Text("Alarm Contacts:")
                            Spacer()
                            Text(userData.Selectedsitepurchemail)
                        }
                        .padding()
                        .background(Color.red)
                        .cornerRadius(12.0)
                    }
                    Spacer()

                    if userData.Selectedsitedownstat == "Connected" {
                        HStack {
                            Text("Coordinator Status:")
                            Spacer()
                            Text(userData.Selectedsitedownstat)
                        }.padding()
                        .background(Color("LightMintLeaf"))
                        .cornerRadius(12.0)
                    } else {
                        HStack {
                            Text("Coordinator Status")
                            Spacer()
                            Text(userData.Selectedsitedownstat)
                        }.padding()
                        .background(Color.red)
                        .cornerRadius(12.0)
                    }

                    HStack {
                        Text("Credit Card Reader Status")
                            .bold()
                        Spacer()
                    }
                    .padding()

                    ForEach(userData.SelectedSwipers) {swiper in

                        if self.userData.isConnected(swiper.lastcontact) {
                            VStack {

                                HStack {
                                    VStack(alignment: .leading) {
                                    Text(swiper.name)

                                    Text(swiper.macaddr)
                                        .font(.caption)
                                    }
                                    Spacer()
                                    Text("Connected")
                                }

                            }
                            .padding(.vertical, 5)
                            .padding(.horizontal)
                            .background(Color("LightMintLeaf"))
                            .cornerRadius(12.0)
                        } else {
                            VStack {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(swiper.name)

                                        Text(swiper.macaddr)
                                        .font(.caption)
                                    }
                                    Spacer()
                                    Text("Not Connected")
                                }
                            }
                            .padding(.vertical, 5)
                            .padding(.horizontal)
                            .background(Color.red)
                            .cornerRadius(12.0)
                        }
                        Spacer()
                    }

                }
                .padding()
                .background(Color("lightGreyColor"))
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            }
                .padding(.horizontal)
        }
    }
}

struct ViewSiteStatus_Previews: PreviewProvider {
    static var previews: some View {
        ViewSiteStatus()
    }
}
