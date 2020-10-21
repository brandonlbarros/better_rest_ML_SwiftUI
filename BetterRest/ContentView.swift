//
//  ContentView.swift
//  BetterRest
//
//  Created by Brandon Barros on 5/6/20.
//  Copyright © 2020 Brandon Barros. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 1
    
    //@State private var showingAlert = false
    
    var time: String {
        let model = SleepCalc()
        
        let components = Calendar.current.dateComponents([.hour,.minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            return formatter.string(from: sleepTime)
            
        } catch {
            return "Error"
        }
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("When do you want to wake up?")
                        .font(.headline)
                    
                    
                    DatePicker("Please enter data", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                }
                
                //Desired hours
                VStack(alignment: .leading, spacing: 0) {
                Text("Desired amount of sleep")
                    .font(.headline)
                Stepper(value: $sleepAmount, in: 2...12, step: 0.25) {
                    Text("\(sleepAmount, specifier: "%g") hours")
                }
                }
                
                    
                //Coffee
                VStack(alignment: .leading, spacing: 0) {
                    Text("Daily coffee intake")
                        .font(.headline)
                    
                    Stepper(value: $coffeeAmount, in: 0...20) {
                        if (coffeeAmount == 1) {
                            Text("1 cup")
                        } else {
                            Text("\(coffeeAmount) cups")
                        }
                    }
                }
                
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("You should go to bed at: \(self.time)")
                        .font(.headline)
                }
            }
            .navigationBarTitle("BetterRest")
            /*.navigationBarItems(trailing:
                Button(action: calcBedtime) {
                    Text("Calculate")
                })
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Dismiss")))
            }*/
            /*.onTapGesture {
                self.calcBedtime()
            }*/
        }
    }
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
