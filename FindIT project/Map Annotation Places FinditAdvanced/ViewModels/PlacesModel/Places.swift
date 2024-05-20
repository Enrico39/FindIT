//
//  Places.swift
//  progetto9luglio
//
//  Created by checca on 09/07/23.
//

import SwiftUI

enum Modes: String, Codable, CaseIterable {
    case exploring = "Explorer"
    case stories = "Stories"
}

struct Places: Codable, Identifiable, Hashable {
    var id = UUID().uuidString
    var type: Modes
    var name: String
    var description: String = ""
    var image: String = ""
    var imageFull: String = ""
    var isLiked: Bool = false

}

