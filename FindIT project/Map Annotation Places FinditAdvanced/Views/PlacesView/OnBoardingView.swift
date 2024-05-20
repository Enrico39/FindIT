
import SwiftUI


struct OnBoardingStep {
    let image: String
    let title: String
    let description: String
}

private let onBoardingSteps = [
    OnBoardingStep (image: "pagoda", title: "First see learning", description: "Forget about a for of paper all knowledge in one learning!"),
    
    OnBoardingStep (image: "pagoda", title: "Connect with everyone", description: "Always keep in touch with your tutor % friend let's get connected!"),
    OnBoardingStep (image: "pagoda", title: "Always fascinated learning", description: "Anywhere, any time. The time as at vour discretion so study whenever vou wants")
    
    
]

struct OnBoarding: View {
    
    @State private var currentStep = 0
    init(){
        UIScrollView.appearance().bounces = false
    }
    
    @State private var showNamePage = false // Aggiunta della variabile di stato

    var body: some View {
        
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    self.currentStep = onBoardingSteps.count - 1}){
                        Text("Skip")
                            .padding(16)
                            .foregroundColor(.gray)
                    }
            }
                TabView(selection: $currentStep){
                    
                    ForEach(0..<onBoardingSteps.count) { it in
                        VStack{
                            Image (onBoardingSteps[it].image)
                                .resizable ()
                                .frame (width: 250, height: 250)
                            Text (onBoardingSteps[it].title)
                                .font(.title)
                                .bold()
                            Text (onBoardingSteps[it].description)
                                .multilineTextAlignment(.center)
                                .padding (.horizontal, 32)
                        }
                        .tag(it)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            HStack {
                ForEach(0..<onBoardingSteps.count) { it in
                    if it == currentStep {
                        Rectangle()
                            .frame(width: 20, height: 20)
                            .cornerRadius(10)
                            .foregroundColor(.blue)
                    } else {
                        Circle()
                            .frame(width: 10, height: 10)
                    }
                }
            }
            .padding(.bottom, 24)
            
            Button(action: {
                if self.currentStep < onBoardingSteps.count - 1 {
                    self.currentStep += 1
                } else {
                    self.showNamePage = true
                }
            }) {
                Text(currentStep < onBoardingSteps.count - 1 ? "Next" : "Get Started")
                    .padding(16)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(16 )
                    .padding(.horizontal, 16)
                    .foregroundColor(.white)
            }
                .buttonStyle(PlainButtonStyle())
            }
        .sheet(isPresented: $showNamePage) {
            NamePage() // Chiamata alla funzione NamePage()
        }
        }
    }

    
    struct OnBoarding_Previews: PreviewProvider{
        static var previews: some View{
            OnBoarding()
        }
    }

