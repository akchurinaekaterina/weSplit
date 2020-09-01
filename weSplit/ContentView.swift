//
//  ContentView.swift
//  weSplit
//
//  Created by Ekaterina Musiyko on 09/04/2020.
//  Copyright © 2020 Ekaterina Akchurina. All rights reserved.
//

import SwiftUI




struct ContentView: View {
    
    @State var checkAmount = ""
    @State var numberOfPeople = ""
    @State var tipPercentage = 2
    let tipPercentages = [5, 10, 15, 0]
    
    var totalPerPerson: Double{
        let peopleCount = Double(numberOfPeople) ?? 1
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    var totalAmountWithTips: Double{
        let orderAmount = Double(checkAmount) ?? 0
        let tipSelection = Double(tipPercentages[tipPercentage])
        let grossSum = orderAmount + orderAmount * tipSelection / 100
        return grossSum
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Cумма", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    
                    TextField("Число едоков", text: $numberOfPeople)
                        .keyboardType(.decimalPad)
                    }
                
                Section(header: Text("Процент чаевых")) {
                    Picker("Choose %", selection: $tipPercentage){
                        ForEach(0..<tipPercentages.count){
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                .pickerStyle(SegmentedPickerStyle())
                }
               
                Section(header: Text("Сумма с каждого")) {
                    Text("\(totalPerPerson, specifier: "%.2f") руб. с человека")
                    .blueTitle()
                }
                Section(header: Text("Общая сумма с чаевыми")
                    ){
                    Text("\(totalAmountWithTips, specifier: "%.2f") руб.")
                        .foregroundColor(tipPercentages[tipPercentage] == 0 ? .red : .blue)
                                        }
            }
        .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct BluTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

struct RedTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.red)
    }
}

extension View {
    func blueTitle() -> some View {
        self.modifier(BluTitle())
    }
    func redTitle() -> some View {
        self.modifier(RedTitle())
    }
}
