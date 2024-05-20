//
//  NamePageModel.swift
//  progetto9luglio
//
//  Created by checca on 09/07/23.
//

import SwiftUI

class NamePageModel: ObservableObject {
    @Published var name: String = ""
    
    @AppStorage("log_Status") var log_Status: Bool = false
    
    func login() {
        withAnimation {
            log_Status = true
        }
    }
    
    
}
