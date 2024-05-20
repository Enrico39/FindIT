import SwiftUI
import UIKit
import MapKit
import CoreLocation


struct LocationPreviewView: View {
    @EnvironmentObject private var vm: LocationsViewModel
    @State private var isHidden: Bool = false
    @Binding var selectedLocation: Location?
    let location: Location
    @Binding var selectedCircleIndex: Int?
    
    
    
    var body: some View {
        if !isHidden {
            HStack {
                    HStack{
                        Button(action: {
                            isHidden = true
                            selectedLocation = nil
                            selectedCircleIndex=nil
                        }) {
                            Image(systemName: "xmark")
                                .foregroundColor(.white)
                                .padding(.trailing, 10)
                                .bold()
                                .padding(.leading,10)
                        }
 
                        titleSection
                    }
                        learnMoreButton
                            .padding(.bottom, 0)
                        
                        openInMapButton
    }
    .padding()
    .background(Color.blue.opacity(0.9))
    .cornerRadius(30)
    .shadow(radius: 4)
        }
    }

    
    private var titleSection: some View {
        HStack(spacing: 4) {
             
            Text(location.name)
                .font(.title3)
                .fontWeight(.medium)
                .foregroundColor(.white)
                Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var learnMoreButton: some View {
        Image("easy_access")
            .resizable()
            .scaledToFit()
            .frame(width: 30, height: 30)
            .foregroundColor(.white)
            .onTapGesture {
                showAlert()
            }
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: nil, message: "Il luogo selezionato è sicuro e accessibile per le persone su sedia a rotelle, garantendo un'esperienza piacevole e senza rischi.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        // Present the alert
        guard let window = UIApplication.shared.windows.first,
              let rootViewController = window.rootViewController else {
            return
        }
        
        rootViewController.present(alert, animated: true, completion: nil)
    }
    
    private var openInMapButton: some View {
        Image(systemName: "square.and.arrow.up")
            .resizable()
            .scaledToFit()
            .frame(width: 30, height: 30)
            .foregroundColor(.white)
            .onTapGesture {
                if let locationIndex = LocationsDataService.locations.firstIndex(where: { $0.name == location.name }) {
                    let selectedLocation = LocationsDataService.locations[locationIndex]
                    let coordinates = selectedLocation.coordinates
                    
                    let mapURL = URL(string: "http://maps.apple.com/maps?daddr=\(coordinates.latitude),\(coordinates.longitude)&dirflg=w")!
                    UIApplication.shared.open(mapURL, options: [:], completionHandler: nil)
                }
            }
    }
}

struct LocationPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.green.ignoresSafeArea()
            LocationPreviewView(selectedLocation: .constant(nil), location: LocationsDataService.locations.first!, selectedCircleIndex: .constant(nil))
                .padding()
        }
        .environmentObject(LocationsViewModel())
    }
}

struct LocationsView: View {
    
