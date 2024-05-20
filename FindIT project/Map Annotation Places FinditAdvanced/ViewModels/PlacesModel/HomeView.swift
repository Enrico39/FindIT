//
//  HomeView.swift
//  progetto9luglio
//
//  Created by checca on 09/07/23.
//

import SwiftUI

class HomeView: ObservableObject {
    @Published var modeType: Modes = .exploring
    
    @Published var place: [Places] = [
        Places(type: .exploring, name: "Pagoda", description: "Voluta da Marco Antonio Doria, all'interno dei giardini di Villa Doria d'Angri. Rientrava nella moda delle Chinoiserie di inizi '800, contornata da campanellini che, al soffiare del vento, ricreavano un vero e proprio angolo di Asia.", image: "pagoda", imageFull: "pagoda intera"),
        Places(type: .exploring, name: "Cimitero delle fontanelle", description: "Nel quartiere Sanità, un luogo unico al mondo, uno dei posti segreti a Napoli che non puoi assolutamente perdere: un cimitero che raccoglie circa 40.000 teschi delle vittime di Colera e Peste che colpirono Napoli nell’800.", image: "cimitero delle fontanelle", imageFull: "cimitero intera"),
        Places(type: .exploring, name: "Tomba di Giacomo Leopardi", description: "Un’ara maestosa situata all’interno di una grotta tufacea, nella quale i resti del poeta vi furono trasportati dall’ antica chiesa di S.Vitale a Fuorigrotta.", image: "tomba di leopardi", imageFull: "Tomba-di-Giacomo-Leopardi intera"),
        Places(type: .exploring, name: "Grotta di Seiano", description: "Una splendida e suggestiva grotta di circa 800 metri che attraversa la collina di Posillipo. Alla fine del tunnel, si giunge ad un fantastico sito archeologico che custodisce  i resti di un grande teatro dalla capienza di circa 2000 posti. Da qui la vista è stupenda, il mare di Posillipo si mostra in tutto il suo splendore, baciato dal sole e accarezzato dal volo dei gabbiani.", image: "grotta di seiano", imageFull: "seiano intera"),
        Places(type: .stories, name: "Leggenda di Partenope", description: "isolotto di Megaride, ", image: "Partenope senza sfondo", imageFull: "Partenope"),
        Places(type: .stories, name: "Maradona", description: "", image: "maradona senza sfondo", imageFull: "maradona"),
        Places(type: .stories, name: "La Bella ‘Mbriana", description: "", image: "la bella senza sfondo", imageFull: "la bella"),
        Places(type: .stories, name: "La leggenda di Castel dell’Ovo", description: "castel dell'ovo, sotterranei", image: "castel senza sfondo", imageFull: "castel")
    ]
    
    @Published var filteredPlace: [Places] = []
    
    @Published var showMorePlaceOnType: Bool = false
    
    init() {
        filterPlaceByType()
    }
    
    func filterPlaceByType() {
        DispatchQueue.global(qos: .userInteractive).async {
            let result = self.place
                .lazy
                .filter { luoghi in
                    return luoghi.type == self.modeType
                }
                .prefix(4)
            DispatchQueue.main.async {
                self.filteredPlace = result.compactMap({ luoghi in
                    return luoghi
                })
            }
        }
    }
}
