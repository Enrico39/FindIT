//
//  IntroView.swift
//  Tutorial
//
//  Created by Francesco on 22/06/23.
//

import SwiftUI

struct IntroView: View {
    //MARK: Animazione
    @State var showWalkThroughScreens: Bool = false
    @State var currentIndex: Int = 0
    @State var showLoginPage: Bool = false
    @State var showHomeView: Bool = false
    
    var body: some View {
        ZStack{
            if showHomeView{
                NamePage()
                .transition(.move(edge: .trailing))
            }
            else{
                ZStack{
                    Color(.white)
                        .ignoresSafeArea()
                    
                    IntroScreen()
                    
                    WalkThroughScreens()
                        
                    NavBar()
                }
                .animation(.interactiveSpring(response: 1.1, dampingFraction: 0.8, blendDuration: 0.85), value: showWalkThroughScreens)
                .transition(.move(edge: .leading))
            }
        }
        .animation(.easeOut(duration: 0.4), value: showHomeView)
    }
    //MARK: WalkThrough Screens
    @ViewBuilder
    func WalkThroughScreens()->some View{
        let isLast = currentIndex == intros.count
        GeometryReader{
            let size = $0.size
            
            ZStack{
                ForEach(intros.indices, id: \.self){index in
                    ScreenView(size: size, index: index)
                }
                WelcomeView(size: size, index: intros.count)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            //MARK: Next Button
            .overlay(alignment: .bottom){
                ZStack{
                    Image(systemName: "chevron.right")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .scaleEffect(!isLast ? 1: 0.001)
                        .opacity(!isLast ? 1 : 0)
                    
                    HStack{
                        Text("Let's start...")
                            .font(.custom("Arial", size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity,alignment: .leading)
                        Image(systemName: "arrow.right")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 15)
                    .scaleEffect(isLast ? 1: 0.0001)
                    .frame(height: isLast ? nil : 0)
                    .opacity(isLast ? 1 : 0)
                }
                .frame(width:isLast ? size.width/1.5 : 55, height: isLast ? 50 : 55)
                .foregroundColor(.white)
                .background{
                    RoundedRectangle(cornerRadius: isLast ? 10 : 30, style: isLast ? .continuous : .circular)
                        .fill(.blue)
                }
                .onTapGesture{
                    if currentIndex == intros.count{
                        showHomeView = true;
                        showLoginPage = true
                    }
                    else{
                        currentIndex+=1;
                    }
                }
                .overlay(
                    Group {
                        if showLoginPage {
                            NamePage()
                                .transition(.move(edge: .bottom))
                        }
                    }
                )
                .offset(y: isLast ? -40 : -90)
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5), value: isLast)
                .padding(.bottom, 25)
            }
            .overlay(alignment: .bottom, content: {
                let isLast = currentIndex == intros.count

                HStack{
                    Text("Explore with FindIT!")
                        .font(.custom("Arial", size: 20))
                        .foregroundColor(Color(.black))
                        .padding(.bottom, 10)
                }
                .offset(y: isLast ? -12 : 100)
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5), value: isLast)
            })
            .offset(y: showWalkThroughScreens ? 0 : size.height)
        }
    }
    
    @ViewBuilder
    func ScreenView(size: CGSize, index: Int)->some View{
        let intro = intros[index]
        
        VStack(spacing: 10){
            Text(intro.title)
                .font(.custom("Arial", size: 35))
                .fontWeight(.bold)
                .offset(x: -size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(currentIndex == index ? 0.2 : 0).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
                .padding(.top, -100)
            
            Text(intro.text)
                .font(.custom("Arial", size: 20))
                .multilineTextAlignment(.center)
                .padding(.horizontal,30)
                .offset(x: -size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(0.1).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
                .padding(.top, -40)
            
            Image(intro.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 250, alignment: .top)
                .padding(.horizontal,20)
//                .padding(.top, 20)
                .offset(x: -size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(currentIndex == index ? 0 : 0.2).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
        }
    }
    
    @ViewBuilder
    func WelcomeView(size: CGSize, index: Int)->some View{
        VStack(spacing: 10){
            
            Image("patrick")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 250, alignment: .top)
                .padding(.horizontal,20)
                .offset(x: -size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(currentIndex == index ? 0 : 0.2).delay(currentIndex == index ? 0.1 : 0), value: currentIndex)
            
            Text("Start Explore!")
                .font(.custom("Arial", size: 40))
                .fontWeight(.bold)
                .offset(x: -size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(0.1).delay(currentIndex == index ? 0.1 : 0), value: currentIndex)
            
            Text(finalText)
                .font(.custom("Arial", size: 20))
                .multilineTextAlignment(.center)
                .padding(.horizontal,30)
                .offset(x: -size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(currentIndex == index ? 0.2 : 0).delay(currentIndex == index ? 0.1 : 0), value: currentIndex)
        }
        .offset(y: -30)
        .offset(y: -30)
    }
    
    //MARK: Navbar
    @ViewBuilder
    func NavBar()->some View{
        let isLast = currentIndex == intros.count
        HStack{
            Button{
                if currentIndex > 0 {
                    currentIndex-=1
                }else{
                    showWalkThroughScreens.toggle()
                }
                
            } label:{
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(.black))
            }
            Spacer()
            Button("Skip"){
                currentIndex = intros.count
            }
            .font(.custom("Arial", size: 20))
            .foregroundColor(Color(.black))
            .opacity(isLast ? 0 : 1)
            .animation(.easeOut, value: isLast)
        }
        .padding(.horizontal, 15)
        .padding(.top, 10)
        .frame(maxHeight: .infinity, alignment: .top)
        .offset(y: showWalkThroughScreens ? 0: -120)
    }
    
    @ViewBuilder
    func IntroScreen()->some View{
        GeometryReader{
            let size = $0.size
            VStack(spacing: 10){
                Image("patrick")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width / 1.5, height: size.height / 2.5)
                Text("Welcome on FindIt")
                    .font(.custom("Arial", size: 40))
                    .fontWeight(.bold)
                    .padding(.top, 55)
                    .foregroundColor(Color.black)
                Text(dummyText)
                    .font(.custom("Arial", size: 20))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                    .foregroundColor(Color.black)
                Text("Start Tutorial")
                    .font(.custom("Arial", size: 25))
                    .bold()
                    .font(.title)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 15)
                    .foregroundColor(.white)
                    .background{
                        Capsule()
                            .fill(.blue)
                    }
                    .onTapGesture {
                        showWalkThroughScreens.toggle()
                    }
                    .padding(.top, 30)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .offset(y: showWalkThroughScreens ? -size.height : 0)
            .padding(.top, 100)
        }
        .ignoresSafeArea()
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
