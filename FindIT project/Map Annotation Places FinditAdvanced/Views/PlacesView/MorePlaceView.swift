//
//  MorePlaceView.swift
//  progetto9luglio
//
//  Created by checca on 09/07/23.
//

import SwiftUI

struct MorePlaceView: View {
    var body: some View {
        VStack {
            Text("More Place")
                .font(.custom("Arial", size: 24).bold())
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color.white).ignoresSafeArea()
    }
}

struct MorePlaceView_Previews: PreviewProvider {
    static var previews: some View {
        MorePlaceView()
    }
}
