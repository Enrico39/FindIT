
import SwiftUI
import WatchConnectivity

struct AcquaFuoco: View {
    @State private var countClick = 0
    
    var body: some View {
        VStack {
            Text("FindIT")
            
            if countClick == 1 {
                FlameView()
                
            } else if countClick == 2 {
                FlameCompleteView()
            } else {
                DropView()
            }
        }
        .onAppear {
            startTimer()
        }
    }
    
    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in
            withAnimation(.spring(response: 1.5, dampingFraction: 1, blendDuration: 0)) {
                countClick = (countClick + 1) % 3
            }
        }
    }
}


struct DropView: View {
    @State private var rotation: Double = 360
    
    var body: some View {
        Image("waterball")
            .resizable() // Rendi l'immagine ridimensionabile
                        .aspectRatio(contentMode: .fit) // Imposta l'aspect ratio dell'immagine
            .foregroundColor(.blue)
            .padding()
            .rotationEffect(.degrees(rotation))
            .onAppear {
                animateRotation()
            }
        
        Text("Continua a cercare...")

    }
    
    private func animateRotation() {
        withAnimation(Animation.linear(duration: 5).repeatForever(autoreverses: false)) {
            rotation = 0
        }
    }
}

struct FlameView: View {
    @State private var rotation: Double = 360
    
    var body: some View {
        Image("bollafuoco")
            .resizable() // Rendi l'immagine ridimensionabile
                        .aspectRatio(contentMode: .fit) // Imposta l'aspect ratio dell'immagine
            .foregroundColor(.blue)
            .padding()
            .rotationEffect(.degrees(rotation))
            .onAppear {
                animateRotation()
            }
        
        Text("Ci sei quasi...")

    }
    
    private func animateRotation() {
        withAnimation(Animation.linear(duration: 5).repeatForever(autoreverses: false)) {
            rotation = 0
        }
    }
}




struct FlameCompleteView: View {
    @State private var rotation: Double = 360
    
    var body: some View {
        Image("bollafuocopiena")
            .resizable() // Rendi l'immagine ridimensionabile
                        .aspectRatio(contentMode: .fit) // Imposta l'aspect ratio dell'immagine
            .foregroundColor(.blue)
            .padding()
            .rotationEffect(.degrees(rotation))
            .onAppear {
                animateRotation()
            }
        
        Text("Luogo scovato")

    }
    
    private func animateRotation() {
        withAnimation(Animation.linear(duration: 5).repeatForever(autoreverses: false)) {
            rotation = 0
        }
    }
}


struct AcquaFuoco_Previews: PreviewProvider {
    static var previews: some View {
        AcquaFuoco()
    }
}




