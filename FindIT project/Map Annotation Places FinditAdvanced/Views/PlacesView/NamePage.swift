//
//  NamePage.swift
//  progetto9luglio
//
//  Created by checca on 09/07/23.
//

import SwiftUI

struct NamePage: View {
    @StateObject var loginData: NamePageModel = NamePageModel()
    @State private var showReportLocation = false
    @AppStorage("userName") var name: String = ""

    var body: some View {
        VStack {
            Text("Welcome ")
                .font(Font.custom("Arial", size: 40).bold())
                .foregroundColor(.white)
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding()
                .background(
                    Image("intro")
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .offset(y: -10)
                )
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 15) {
                    Text("Please put your name or a username below:")
                        .font(Font.custom("Arial", size: 22).bold())
                        .frame(maxWidth: .infinity, alignment:.leading)
                    
                    CustomTextField(hint: "Your Name", value: $name)
                        .padding(.top,50)
                    
                    Button {
                        loginData.login()
                    } label: {
                        Text("Start exploring!")
                            .font(Font.custom("Arial", size: 17).bold())
                            .padding(.vertical,20)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(15)
                            .shadow(color: Color.black.opacity(0.07), radius: 5, x: 5, y: 5)
                    }
                    .padding(.top, 40)
                    .padding(.horizontal)
                }
                .padding(30)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
            .clipShape(CustomCorners(corners: [.topLeft,.topRight], radius: 25))
            .ignoresSafeArea()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.blue)
    }
    
    @ViewBuilder
    func CustomTextField(hint: String, value: Binding<String>) -> some View {
        VStack (alignment: .leading, spacing: 12) {
            TextField(hint, text: value)
                .padding(.top,4)
            
            Divider()
                .background(Color.black.opacity(0.4))
        }
    }
}

struct NamePage_Previews: PreviewProvider {
    static var previews: some View {
        NamePage()
    }
}
