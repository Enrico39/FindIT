import SwiftUI



struct Home: View {
    
    var animation: Namespace.ID
    
    @EnvironmentObject var sharedData: SharedDataModel

    @StateObject var homeData: HomeView = HomeView()
    @State private var isProfileOpen = false
    @State private var showSheet = false

    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack (spacing: 15) {
                    HStack {
                        Spacer()
                        Text("Secret Places")
                            .font(.custom("Arial", size: 24).bold())
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top)
                            .padding(.horizontal,25)
                        
                        NavigationLink(destination: LikedPage()) {
                            Image(systemName: "heart")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.black)
                                .frame(width: 25, height: 25)
                        }
                        .padding(.horizontal)
                        .padding(.top)
                        .padding(.horizontal,4)
                        .navigationBarBackButtonHidden(true)
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack (spacing: 18) {
                            ForEach(Modes.allCases, id: \.self) { type in
                                ModesTypeView(type: type)
                            }
                        }
                        .padding(.horizontal,25)
                    }
                    .padding(.top,28)
                    
                    // luoghi
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 25) {
                            ForEach(homeData.filteredPlace) { luoghi in
                                // card view
                                PlaceCardView(place: luoghi)
                            }
                        }
                        .padding(.horizontal, 25)
                        .padding(.bottom)
                        .padding(.top,80)
                    }
                    .padding(.bottom,100)

                }
                .padding(.vertical)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.gray.opacity(0.09))
            .onChange(of: homeData.modeType) { newType in
                homeData.filterPlaceByType()
            }
            .sheet(isPresented: $homeData.showMorePlaceOnType) {
                MorePlaceView()
            }
        }
    }
    
    @ViewBuilder
    func PlaceCardView(place: Places) -> some View {
        VStack (spacing: 10) {
            ZStack {
                    Image(place.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
            }
            .frame(width: getRect().width / 2.5, height: getRect().width / 2.5)
            .offset(y: -80)
            .padding(.bottom, -80)
            
            Text(place.name)
                .foregroundColor(.black)
                .font(.custom("Arial", size: 18))
                .fontWeight(.semibold)
                .padding(.top)
                
            
            Text("Tap here for more informations.")
                .foregroundColor(.black)
                .font(.custom("Arial", size: 14))
                .padding(.top)
        }
        .padding(.horizontal,20)
        .padding(.bottom,22)
        .background(
            Color.white
                .cornerRadius(25)
        )
        .onTapGesture {
            withAnimation(.easeInOut) {
                sharedData.detailPlace = place
                showSheet = true
            }
        }
        .sheet(isPresented: $showSheet) {
            if let place = sharedData.detailPlace {
                PlaceDetails(place: place, animation: animation)
                    .environmentObject(sharedData)
            }
        }
    }
    
    @ViewBuilder
    func ModesTypeView(type: Modes) -> some View {
        Button  {
            withAnimation {
                homeData.modeType = type
            }
        } label: {
            Text(type.rawValue)
                .font(.custom("Arial", size: 15))
                .fontWeight(.semibold)
                .foregroundColor(homeData.modeType == type ? Color.black : Color.gray)
                .padding(.bottom, 10)
                .overlay(
                    ZStack {
                        if homeData.modeType == type {
                            Capsule()
                                .fill(Color.black)
//                            se ci sono problemi togli questo e l'else
                                .matchedGeometryEffect(id: "PLACEtab", in: animation)
                                .frame(height: 2)
                        }
                        else {
                            Capsule()
                                .fill(Color.clear)
                                .frame(height: 2)
                        }
                    }
                        .padding(.horizontal,-5)
                    ,alignment: .bottom
                )
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
MainPage()
        
    }
}
