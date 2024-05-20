//
//  Map_Annotation_Places_FinditAdvancedApp.swift
//  Map Annotation Places FinditAdvanced
//
//  Created by Lorenzo Mazza on 28/06/23.
//

import SwiftUI

@main
struct Map_Annotation_Places_FinditAdvancedApp: App {
    
    @StateObject private var vm = LocationsViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vm)
                .preferredColorScheme(.light)
        }
    }
    
    
}


