//
//  LocationPreviewView.swift
//  Map Annotation Places FinditAdvanced
//
//  Created by Lorenzo Mazza on 28/06/23.
//
/*
 import SwiftUI
 import UIKit
 
 struct LocationPreviewView: View {
 @EnvironmentObject private var vm: LocationsViewModel
 @State private var isHidden: Bool = false
 let location: Location
 
 var body: some View {
 if !isHidden {
 HStack {
 HStack(alignment: .top) {
 Button(action: {
 isHidden = true
 }) {
 Image(systemName: "xmark")
 .foregroundColor(.red)
 .padding(.trailing, 0)
 .bold()
 }
 .padding(.top, 15)
 
 titleSection
 .padding(.top, 5)
 .padding(.bottom, 10)
 }
 
 HStack(spacing: 20) {
 learnMoreButton
 .padding(.bottom, 0)
 
 openInMapButton
 }
 .padding(.bottom, 10)
 }
 .padding(10)
 .background(
 RoundedRectangle(cornerRadius: 10)
 .fill(.ultraThickMaterial)
 )
 .cornerRadius(15)
 .padding(.bottom, 15)
 }
 }
 }
 
 struct LocationPreviewView_Previews: PreviewProvider {
 static var previews: some View {
 ZStack {
 Color.green.ignoresSafeArea()
 LocationPreviewView(location: LocationsDataService.locations.first!)
 .padding()
 }
 .environmentObject(LocationsViewModel())
 }
 }
 
 
 extension LocationPreviewView{
 private var imageSection: some View{
 ZStack{
 if let imageName = location.imageNames.first{
 }
 }
 .padding(5)
 .cornerRadius(10)
 }
 
 
 private var titleSection: some View{
 HStack(alignment:.center, spacing: 10){
 Text(location.name)
 .font(.title)
 .fontWeight(.medium)
 /*
  Text(location.cityName)
  .font(.subheadline)
  .fontWeight(.light)
  */
 
 }
 .frame(maxWidth: .infinity, alignment: .leading)
 }
 
 private var learnMoreButton: some View {
 Image("easy_access")
 .resizable()
 .scaledToFit()
 .frame(width: 30, height: 30)
 .foregroundColor(.black)
 .onTapGesture {
 showAlert()
 }
 }
 
 private func showAlert() {
 let alert = UIAlertController(title: nil, message: "Questo luogo è accessibile a persone che usufruiscono di sedia a rotelle per spostarsi.", preferredStyle: .alert)
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
 .foregroundColor(.black)
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
 */
