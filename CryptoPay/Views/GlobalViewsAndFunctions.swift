//
//  GlobalViewsAndFunctions.swift
//  CryptoPay
//
//  Created by JamesJoseph Burch on 7/1/20.
//  Copyright © 2020 James Burch. All rights reserved.
//

import SwiftUI


struct LabelTextField : View {
    var label: String
    var placeHolder: String
    @Binding var userInput: String
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)//.font(.caption)
            TextField(placeHolder, text: $userInput)
            .padding(.all)
            .background((Color("lightGreyColor")))
            .cornerRadius(15.0)
        }.padding(.horizontal, 15)
    }
}

struct LabelNumField : View {
    var label: String
    @Binding var placeHolder: Int
    @Binding var userInput: Int
    @State var placeHolderString = ""
    @State var userInputString = ""
    
    func IntToString() {
        placeHolderString = String(self.placeHolder)
        userInputString = String(self.userInput)
    }
    func StringtoInt() {
        userInput = Int(userInputString)!
    }
    
    
    var body: some View {
        LabelTextField(label: label, placeHolder: placeHolderString, userInput: $userInputString)
        .onAppear(perform: IntToString)
            .onDisappear(perform: StringtoInt)
        .keyboardType(.numberPad)
    }
}


struct DropDownPicker: View {
    var label: String
    @State private var menuToggle = false
    @Binding var activeOption: String
    var dropDownOptions: [String]
        var body: some View {
        VStack(alignment: .leading) {
            Text(label)
            .padding(.bottom, 10)
            VStack {
                Button(action: {
                    self.menuToggle.toggle()
                }) {
                    HStack {
                        Text(self.activeOption)
                        Spacer()
                    }
                }
                if menuToggle {
                    ForEach (dropDownOptions, id: \.self) {option in
                        Button(action: {
                            self.activeOption = option
                            self.menuToggle.toggle()
                    }) {
                        Text(option)
                        .padding(.bottom)
                    }
                    }
                }
            }
            .padding(17)
            .background((Color("lightGreyColor")))
            .cornerRadius(15.0)
        }
        .padding(.horizontal, 15)
        .padding(.bottom, 9)
    }
}

struct DismissingKeyboard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                let keyWindow = UIApplication.shared.connectedScenes
                        .filter({$0.activationState == .foregroundActive})
                        .map({$0 as? UIWindowScene})
                        .compactMap({$0})
                        .first?.windows
                        .filter({$0.isKeyWindow}).first
                keyWindow?.endEditing(true)
        }
    }
}


struct DateSelector: View {
    @Binding var selectedDate: Date
    let minDate: Date
    let maxDate: Date
    
    var label: String



    
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
            DatePicker ("Date", selection: $selectedDate, in: minDate...maxDate ,displayedComponents: .date)
                .labelsHidden()
                .frame(width: 270, height: 80, alignment: .center)
                .clipped()
                .padding(.all)
                .background((Color("lightGreyColor")))
                .cornerRadius(15.0)
        }.padding(.horizontal)
    }
}

func intToStringAmount(_ amount: Int) -> String {
    var StringAmount = String(amount)
    if StringAmount.count == 1 {
        StringAmount = "0.0" + StringAmount
    }
    else if StringAmount.count == 2 {
        StringAmount = "0." + StringAmount
    }
    else {
    StringAmount.insert(".", at: StringAmount.index(StringAmount.endIndex, offsetBy: -2))
    }
    StringAmount.insert("$", at: StringAmount.startIndex)
    return StringAmount
}








struct RoundedButton : View {
    var body: some View {
        Button(action: {}) {
            Text("ADD SITE")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color.green)
                .cornerRadius(15.0)
        }
    }
}












