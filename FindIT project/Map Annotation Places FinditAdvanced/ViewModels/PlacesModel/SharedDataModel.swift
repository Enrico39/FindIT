//
//  SharedDataModel.swift
//  progetto9luglio
//
//  Created by checca on 09/07/23.
//

import SwiftUI

class SharedDataModel: ObservableObject {
    @Published var detailPlace: Places?
    @Published var showDetailPlace: Bool = false
    
    // like
    @Published var likedPlace: [Places] = []
    
    func saveLikedPlaces() {
        if let encodedData = try? JSONEncoder().encode(likedPlace) {
            UserDefaults.standard.set(encodedData, forKey: "likedPlaces")
        }
    }
}



