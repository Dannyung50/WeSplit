//
//  ContentView.swift
//  WeSplit
//
//  Created by Olaleye Daniel Ifeoluwa on 27/08/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20

    @FocusState private var amountisFocused : Bool
    var totalPerPerson: Double {
       let peopleCount = Double(numberOfPeople + 2 )
       let tipSelection = Double(tipPercentage)
       let tipValue = (checkAmount / 100) * tipSelection
       let grandTotal = checkAmount + tipValue
       let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
  
    var totalAmount : Double{
        let tipSelection = Double(tipPercentage)
        let tipValue = (checkAmount / 100) * tipSelection
        let   grandTotal = checkAmount + tipValue
        return grandTotal
    }
    
    var currencyFormatter: FloatingPointFormatStyle<Double>.Currency {
        return .currency(code: Locale.current.currency?.identifier ?? "NGN")
    }
        
    
   
    var body: some View {

        
        NavigationView{
            Form{
                Section{
                    TextField("Enter Amount", value: $checkAmount, format:
                          currencyFormatter  )
                    .keyboardType(.decimalPad)
                    .focused($amountisFocused)
                    Picker("Number of people", selection: $numberOfPeople ){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                }
                Section{
                    Picker("Tip Percentage", selection: $tipPercentage){
                        ForEach(1..<101, id: \.self){
                            Text($0, format: .percent)
                        }
                    }
                } header:{
                    Text("How much tip do yow want to leave?")
                }
                
                Section{
                    Text( totalAmount,format: currencyFormatter)
                } header: {
                    Text("Total Amount")
                }
                
                
                Section{
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USA"))
                } header: {
                    Text("Amount per person")
                }
               
               
            }
            .navigationTitle("WeSplit")
            .navigationBarTitleDisplayMode(.large)
            .toolbar{
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    Button("Done"){
                        amountisFocused = false
                    }
                }
            }
        }


  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
