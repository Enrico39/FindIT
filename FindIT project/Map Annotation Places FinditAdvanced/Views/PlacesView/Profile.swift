//
//  Profile.swift
//  progetto9luglio
//
//  Created by checca on 09/07/23.
//

import SwiftUI

struct Profile: View {
    @AppStorage("userName") var name: String = ""
    @State private var isShowingDiscoveredPlaces = false
    @State private var isShowingAddPlaces = false
    
    @AppStorage("notify") var isToggleOn: Bool = true
    @StateObject private var locationManager = LocationManager()
    @State private var notificationColor: Color = .gray // Aggiungi questa riga
    
    var body: some View {
        /*
         ScrollView(.vertical, showsIndicators: false) {
         VStack {
         VStack (spacing: 15) {
         Image("patrick")
         .resizable()
         .aspectRatio(contentMode: .fill)
         .frame(width: 200, height: 200)
         .clipShape(Circle())
         .overlay(
         Circle()
         .stroke(Color.blue, lineWidth: 2)
         )
         .padding(4)
         
         Text("Username: \(name)")
         .font(.custom("Arial", size: 16))
         .fontWeight(.semibold)
         }
         .padding([.horizontal, .bottom])
         .padding()
         .padding(.top, 40)
         
         //                Button(action: {
         //                    isShowingDiscoveredPlaces.toggle()
         //                }) {
         //                    Text("Statistics")
         //                        .font(.body.bold())
         //                        .foregroundColor(.white)
         //                        .padding()
         //                        .background(Color.blue)
         //                        .cornerRadius(10)
         //                }
         //                .sheet(isPresented: $isShowingDiscoveredPlaces) {
         //                    NavigationView {
         //                        DiscoveredPlace()
         //                    }
         //                }
         
         Button(action: {
         isShowingAddPlaces.toggle()
         }) {
         Text("Add Places")
         .font(.body.bold())
         .foregroundColor(.white)
         .padding()
         .background(Color.blue)
         .cornerRadius(10)
         }
         .sheet(isPresented: $isShowingAddPlaces) {
         NavigationView {
         ReportLocationView()
         }
         }
         
         
         Toggle(isOn: $isToggleOn) {
         Text("Notifications")
         }
         .padding()
         .foregroundColor(notificationColor) // Aggiorna questa riga
         .onChange(of: isToggleOn) { newValue in
         if newValue {
         locationManager.startMonitoringGeofences()
         notificationColor = .blue // Aggiungi questa riga
         print("notifiche si")
         } else {
         locationManager.stopMonitoringGeofences()
         notificationColor = .gray // Aggiungi questa riga
         print("notifiche no")
         }
         }
         }
         .navigationTitle("My Profile")
         .navigationBarTitleDisplayMode(.large)
         .padding(.horizontal, 22)
         .padding(.vertical, 20)
         }
         .frame(maxWidth: .infinity, maxHeight: .infinity)
         .background(Color.gray.opacity(0.09))
         */
        NavigationView{
            VStack {
                VStack (spacing: 15) {
                    Spacer()
                    Image("patrick")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.blue, lineWidth: 2)
                        )
                        .padding(4)
                    Section {
                        Label ("Username: \(name)", systemImage:
                                "person.fill" )
                        .foregroundColor (.black)
                        .font (.system(size: 16, weight: .semibold))
                    }
                    Form {
                        Section(
                            footer: Text("Notifications allows you to receive informations about secret places around you.")){
                                
                                Toggle (isOn: $isToggleOn,
                                        label: {
                                    Text ("Notifications")
                                }).onChange(of: isToggleOn) { newValue in
                                    if newValue {
                                        locationManager.startMonitoringGeofences()
                                        notificationColor = .blue // Aggiungi questa riga
                                        print("notifiche si")
                                    } else {
                                        locationManager.stopMonitoringGeofences()
                                        notificationColor = .gray // Aggiungi questa riga
                                        print("notifiche no")
                                    }
                                }
                            }
                        
                        
                        Section(
                            footer: Text("With this function you can expand the app's dataset with places that you have already visited.")){
                                Button(action: {
                                    isShowingAddPlaces.toggle()
                                }) {
                                    HStack{
                                        Image(systemName: "plus.app.fill")
                                        Text("Add a new place")
                                        Image(systemName: "arrow.up")
                                            .padding(.leading, 130)
                                            .foregroundColor(.gray)
                                    }
                                    .sheet(isPresented: $isShowingAddPlaces) {
                                            NavigationView {
                                                ReportLocationView()
                                            }
                                        }
                                }
                            }
                    }
                }
            }
        }
    }
}

@ViewBuilder
func CustomNavigationLink<Detail: View>(title: String, @ViewBuilder content: @escaping () -> Detail) -> some View {
    NavigationLink {
        content()
    } label: {
        HStack {
            Text(title)
                .font(.custom("Arial", size: 17))
                .fontWeight(.semibold)
            Spacer()
            Image(systemName: "chevron.right")
        }
        .foregroundColor(.black)
        .padding()
        .background(
            Color.white
                .cornerRadius(12)
        )
        .padding(.horizontal)
        .padding(.top,10)
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
