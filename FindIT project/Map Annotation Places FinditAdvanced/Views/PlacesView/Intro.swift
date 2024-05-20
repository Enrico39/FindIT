//
//  Intro.swift
//  Tutorial
//
//  Created by Francesco on 22/06/23.
//

import SwiftUI


//MARK: Intro Model
struct Intro: Identifiable {
    var id: String = UUID().uuidString
    var imageName: String
    var title: String
    var text: String
}

var intros: [Intro] = [
    .init(
        imageName: "explore",
        title: "Explore",
        text: "Explore hidden places with FindIt. Discover secret corners, unknown historical sites and hidden wonders. Unique adventures await you. Start exploring with FindIt!"),
    .init(
        imageName: "path",
        title: "Story Mode",
        text:"Explore the story mode and immerse yourself in the fascinating stories of the places you visit. You will live unique experiences and discover the connection between places and stories. Follow the directions provided and head to the areas where the exploration begins."),
    .init(
        imageName: "ML",
        title: "Machine Learning",
        text:"Explore FindIt's groundbreaking place-scanning technology powered by machine learning to analyze and recognize unique details about every place you visit. Advanced recognition and real-time data for an immersive experience."),
]

//MARK: Font String
let sansBold = "WorkSans-Bold"
let sansSemiBold = "WorkSans-SemiBold"
let sansRegular = "WorkSans-Regular"
let sansMedium = "WorkSans-Medium"
//MARK: Dummy
let dummyText = "Find a new way to explore and discover places around you!"
let finalText = "Press the button down below."
let explorerText = "Exploring"
let storiesText = "Stories"
let MLText = "CameraML"



