//
//  ContentView.swift
//  Check Splitting App
//
//  Created by Marc Vincent on 11/6/23.
//

import SwiftUI

struct ContentView: View {
    @State private var originalTemp = 0.00
    @FocusState private var isFocused: Bool
    
    @State private var unit = temperatureUnits.Celsius
    @State private var newUnit = temperatureUnits.Fahrenheit
    
    enum temperatureUnits {
        case Fahrenheit, Celsius, Kelvin
    }
    
    var newTemp: Double {
        switch (unit, newUnit) {
        case (.Celsius, .Celsius):
            return originalTemp
        case (.Fahrenheit, .Fahrenheit):
            return originalTemp
        case (.Kelvin, .Kelvin):
            return originalTemp
        case (.Fahrenheit, .Celsius):
            return (originalTemp - 32) * (5/9)
        case (.Celsius, .Fahrenheit):
            return (originalTemp * (9/5)) + 32
        case (.Celsius, .Kelvin):
            return originalTemp+273.15
        case (.Fahrenheit, .Kelvin):
            return (originalTemp - 32) * (5/9) + 273.15
        case (.Kelvin, .Fahrenheit):
            return ((originalTemp-273.15) * (9/5)) + 32
        case (.Kelvin, .Celsius):
            return (originalTemp - 273.15)
        }
    }
    var body: some View {
        NavigationStack{
            Form {
                Section ("Value to Convert") {
                    TextField("Value", value: $originalTemp, format: .number)
                        .keyboardType(.decimalPad)
                        focused($isFocused)
                    
                    Picker("Unit", selection: $unit) {
                        Text("Fahrenheit").tag(temperatureUnits.Fahrenheit)
                        Text("Celsius").tag(temperatureUnits.Celsius)
                        Text("Kelvin").tag(temperatureUnits.Kelvin)
                    }
                    .pickerStyle(.segmented)
                }
                
                Section ("New Temperature") {
                    Text(newTemp.formatted())
                    Picker("Unit", selection: $newUnit) {
                        Text("Fahrenheit").tag(temperatureUnits.Fahrenheit)
                        Text("Celsius").tag(temperatureUnits.Celsius)
                        Text("Kelvin").tag(temperatureUnits.Kelvin)
                    }
                    .pickerStyle(.segmented)
                }
                
                Section {
                   
                }
            }
            
            
            .navigationTitle("Temperature Converter")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if isFocused {
                    Button("Done") {
                        isFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