    @State private var isAnimatingToUserLocation = false
    
    
    @EnvironmentObject private var vm: LocationsViewModel
    @State private var shouldHidePreview = false // Nuova variabile di stato per controllare l'hidden della preview
    @State private var selectedDistance: String = "Torna alla tua posizione" // Default selected distance
    @State private var showLocationPreview = false
    @State private var selectedLocation: Location?
    @State private var showUserLocation = true
    @State private var selectedCoordinate: CLLocationCoordinate2D?
    @State private var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    @State private var locationManager = CLLocationManager()
    @State private var isDistanceButtonActive = false
    @State private var isCameraOpen = false
    @State private var selectedTab = 0
    @ObservedObject private var locationManagerDelegate = LocationManagerDelegate()
    
    
    @State private var isCameraPresented=false
    @State private var fillColor = Color.red.opacity(0.5)
    @State private var selectedCircleIndex: Int?
    @State private var isSecretPlacesSelected = false
    @Namespace private var animation
    @State private var isMainPagePresented = false
    @State private var isShowingProfile = false
    
    
    @State private var isMenuVisible = false

    
    
    
    var body: some View {
        
        
        
        ZStack {
            
            
            TabView(selection: $selectedTab)    {
                
                ZStack {
                    Button(action: {
                        withAnimation(.easeInOut) {
                            selectedTab = 0
                        }
                    }) {
                        VStack {
                            Text("")
                                .font(selectedTab == 0 ? .body.bold() : .body)
                                .foregroundColor(selectedTab == 0 ? .black : .gray)
                                .padding(.bottom, 14.0)
                            
                            
                        }
                        .padding()
                    }
                    mapLayer
                    
                    //            ScaledAnnotationView()
                        .ignoresSafeArea(.all)
                    
                    VStack{
                        
                        
                        if isMenuVisible {
                            LegendView()
                                .transition(.opacity)
//                                .presentationDetents([.large, .medium, .fraction(0.75)])
                                .padding(.top, 1.0)
                        }
                        
                        
                        Spacer()
                        //                HStack {
                        //                    distanceButton(title: "Torna alla tua posizione", distance: 500)
                        //
                        //                }
                        //                .padding(5)
                        //                .background(.ultraThickMaterial)
                        //                .cornerRadius(10)
                        
                        //                if isCameraOpen {
                        ////                    CameraView()
                        //                } else {
                        //                    Button(action: {(isCameraOpen = true)}
                        //                           , label: {( Image(systemName: "camera.fill")
                        //                            .imageScale(.large)
                        //                            .foregroundColor(.red)
                        //                            .font(.system(size:25))
                        //                           )}
                        //                    )
                        //                    .padding()
                        //                }
                        
                    }
                    
                    VStack(spacing: 0) {
                        Spacer()
                        Spacer()
                        
                        HStack{
                            //                    Button(action: {(selectedCircleIndex=nil)}, label: {(Text("x"))})
                            
                            locationPreviewStack
                            
                        }
                        
                    }
                    
                    if isCameraOpen {
                        CameraView()
                    }
                    HStack {
                        Spacer()
                        VStack {
                            if isCameraOpen {
                                Button(action: {(isCameraOpen = false)}
                                       , label: {
                                    (Text("  Back to Map  ")
                                        .foregroundColor(.white)
                                        .background(Color.blue)
                                        .cornerRadius(12)
                                     //                                Image(systemName: "x.circle.fill")
                                        .imageScale(.large)
                                        .foregroundColor(.red)
                                        .font(.title3)
                                     
                                     
                                    )}
                                )
                                .padding([.top, .trailing], 15.0)
                            }
                            Spacer()
                            
                            
                        }
                        
                    }
                    
                }
                .onAppear {
                    showUserLocation = true
                    locationManager.delegate = locationManagerDelegate
                    locationManager.requestWhenInUseAuthorization()
                    locationManager.startUpdatingLocation()
                    
                    if let userLocation = locationManager.location?.coordinate {
                        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                        let region = MKCoordinateRegion(center: userLocation, span: span)
                        mapRegion = region
                    }
                }
                .onDisappear {
                    locationManagerDelegate.stopUpdatingLocation()
                }
            }
            
            
            
            
            
            
            
            VStack {
                
                HStack {
                    Spacer()
                
                    
                    Button(action: {
                        withAnimation {
                            isMenuVisible.toggle()
                        }
                    }) {
                        Text(isMenuVisible ? "Hide Legend" : "View Legend")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(30)
                            .font(.custom("Arial", size: 15).bold())
                            .font(.title2)
                    }
                    .padding(.leading, 30)
                    .offset(x: 8)
                              
                    Spacer()
                    Button(action: {
                        isShowingProfile.toggle()
                    }) {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .imageScale(.large)
                            .foregroundColor(.blue)
                            .padding(.bottom,15)
                            .cornerRadius(10)
                            .shadow(radius: 4)
                            .padding(.trailing, 10.0)
                    }
                    .offset(x:-7,y: 6)
                    .sheet(isPresented: $isShowingProfile) {
                        Profile()
                            .presentationDetents([.large, .medium, .fraction(0.80)])
                    }
                    
                }
                .padding(.top, 50.0)
                .padding(.bottom)
                Spacer()
                
                
            }
        }
        .ignoresSafeArea(.all)
    }
    
