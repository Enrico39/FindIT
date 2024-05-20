//
//  PlaceDetails.swift
//  progetto9luglio
//
//  Created by checca on 09/07/23.
//

import SwiftUI

struct PlaceDetails: View {
    var place: Places
    
    var animation: Namespace.ID
    
    @EnvironmentObject var sharedData: SharedDataModel
    
    @EnvironmentObject var homeData: HomeView
    
    @AppStorage("isLiked") var isLiked: Bool = false

    
    var body: some View {
        
        VStack {
            VStack {
                HStack {
                    Spacer()
                    
                    Button {
                        addToLiked()
                    } label: {
                        Image(systemName: "heart.fill")
                            .renderingMode(.template)
                            .resizable()
                            .foregroundColor(isLiked ? .red : Color.black.opacity(0.7))
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                    }
                }
                .padding()
                
                Image(place.imageFull)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .matchedGeometryEffect(id: "\(place.id)IMAGE", in: animation)
                    .cornerRadius(20)
                    .padding(.horizontal)
                    .offset(y: -12)
            }
            .frame(height: getRect().height / 2.7)

            // Resto del codice...

            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 15) {
                    Text("Name")
                        .font(.custom("Arial", size: 20).bold())
                    
                    Text(place.name) // indirizzo
                        .foregroundColor(.black)
                        .font(.custom("Arial", size: 18))
                        .foregroundColor(.black).opacity(0.7)
                    
                    Divider()
                        .background(.black)
                    
                    Text("Informations")
                        .font(.custom("Arial", size: 20).bold())
                    
                    Text(place.description)
                        .foregroundColor(.black)
                        .font(.custom("Arial", size: 20))
                }
                .padding([.horizontal,.bottom],20)
                .padding(.top,25)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color(.white)
                    .clipShape(CustomCorners(corners: [.topLeft,.topRight], radius: 25))
                    .ignoresSafeArea()
            )
            .zIndex(0)
        }
        .animation(.easeInOut, value: sharedData.likedPlace)
        .background(
            LinearGradient(colors: [.white, .gray, .white], startPoint: .topLeading, endPoint: .trailing)
        )
    }
    
    func checkIsLiked() -> Bool {
        return isLiked
    }


    func addToLiked() {
        isLiked.toggle()
        if isLiked {
            sharedData.likedPlace.append(place)
        } else {
            if let index = sharedData.likedPlace.firstIndex(where: { $0.id == place.id }) {
                sharedData.likedPlace.remove(at: index)
            }
        }

        sharedData.saveLikedPlaces()
    }

}

struct PlaceDetails_Previews: PreviewProvider {
    static var previews: some View {
//        PlaceDetails(place: HomeView().place[0])
//            .environmentObject(SharedDataModel())
        MainPage()
    }
}
