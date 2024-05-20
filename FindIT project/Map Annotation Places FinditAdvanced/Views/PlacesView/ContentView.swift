//
//  ContentView.swift
//  progetto9luglio
//
//  Created by checca on 09/07/23.
//

import SwiftUI



struct ContentView: View {
    @AppStorage("log_Status") var log_Status: Bool = false
    
    var body: some View {
        Group {
            if log_Status {
                LocationsView()
            }
            else {
                IntroView()
            }
        }
        .preferredColorScheme(.light)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}