    private func simulateButtonPress() {
        isAnimatingToUserLocation = true
        if let userLocation = locationManager.location?.coordinate {
            withAnimation {
                let newRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters: 1000, longitudinalMeters: 1000)
                mapRegion = newRegion
            }
        }
    }
    
    
    private func isWithin100Meters(location: Location) -> Bool {
        guard let userLocation = locationManagerDelegate.userLocation else {
            return false
        }
        
        let locationCoordinate = location.coordinates
        let distance = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude).distance(from: CLLocation(latitude: locationCoordinate.latitude, longitude: locationCoordinate.longitude))
        
        return distance <= 210
    }
    
    private var mapLayer: some View {
        
        
        GeometryReader { geo in
            Map(
            
                coordinateRegion: $mapRegion,
                interactionModes: MapInteractionModes.all,
                showsUserLocation:showUserLocation,
                userTrackingMode:.constant(.none),
                annotationItems: visibleLocations
            ) { location in
                MapAnnotation(coordinate: location.coordinates) {
                    let kilometerSize = (geo.size.height / mapRegion.spanLatitude.converted(to: .kilometers).value)
                    
                    let circleIndex = visibleLocations.firstIndex(of: location)!
                    let isSelectedCircle = selectedCircleIndex == circleIndex
                    if location.isStory == 1 {
                        Circle()
                        //                             .fill(isSelectedCircle ? Color.yellow.opacity(0.5) : (isWithin100Meters(location: location) ? Color.blue.opacity(0.5) : Color.green.opacity(0.5)))
                        //
                            .fill(isWithin100Meters(location: location) ? Color.blue.opacity(0.5) : isSelectedCircle ? Color.green.opacity(0.5):Color.yellow.opacity(0.5))
                        
                        
                            .frame(width: kilometerSize, height: kilometerSize)
                            .scaleEffect(isSelectedCircle ? 1.5 : 1.0)
                        
                        
                            .animation(.spring(), value: isSelectedCircle)
                            .overlay(
                                Circle()
                                    .stroke(Color.black, lineWidth: 2)
                                    .frame(width: kilometerSize, height: kilometerSize)
                                    .scaleEffect(isSelectedCircle ? 1.5 : 1.0)
                                    .animation(.spring(), value: isSelectedCircle)
                            )
                            .fixedSize()
                            .onTapGesture {
                                if isSelectedCircle {
                                    selectedCircleIndex = -1 // Annulla la selezione del cerchio
                                } else {
                                    selectedCircleIndex = circleIndex // Aggiorna l'indice del cerchio selezionato
                                    selectedLocation = location
                                    selectedCoordinate = location.coordinates
                                    vm.showNextLocation(location: location)
                                    
                                    withAnimation {
                                        let newCenter = CLLocationCoordinate2D(latitude: location.coordinates.latitude, longitude: location.coordinates.longitude)
                                        let newRegion = MKCoordinateRegion(center: newCenter, span: mapRegion.span)
                                        mapRegion = newRegion
                                    }
                                }
                            }
                        
                    } else
                    if location.isStory == 2 {
                            Circle()
                            //                             .fill(isSelectedCircle ? Color.yellow.opacity(0.5) : (isWithin100Meters(location: location) ? Color.blue.opacity(0.5) : Color.green.opacity(0.5)))
                            //
                                .fill(isWithin100Meters(location: location) ? Color.blue.opacity(0.5) : isSelectedCircle ? Color.purple.opacity(0.5):Color.yellow.opacity(0.5))
                            
                            
                                .frame(width: kilometerSize, height: kilometerSize)
                                .scaleEffect(isSelectedCircle ? 1.5 : 1.0)
                            
                            
                                .animation(.spring(), value: isSelectedCircle)
                                .overlay(
                                    Circle()
                                        .stroke(Color.black, lineWidth: 2)
                                        .frame(width: kilometerSize, height: kilometerSize)
                                        .scaleEffect(isSelectedCircle ? 1.5 : 1.0)
                                        .animation(.spring(), value: isSelectedCircle)
                                )
                                .fixedSize()
                                .onTapGesture {
                                    if isSelectedCircle {
                                        selectedCircleIndex = -1 // Annulla la selezione del cerchio
                                    } else {
                                        selectedCircleIndex = circleIndex // Aggiorna l'indice del cerchio selezionato
                                        selectedLocation = location
                                        selectedCoordinate = location.coordinates
                                        vm.showNextLocation(location: location)
                                        
                                        withAnimation {
                                            let newCenter = CLLocationCoordinate2D(latitude: location.coordinates.latitude, longitude: location.coordinates.longitude)
                                            let newRegion = MKCoordinateRegion(center: newCenter, span: mapRegion.span)
                                            mapRegion = newRegion
                                        }
                                    }
                                }

                    } else
                    
                    
                    {
                        Circle()
                        //                                              .fill(isSelectedCircle ? Color.gray.opacity(0.4) : (isWithin100Meters(location: location) ? Color.blue.opacity(0.5) : Color.gray.opacity(0.5)))
                        
                        
                            .fill(isWithin100Meters(location: location) ? Color.blue.opacity(0.5) : isSelectedCircle ? Color.gray.opacity(0.3):Color.gray.opacity(0.5))
                            .frame(width: kilometerSize, height: kilometerSize)
                        //                                              .scaleEffect(isSelectedCircle ? 1.5 : 1.0)
                            .scaleEffect(isWithin100Meters(location: location)  ? 1.5 : isSelectedCircle ? 1.5 : 1.0)
                            .animation(.spring(), value: isSelectedCircle)
                            .overlay(
                                Circle()
                                    .stroke(Color.black, lineWidth: 2)
                                    .frame(width: kilometerSize, height: kilometerSize)
                                //                                                      .scaleEffect(isSelectedCircle ? 1.5 : 1.0)
                                    .scaleEffect(isWithin100Meters(location: location)  ? 1.5 : isSelectedCircle ? 1.5 : 1.0)
                                    .animation(.spring(), value: isSelectedCircle)
                            )
                            .fixedSize()
                            .onTapGesture {
                                if isSelectedCircle {
                                    selectedCircleIndex = -1 // Annulla la selezione del cerchio
                                } else {
                                    selectedCircleIndex = circleIndex // Aggiorna l'indice del cerchio selezionato
                                    selectedLocation = location
                                    selectedCoordinate = location.coordinates
                                    vm.showNextLocation(location: location)
                                    
                                    withAnimation {
                                        let newCenter = CLLocationCoordinate2D(latitude: location.coordinates.latitude, longitude: location.coordinates.longitude)
                                        let newRegion = MKCoordinateRegion(center: newCenter, span: mapRegion.span)
                                        mapRegion = newRegion
                                    }
                                }
                            }
                    }
                }
                
            }
            
        }
        
    }
    

    private var visibleLocations: [Location] {
        guard let userLocation = locationManagerDelegate.userLocation else {
            return []
        }
        
        var maxDistance: Double = 0
        
        switch selectedDistance {
        case "Torna alla tua posizione":
            maxDistance = 40075000
        default:
            maxDistance = 40075000 // Valore predefinito
        }
        
        return vm.locations.filter { location in
            let locationCoordinate = location.coordinates
            let distance = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude).distance(from: CLLocation(latitude: locationCoordinate.latitude, longitude: locationCoordinate.longitude))
            return distance <= maxDistance
        }
    }
    
    private var locationPreviewStack: some View {
        
        
        ZStack {
            VStack {
                
                
                ZStack {
                    ForEach(vm.locations) { location in
                        if (vm.mapLocation == location && showLocationPreview) || (selectedLocation == location) {
                            LocationPreviewView(selectedLocation: $selectedLocation, location: location, selectedCircleIndex: $selectedCircleIndex)
//                                .background(Color.white.opacity(0.8))
                                .cornerRadius(10)
                                .padding(10)
                                .shadow(radius: 5)
                                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                                .onTapGesture {
                                    isDistanceButtonActive = true // Imposta isDistanceButtonActive su true quando viene premuta la vista LocationPreviewView
                                }
                        }
                    }
                }
                
                
                
                
                
                
                //                HStack {
                //                    Spacer(minLength: 10)
                //
                //                    Button(action: {
                //                        isAnimatingToUserLocation = true
                //                        if let userLocation = locationManager.location?.coordinate {
                //                            withAnimation {
                //                                let newRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters: 1000, longitudinalMeters: 1000)
                //                                mapRegion = newRegion
                //                            }
                //                        }
                //                    }) {
                //                        Image(systemName: "location.fill")
                //                            .imageScale(.large)
                //                            .foregroundColor(.blue)
                //                            .padding()
                //                            .background(Color.white)
                ////                            .clipShape(Circle())
                //                            .shadow(radius: 4)
                //                            .background(.ultraThickMaterial)
                //                            .cornerRadius(10)
                //                            .font(.system(size:25))
                //                            .imageScale(.large)
                //
                //
                //                    }
                //
                //                    .animation(.spring())
                //
                //
                //
                //
                //                    //MARK: camera button
                //                    //                   Spacer()
                //                    Button(action: {(isCameraOpen = true)}
                //                           , label: {( Image(systemName: "camera.fill")
                //                            .imageScale(.large)
                //                            .foregroundColor(.blue)
                //                            .font(.system(size:25))
                //                           )}
                //                    )
                //                    .background(.ultraThickMaterial)
                //                    .cornerRadius(10)
                //
                //                    //                        .padding()
                //
                //                    Spacer(minLength: 30)
                //
                //                }
                
                
                
                //                .padding(5)
                
                HStack {
                    
                    
                    Button(action: {
                        isAnimatingToUserLocation = true
                        selectedLocation = nil
                         if let userLocation = locationManager.location?.coordinate {
                            withAnimation {
                                let newRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters: 1000, longitudinalMeters: 1000)
                                mapRegion = newRegion
                            }
                        }
                    })  {
                        Image(systemName: "location.fill")
                            .imageScale(.large)
                            .foregroundColor(.blue)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(50)
                            .shadow(radius: 4)
                    }
                    .animation(.spring())
//                    .offset(x: -120, y: 0) // Offset per posizionarlo a sinistra
                    
                    Button(action: {
                        withAnimation(.easeInOut) {
                            selectedTab = 1
                        }
                    }) {
                        VStack () {
                            Button(action: {
                                isMainPagePresented = true
                            }) {
                                HStack {
                                    Image(systemName: "lock.open")
                                        .resizable()
                                        .frame(width: 15, height: 15)
                                        .imageScale(.large)
                                        .foregroundColor(.white)
                                    
                                    Text("Unlocked Places")
                                        .font(.custom("Arial", size: 15).bold())
                                        .font(.title2)
                                        .foregroundColor(selectedTab == 1 ? .white : .white)
                                }
                                .padding()
                                .background(Color.blue.opacity(0.9))
                                .cornerRadius(30)
                                .shadow(radius: 4)
                            }
                            .sheet(isPresented: $isMainPagePresented) {
                                MainPage()
                                    .presentationDetents([.large, .medium, .fraction(0.80)])
                            }
                            
                        }
//                        .padding(.bottom)
//                        .padding(.top,10.0)
                    }

                    
                    //MARK: camera button
                    //                   Spacer()
                    Button(action: {
                        isCameraPresented = true
                    }) {
                        Image(systemName: "camera.fill")
                            .imageScale(.large)
                            .foregroundColor(.blue)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(50)
                            .shadow(radius: 4)
                    }
//                    .offset(x: -120, y: 0) // Offset per posizionarlo a destra
                    .sheet(isPresented: $isCameraPresented) {
                        CameraView()
                    }
                }
            }
        }
        .animation(.easeInOut)
    }
    
    //    private func distanceButton(title: String, distance: Double) -> some View {
    //        Button(action: {
    //            if let userLocation = locationManagerDelegate.userLocation {
    //                let region = MKCoordinateRegion(center: userLocation, latitudinalMeters: distance, longitudinalMeters: distance)
    //                mapRegion = region
    //            }
    //            selectedDistance = title
    //            isDistanceButtonActive = false // Imposta la variabile isDistanceButtonActive a true quando viene premuto il bottone
    //        }) {
    //
    //            Image(systemName: "location.circle.fill")
    //                .imageScale(.large)
    //                .foregroundColor(.blue)
    //                .font(.system(size:25))
    //            //            Text(title)
    //            //                .foregroundColor(selectedDistance == title ? .white : .black)
    //            //                .padding(.vertical, 8)
    //            //                .padding(.horizontal, 16)
    //            //                .background(selectedDistance == title ? Color.blue : Color.clear)
    //            //                .cornerRadius(10)
    //        }
    //    }
}





