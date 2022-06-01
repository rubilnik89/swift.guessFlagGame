//
//  ContentView.swift
//  GuessFlagGame
//
//  Created by Roman Zherebko on 20.05.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var score = 0
    @State private var round = 8
    @State private var scoreText = ""
    @State private var showingAlert = false
    @State private var showingFinishedAlert = false
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State var selection: Int = 0
    @State private var animationAmount = 0.0
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: .black, location: 0.3),
                .init(color: .mint, location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
//            LinearGradient(gradient: Gradient(colors: [.mint, .black]), startPoint: .top, endPoint: .bottom)
//                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the flag")
                    .titleStyle()
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach (1..<4) { number in
                        let isSelected = self.selection == number
                        Button {
                            self.selection = number
                            withAnimation {
                                animationAmount += 360
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                flagTapped(number)
                            }
                        } label: {
                            FlagImage(imageName: countries[number])
                                
                        }
                        .opacity(self.selection == 0 || isSelected ? 1 : 0.25)
                        .rotation3DEffect(.degrees(self.animationAmount), axis: (x: isSelected ? 1 : 0, y: isSelected ? 0 : 1, z: 0))
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreText, isPresented: $showingAlert) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        .alert("Game finished!", isPresented: $showingFinishedAlert) {
            Button("Restart", action: restartGame)
        } message: {
            Text("Your score is \(score)!")
        }
    }
    
    func restartGame() {
        askQuestion()
        score = 0
        round = 8
        selection = 0
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreText = "Correct"
            score += 1
        } else {
            scoreText = """
                        Wrong!
                        That's the flag of \(countries[number])
                        """
            score -= 1
        }
        round -= 1
        if round == 0 {
            showingFinishedAlert = true
        } else {
            showingAlert = true
        }
    }
    
    func askQuestion() {
        countries = countries.shuffled()
        correctAnswer = Int.random(in: 0...2)
        selection = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
