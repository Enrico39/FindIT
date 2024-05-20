import Foundation

import MapKit

 

struct Location: Identifiable, Equatable {

    

    

    let name: String

    let cityName: String

    let coordinates: CLLocationCoordinate2D

    let baseDescription: String

    let unlockedDescription: String

    let imageName: String

    var isUnlocked: Bool

    var isSelected: Bool = false
    
    
    let isStory: Int


    var id: String {

        name + cityName

    }

    

    //Equatable

    static func == (lhs: Location, rhs: Location) -> Bool {

        lhs.id == rhs.id

    }

}




