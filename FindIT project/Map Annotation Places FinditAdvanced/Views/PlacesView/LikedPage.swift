import SwiftUI

struct LikedPage: View {
    @EnvironmentObject var sharedData: SharedDataModel
    @State private var showDeleteOption = false
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    HStack {
                        Text("Favourites")
                            .font(.custom("Arial", size: 28).bold())
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                showDeleteOption.toggle()
                            }
                        } label: {
                            Image(systemName: "heart.slash.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.red)
                                .frame(width: 25, height: 25)
                        }
                        .opacity(sharedData.likedPlace.isEmpty ? 0 : 1)
                    }
                    
                    if sharedData.likedPlace.isEmpty {
                        Group {
                            Image("maradona senza sfondo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding()
                                .padding(.top, 2)
                            
                            Text("No favourites yet")
                                .font(.custom("Arial", size: 25))
                                .fontWeight(.semibold)
                            
                            Text("Hit the like button on each product page to save favorite ones.")
                                .font(.custom("Arial", size: 18))
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                                .padding(.top, 10)
                                .multilineTextAlignment(.center)
                        }
                    } else {
                        VStack(spacing: 15) {
                            ForEach(sharedData.likedPlace) { place in
                                HStack(spacing: 0) {
                                    if showDeleteOption {
                                        Button {
                                            deletePlace(place: place)
                                        } label: {
                                            Image(systemName: "minus.circle.fill")
                                                .font(.title2)
                                                .foregroundColor(.red)
                                        }
                                        .padding(.trailing)
                                    }
                                    
                                    CardView(place: place)
                                }
                            }
                        }
                        .padding(.top, 25)
                        .padding(.horizontal)
                    }
                }
                .padding()
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color(.gray)
                    .opacity(0.09)
                    .ignoresSafeArea()
            )
        }
        .onAppear {
            loadLikedPlaces()
        }

    }
    
    @ViewBuilder
    func CardView(place: Places) -> some View {
        HStack(spacing: 15) {
            Image(place.imageFull)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(place.name)
                    .foregroundColor(.black)
                    .font(.custom("Arial", size: 18).bold())
                    .lineLimit(1)
                
                Text("Modes: \(place.type.rawValue)")
                    .font(.custom("Arial", size: 13))
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            Color.white
                .cornerRadius(10)
        )
    }
    
    func deletePlace(place: Places) {
        if let index = sharedData.likedPlace.firstIndex(where: { currPlace in
            return place.id == currPlace.id
        }) {
            withAnimation {
                sharedData.likedPlace.remove(at: index)
                saveLikedPlaces()
            }
        }
    }
    
    func saveLikedPlaces() {
        if let encodedData = try? JSONEncoder().encode(sharedData.likedPlace) {
            UserDefaults.standard.set(encodedData, forKey: "likedPlaces")
        }
    }
    
    func loadLikedPlaces() {
        if let encodedData = UserDefaults.standard.data(forKey: "likedPlaces"),
           let decodedData = try? JSONDecoder().decode([Places].self, from: encodedData) {
            sharedData.likedPlace = decodedData
        }
    }
}

struct LikedPage_Previews: PreviewProvider {
    static var previews: some View {
        LikedPage()
            .environmentObject(SharedDataModel())
    }
}
