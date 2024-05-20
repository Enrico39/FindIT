//
//  LegendView.swift
//  Map Annotation Places FinditAdvanced
//
//  Created by Enrico on 12/07/23.
//

import Foundation
import SwiftUI

struct LegendView: View {
    @State private var showingLegendDetails = false // nuova variabile di stato
     
    var body: some View {
        //        Button(action: {
        //            showingLegendDetails = true // impostiamo la variabile di stato su true quando si fa clic sulla legenda
        //        }) {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 10) {
                    ZStack {
                        Circle()
                            .fill(Color.gray)
                            .frame(width: 15, height: 15)
                        Circle()
                            .stroke(Color.black)
                            .frame(width: 15, height: 15)
                    }
                    Text("Hidden place Area")
                        .font(.caption)
                        .foregroundColor(.primary)
                }
                
                HStack(spacing: 10) {
                    ZStack {
                        Circle()
                            .fill(Color.cyan)
                            .frame(width: 15, height: 15)
                        Circle()
                            .stroke(Color.black)
                            .frame(width: 15, height: 15)
                    }
                    Text("Reached Area")
                        .font(.caption)
                        .foregroundColor(.primary)
                }
                
                HStack(spacing: 10) {
                    ZStack {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 10, height: 10)
                        Circle()
                            .stroke(Color.black)
                            .frame(width: 10, height: 10)
                    }
                    Text("Discovered Place")
                        .font(.caption)
                        .foregroundColor(.primary)
                }
                .padding(.leading, 3)
            }
            Spacer()
            Divider()
                .background(Color.gray)
                .frame(height: 65)
                .padding(.leading, -10)
            
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 10) {
                    ZStack {
                        Circle()
                            .fill(Color.yellow)
                            .frame(width: 15, height: 15)
                        Circle()
                            .stroke(Color.black)
                            .frame(width: 15, height: 15)
                    }
                    Text("Story's Place")
                        .font(.caption)
                        .foregroundColor(.primary)
                }
                
                HStack(spacing: 10) {
                    ZStack {
                        Circle()
                            .stroke(Color.black, lineWidth: 2)
                            .background(
                                AngularGradient(
                                    gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple]),
                                    center: .center,
                                    startAngle: .zero,
                                    endAngle: .degrees(360)
                                )
                            )
                            .clipShape(Circle())
                            .frame(width: 15, height: 15)
                    }
                    Text("Selected Story's Place")
                        .font(.caption)
                        .foregroundColor(.primary)
                }
                
                HStack(spacing: 10) {
                    ZStack {
                        Circle()
                            .stroke(Color.black, lineWidth: 2)
                            .background(
                                AngularGradient(
                                    gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple]),
                                    center: .center,
                                    startAngle: .zero,
                                    endAngle: .degrees(360)
                                )
                            )
                            .clipShape(Circle())
                            .frame(width: 10, height: 10)
                    }
                    Text("Discovered Story's Place")
                        .font(.caption)
                        .foregroundColor(.primary)
                }
                .padding(.leading, 3)
            }
            .padding(.leading, -5)
        }
//    }
                            
                            .padding()
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(10)
                            .padding(10)
                            .padding(.top, 70)
                            .shadow(radius: 5)
//                            .sheet(isPresented: $showingLegendDetails) {
//                                        LegendDetailsView()
//                                        .presentationDetents([.large, .medium, .fraction(0.80)])
//                                    }
                            .frame(maxWidth: .infinity, alignment: .top)
                        }
                    }

                    struct LegendDetailsView: View {
                        var body: some View {
                            VStack(spacing: 20) {
                                Text("Legenda")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                                    .padding(.top, 20)
                    //                .padding(.leading, 20)
                                    .multilineTextAlignment(.center)
                                    
                                VStack(alignment: .leading, spacing: 15) {
                                    LegendCircleView(color: .gray, name: "Hidden place Area", description: "Area nascosta")
                                    LegendCircleView(color: .cyan, name: "Reached Area", description: "Area raggiunta")
                                    LegendCircleView(color: .red, name: "Discovered Place", description: "Luogo scoperto")
                                    LegendCircleView(color: .yellow, name: "Story's Place", description: "Luogo della modalità storia")
                                    GradientLegendCircleView(name: " Selected Story's Place", description: "Luogo della modalità storia selezionato", startColor: .green, endColor: .blue)
                                    GradientLegendCircleView(name: "Discovered Story's Place", description: "Luogo della modalità storia selezionato scoperto", startColor: .black, endColor: .gray)
                                }
                                .padding(.leading, 20)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                Spacer()
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color.white)
                        }
                    }

                    struct GradientLegendCircleView: View {
                        let name: String
                        let description: String
                        let startColor: Color
                        let endColor: Color

                        var body: some View {
                                VStack(alignment: .leading, spacing: 5) {
                                    HStack(spacing: 10) {
                                        ZStack {
                                            Circle()
                                                .stroke(Color.black, lineWidth: 2)
                                                .background(
                                                    AngularGradient(
                                                        gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple]),
                                                        center: .center,
                                                        startAngle: .zero,
                                                        endAngle: .degrees(360)
                                                    )
                                                )
                                                .clipShape(Circle())
                                                .frame(width: 15, height: 15)
                                        }
                        //                .padding(.top, 15)
                                        VStack(alignment: .leading, spacing: 5){
                                            Text(name)
                                                .font(.caption)
                                                .foregroundColor(.primary)
                                            Text(description)
                                                .font(.footnote)
                                                .foregroundColor(.secondary)
                                        }
                                        
                                    }
                                    
                                }
                                    
                            }
                        }

                        struct LegendCircleView: View {
                            let color: Color
                            let name: String
                            let description: String

                            var body: some View {
                                HStack(spacing: 10) {
                                    ZStack {
                                        Circle()
                                            .fill(color)
                                            .frame(width: 15, height: 15)
                                        Circle()
                                            .stroke(Color.black)
                                            .frame(width: 15, height: 15)
                                    }
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text(name)
                                            .font(.caption)
                                            .foregroundColor(.primary)
                                        Text(description)
                                            .font(.footnote)
                                            .foregroundColor(.secondary)
                                    }
                                }
                            }
                        }