struct ScaledAnnotationView: View {
    //    @ObservedObject var locationsViewModel: LocationsViewModel
    
    static let usersLocation = CLLocationCoordinate2D(latitude: 52.0929779694589, longitude: 5.084964426384347)
    
    @State private var region = MKCoordinateRegion(
        center: ScaledAnnotationView.usersLocation,latitudinalMeters: 1000, longitudinalMeters: 1000
    )
    let annotations = [CurrentUsersAnnotation()]
    
    
    var body: some View {
        //Get the size of the frame for scale
        GeometryReader{ geo in
            Map(
                coordinateRegion: $region, annotationItems: annotations) { _ in
                    MapAnnotation(coordinate: ScaledAnnotationView.usersLocation) {
                        //Size per kilometer or any unit, just change the converted unit.
                        let kilometerSize = (geo.size.height/region.spanLatitude.converted(to: .kilometers).value)
                        Circle()
                            .fill(Color.red.opacity(0.5))
                        //Keep it a circle
                            .frame(width: kilometerSize, height: kilometerSize)
                    }
                }
        }
    }
}

struct CurrentUsersAnnotation: Identifiable {
    let id = UUID() // Always unique on map
}

extension MKCoordinateRegion{
    ///Identify the length of the span in meters north to south
    var spanLatitude: Measurement<UnitLength>{
        let loc1 = CLLocation(latitude: center.latitude - span.latitudeDelta * 1.8, longitude: center.longitude)
        let loc2 = CLLocation(latitude: center.latitude + span.latitudeDelta * 1.8, longitude: center.longitude)
        let metersInLatitude = loc1.distance(from: loc2)
        return Measurement(value: metersInLatitude, unit: UnitLength.meters)
    }
}
class LocationManagerDelegate: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var userLocation: CLLocationCoordinate2D?
    
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first?.coordinate {
            userLocation = location
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse {
            startUpdatingLocation()
        }
    }
    
    
    
}

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
