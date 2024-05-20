//
//  LocationsListView.swift
//  Map Annotation Places FinditAdvanced
//
//  Created by Lorenzo Mazza on 28/06/23.
//

import SwiftUI

struct LocationsListView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    
    var body: some View {
        List{
            ForEach(vm.locations){ location in
                Button{
                    vm.showNextLocation(location: location)
                } label: {
                    listRowView(location: location)
                }
                    .padding(.vertical, 4)
                    .listRowBackground(Color.clear)
            }
        }
        .listStyle(PlainListStyle())
    }
}

struct LocationsListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsListView()
            .environmentObject(LocationsViewModel())
    }
}

extension LocationsListView {
    
    private func listRowView(location: Location) -> some View{
        HStack{            
            VStack(alignment: .leading){
                Text(location.name)
                    .font(.headline)
                Text(location.cityName)
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
}
