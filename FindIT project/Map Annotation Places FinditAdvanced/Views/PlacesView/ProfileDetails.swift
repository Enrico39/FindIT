//
//  User.swift
//  cardCarousel
//
//  Created by Enrico on 05/07/23.
//

import Foundation
import SwiftUI
import MapKit


struct DiscoveredPlace: View {
    var numeroLuoghiVisitati = ""
    var numeroLuoghiSbloccati = ""
    var numeroMosaiciCompletati = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Statistics")
                .bold()
            
            Text("Visited Places:")
                .font(.title)
                .bold()
                .padding(.bottom, 5)
            Text(numeroLuoghiVisitati)
                .font(.title)
                .padding(.bottom, 30)
            
            Text("Unlocked Places:")
                .font(.title)
                .bold()
                .padding(.bottom, 5)
            Text(numeroLuoghiSbloccati)
                .font(.title)
                .padding(.bottom, 30)
            
            Text("Completed Stories:")
                .font(.title)
                .bold()
                .padding(.bottom, 5)
            Text(numeroMosaiciCompletati)
                .font(.title)
                .padding(.bottom, 30)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding()
    }
}

struct EditProfile: View {
    var body: some View {
        Text("prova")
            .font(.title)
    }
}




struct ReportLocationView: View {
    @State private var nome: String = ""
    @State private var coordinataX: String = ""
    @State private var coordinataY: String = ""
    @State private var descrizione: String = ""
    @State private var isShowingLocationPicker = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Add Places")
                .bold()
            Spacer()

            TextField("Name", text: $nome)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                isShowingLocationPicker.toggle()
            }) {
                Text("Select Coordinates")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .sheet(isPresented: $isShowingLocationPicker) {
                LocationPicker(selectedLatitude: $coordinataX, selectedLongitude: $coordinataY) {
                    isShowingLocationPicker.toggle()
                }
            }
            
            HStack {
                Text("Latitude:")
                Spacer()
                Text(coordinataX)
            }
            
            HStack {
                Text("Longitude:")
                Spacer()
                Text(coordinataY)
            }

            TextField("Description", text: $descrizione)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                sendEmail()
            }) {
                Text("Send E-Mail")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            Button(action: {
                clearFields()
            }) {
                Text("Delete All")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(10)
            }
        }
        .font(.title)
               .padding()
               .ignoresSafeArea(.keyboard) // Ignora l'area sicura della tastiera

    }
    
    //MARK: Send mail functions
    func sendEmail() {
        let emailSubject = "Nuovo messaggio"
        let emailBody = "Nome: \(nome)\nCoord X: \(coordinataX)\nCoord Y: \(coordinataY)\nDescrizione: \(descrizione)"
        let emailTo = "team.sviluppo@find.it"

        if let emailURL = createEmailURL(to: emailTo, subject: emailSubject, body: emailBody) {
            UIApplication.shared.open(emailURL)
        }
    }

    func createEmailURL(to: String, subject: String, body: String) -> URL? {
        let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let bodyEncoded = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

        let urlString = "mailto:\(to)?subject=\(subjectEncoded)&body=\(bodyEncoded)"

        return URL(string: urlString)
    }
    
    func clearFields() {
        nome = ""
        coordinataX = ""
        coordinataY = ""
        descrizione = ""
    }
}

 

//MARK: Mail struct
struct LocationPicker: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedLatitude: String
    @Binding var selectedLongitude: String
    var onConfirm: () -> Void

 
        var body: some View {
            ZStack {
                MapView(selectedLatitude: $selectedLatitude, selectedLongitude: $selectedLongitude)
                    .edgesIgnoringSafeArea(.all)
                Image(systemName: "plus.circle.fill")
                               .font(.system(size: 32))
                               .foregroundColor(.red)
                               .shadow(radius: 2)
                VStack {
                    Spacer()

                    HStack {
                        Button("Conferma") {
                            onConfirm()
                        }
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(8)

                        Button("Annulla") {
                            selectedLatitude = ""
                            selectedLongitude = ""
                            presentationMode.wrappedValue.dismiss()
                           
                        }
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(8)
                    }
                    .padding(.bottom, 16)
                }
            }
            .navigationBarTitle("Seleziona posizione")
            .background(Color.white.edgesIgnoringSafeArea(.all))
            .edgesIgnoringSafeArea(.all)
       
        }
    }


struct MapView: UIViewRepresentable {
    @Binding var selectedLatitude: String
    @Binding var selectedLongitude: String
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView()
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.delegate = context.coordinator
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(selectedLatitude: $selectedLatitude, selectedLongitude: $selectedLongitude)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        @Binding var selectedLatitude: String
        @Binding var selectedLongitude: String
        
        init(selectedLatitude: Binding<String>, selectedLongitude: Binding<String>) {
            _selectedLatitude = selectedLatitude
            _selectedLongitude = selectedLongitude
        }
        
        func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
            let centerCoordinate = mapView.centerCoordinate
            selectedLatitude = String(format: "%.6f", centerCoordinate.latitude)
            selectedLongitude = String(format: "%.6f", centerCoordinate.longitude)
        }
    }
}


