//
//  LocationMapAnnotationView.swift
//  Map Annotation Places FinditAdvanced
//
//  Created by Lorenzo Mazza on 28/06/23.
//

import SwiftUI

struct LocationMapAnnotationView: View {
    
    let accentColor = Color("AccentColor")
    
    var body: some View {
        VStack(spacing: 0) {
            Image("bandiera")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .font(.headline)
                .foregroundColor(.red)
                .padding(6)
        }
    }
}

struct LocationMapAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.black.ignoresSafeArea()
        }
        LocationMapAnnotationView()
    }
}
