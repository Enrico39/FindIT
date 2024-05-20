import Foundation

import MapKit

 

 

 

class LocationsDataService {

    

    static let locations: [Location] = [

        Location (

            name: "Pagoda Cinese",

            cityName: "Villa Doria d’Angri, 80",

            coordinates: CLLocationCoordinate2D(latitude: 40.822426428052665, longitude: 14.216080766367831),

            baseDescription: "La ricostruzione in legno e muratura della Pagoda Cinese si trova all’interno di Villa Doria d’Angri (oggi sede dell’Università degli studi di Napoli, Parthenope).",

            unlockedDescription: "Nella seconda metà dell’Ottocento fungeva da saletta del tè per i suoi nobili proprietari; ma non solo, immaginate di bere il tè ascoltando la melodia del vento suonata da piccole campanelle di bronzo poste sulle sue guglie.",

            imageName:

                "pagoda",

            isUnlocked: false,
            
            isStory: 0

        ),

        Location (

            name: "Uomo Villoso",

            cityName: "Via Mezzocannone, 9",

            coordinates: CLLocationCoordinate2D(latitude: 40.84518781462174, longitude: 14.257012659698661),

            baseDescription: "Ti sorprenderà vedere un bassorilievo di un uomo completamente ricoperto di peli.",

            unlockedDescription: "Ti sorprenderà vedere un bassorilievo di un uomo completamente ricoperto di peli. Leggenda (ma anche numerosi studi) vuole che questa sia la rappresentazione di Orione. Il gigante cacciatore per sfuggire ad Apollo si rifugiò in mare ma venne colpito a morte da Diana che lo trasformò in una costellazione. A Napoli l’uomo villoso è noto come Colapesce",

            imageName:

                "uomovilloso",

            isUnlocked: false,
            
            isStory: 0


        ),

        Location (

            name: "Fontana delle Zizze",

            cityName: "Via Giuseppina Guacci Nobile, 9)",

            coordinates: CLLocationCoordinate2D(latitude: 40.84625259990502, longitude: 14.25870320000001),

            baseDescription: "La Fontana delle Zizze: Addossata alla chiesa di Santa Caterina della Spina Corona, si erge la fontana della Spinacorona, situata precisamente in Via Giuseppina Guacci Nobile n.9 comunemente conosciuta come \"fontana delle zizze\" ",

            unlockedDescription: "Ora hai la possibilità di notare una donna con ali e zampe d’uccello dai cui seni sgorga l’acqua. Questa è la rappresentazione originale della sirena, e venne realizzata nel 1540. La sirena dal nome Partenope, che generà Napoli e il suo popolo, fa uscire dai seni l’acqua in direzione dell’altorilievo del Vesuvio. Questo serviva per proteggere la città dall’eruzioni del vulcano.",

            imageName:

                "fontanadellezizze",

            isUnlocked: false,
            
            isStory: 0


        ),


        Location (

            name: "Sedia della Fecondità",

            cityName: "Vico Tre Re a Toledo, 13",

            coordinates: CLLocationCoordinate2D(latitude: 40.840489890433254, longitude: 14.24774050469504),

            baseDescription: "Sedia della fecondità situata presso i famosi quartieri spagnoli, precisamente nella casa dove visse Santa Maria Francesca delle Cinque Piaghe.",

            unlockedDescription: "Pare ci sia una sedia miracolosa che può aiutare le donne ad essere più feconde o a far vivere una gravidanza stabile e tranquilla. Napoli è una città in cui fede e magia si fondono insieme e per questo motivo questo luogo, e in particolare la sedia dove Santa Teresa sedeva, pare avere dei benefici. Ogni giorno tantissime donne vengono qui e si può respirare un’aria di sorellanza davvero delicata e intima.",

            imageName:

                "sedia",

            isUnlocked: false,
            
            isStory: 0


        ),


     Location (

            name: "Vico Totò",

            cityName: "Via Portacarrese a Montecalvario, 31",

            coordinates: CLLocationCoordinate2D(latitude: 40.84177869999994,longitude: 14.245938100000046),

            baseDescription: "Il trionfo della street art, nei Quartieri Spagnoli",

            unlockedDescription: "La Portacarrese a Montecalvario è un vero museo a cielo aperto: i cittadini hanno offerto i muri e i numerosi artisti hanno lasciato il loro segno. Non solo richiami ai film di Totò, come il \"Totò donna\" ispirato al Totòtruffa ’62, ma anche graffiti in cui il Principe è protagonista di scene inusuali: Totò astronauta, per omaggiare i 50 anni dallo sbarco sulla luna, o ancora Totò nelle vesti di Re di Denari, celebre carta da gioco napoletana.",

            imageName:
                "vicototo",
            
            isUnlocked: false,
            
            isStory: 0

        ),


    Location (

        name: "Murales di Maradona - Jorit",

        cityName: "Strada Comunale Taverna del Ferro, 80146 Napoli NA",

        coordinates: CLLocationCoordinate2D(latitude: 40.832142303787165 ,longitude: 14.311914945516385),

        baseDescription: "Murales epico di Maradona, dipinto da Jorit Agoch, celebra la leggenda del calcio.",

        unlockedDescription: "L'opera cattura l'essenza dell'icona del calcio, immortalando la sua passione inconfondibile, la sua genialità sul campo e la sua indomabile personalità. Ogni dettaglio iperrealistico riflette l'immensa energia e il carisma che hanno reso Maradona un simbolo universale. Questo murales rappresenta un punto di riferimento per i tifosi, che possono ricordare e celebrare l'eredità duratura di uno dei più grandi giocatori di tutti i tempi.",

        imageName:

            "muralesjorit",

        isUnlocked: false,
        
        isStory: 1


    )
    ,
    Location (

        name: "Murales di Maradona",

        cityName: "La Bodega De D10S, Via Emanuele de Deo, Napoli, NA, Italia",

        coordinates: CLLocationCoordinate2D(latitude: 40.841522595566154,longitude: 14.24509595245206),

        baseDescription: "Il suggestivo murales di Maradona nei Quartieri Spagnoli celebra il carismatico calciatore argentino, raffigurando la sua passione e il suo impatto indelebile.",

        unlockedDescription: "Il meraviglioso murales di Maradona, realizzato da un'artista di strada sconosciuto, è un tributo vivido al grande calciatore argentino. L'opera trasmette la sua energia e il suo carisma, con pennellate dinamiche che catturano la sua maestria nel calcio e la sua personalità affascinante. Il murales, situato nei Quartieri Spagnoli, è diventato un'icona del quartiere e un punto di riferimento per i fan di Maradona di tutto il mondo.",

        imageName:

            "muralessangiovanni",

        isUnlocked: false,
        
        isStory: 1


    )
    ,

        Location (

            name: "Tomba di Dracula",

            cityName: "Via Santa Maria la Nova, 44, 80134 Napoli NA",

            coordinates: CLLocationCoordinate2D(latitude: 40.84396542409338, longitude: 14.25292970166779),

            baseDescription: "l sepolcro di Matteo Ferrillo è un monumento funebre custodito all'interno del chiostro minore del convento di Santa Maria la Nova, presso l'omonima chiesa di Napoli. Secondo alcune teorie, il sepolcro potrebbe essere la tomba di Dracula.",

            unlockedDescription: "Nel 2014 alcuni studiosi italiani, supportati da pareri di esperti dell'università di Tallinn, suppongono che la tomba possa ospitare i resti di Vlad III di Valacchia, meglio conosciuto come Dracula: la loro ipotesi si basa sulle decorazioni presenti nello scomparto centrale, in particolar modo su un drago e su alcuni simboli di matrice egizia, mai visti su una tomba europea, come due sfingi contrapposte, emblema della città di Tebe, dagli egizi chiamata Tepe, che andrebbero ad alludere al vero nome del conte Vlad, ossia Dracula Tepes. Gli studiosi suppongono che il conte non sarebbe morto in battaglia, ma sarebbe stato fatto prigioniero dai Turchi e in seguito riscattato dalla propria figlia, Maria Balsa, nel frattempo adottata da una famiglia di Napoli, città dove si sarebbe rifugiata, per ordine del padre, per salvarsi dalla persecuzione turca. Maria Balsa avrebbe quindi portato in Italia il padre Vlad, e, alla morte di quest'ultimo, lo avrebbe fatto tumulare nella tomba del suocero, Matteo Ferrillo.",

            imageName:

                "tombadracula",

            isUnlocked: false,
            
            isStory: 2


        ),
        Location (

            name: "Facciata chiesa del Gesù Nuovo",

            cityName: " Piazza del Gesù Nuovo, 2, 80134 Napoli NA",

            coordinates: CLLocationCoordinate2D(latitude: 40.84750342214589, longitude: 14.252013957545497),

            baseDescription: "La chiesa del Gesù Nuovo è caratterizzata dalle tipiche bugne scolpite a punta di diamante su tutta l'intera superficie e l'unico esempio di bugnato a Napoli.La Chiesa attraverso più di un secolo di lavori è diventata, per le peculiarità della sua struttura e le leggende attorno ad essa un luogo da visitare assolutamente durante una gita a Napoli.",

            unlockedDescription: "l suo magnifico bugnato, che anni fa finì anche sul retro delle diecimila lire, riportava dei segni, delle scritte sulle bugne sul cui significato per secoli c’è stato un alone di mistero. C’era chi parlava di occulto, chi di alchimia e chi dei segreti che i maestri pipernai si trasmettevano oralmente. Altri sostenevano che le scritte sarebbero servite a convogliare le energie positive dall’esterno all’interno dell’edificio alimentando le tante leggende sorte attorno al palazzo. Altri invece sostenevano che fossero solo i simboli delle diverse cave di piperno dalle quali provenivano le pietre.",

            imageName:

                "facciata",

            isUnlocked: false,
            
            isStory: 2


        ),
        Location (

            name: "Guglia dell'Immacolata",

            cityName: "Piazza Gesù Nuovo, 80134 Napoli NA",

            coordinates: CLLocationCoordinate2D(latitude: 40.847067415779904, longitude: 14.251685181026678),

            baseDescription: "L’obelisco di Piazza del Gesù è situato in piazza del Gesù Nuovo, di fronte alla chiesa omonima. Sulla statua, che rappresenta la Madonna, viene posata una corona di rose; ma l’obelisco nasconde un mistero, e per questo viene chiamato anche 'l’Obelisco della Morte'.",

            unlockedDescription: "Su quest’opera aleggia un’inquietante leggenda. Si dice che in alcune ore del giorno, specialmente con la luce del tramonto o dell’alba, l’aspetto della statua della Madonna cambi. Se si fissa attentamente di spalle, dopo qualche giro intorno alla guglia, si ha l’impressione di essere minacciosamente osservati. Bisogna allontanarsi un bel pò per non sentire più questa spiacevole sensazione. Il velo che avvolge il capo della Vergine, visto da dietro, appare, infatti, come un volto stilizzato con lo sguardo fisso verso il basso e, secondo la leggenda raffigurerebbe la Morte in persona con tanto di gobba e scettro in mano.",

            imageName:

                "obelisco",

            isUnlocked: false,
            
            isStory: 2


        ),

        

        ]

}
