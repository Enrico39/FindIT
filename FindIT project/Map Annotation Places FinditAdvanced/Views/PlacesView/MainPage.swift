//
//  MainPage.swift
//  progetto9luglio
//
//  Created by checca on 09/07/23.
//


import SwiftUI

struct MainPage: View {
    
    @StateObject var sharedData: SharedDataModel = SharedDataModel()
    
    @Namespace var animation
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    @State private var showPlaceDetails = false
    
    var body: some View {
        VStack (spacing: 0) {
            Home(animation: animation)
                .environmentObject(sharedData)
            
            ZStack {
                if let place = sharedData.detailPlace, sharedData.showDetailPlace {
                    PlaceDetails(place: place, animation: animation)
                        .environmentObject(sharedData)
                        .sheet(isPresented: $showPlaceDetails) {
                            if let place = sharedData.detailPlace {
                                PlaceDetails(place: place, animation: animation)
                                    .environmentObject(sharedData)
                            }
                        }
                }
            }
        }
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}

