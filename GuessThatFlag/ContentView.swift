//
//  ContentView.swift
//  GuessThatFlag
//
//  Created by Matthew RIley on 4/17/23.
//

import SwiftUI

struct ContentView: View {
    
    // State Array variable containing the image names (NOTE: Creating as a State variable so the order can be shuffled/randomized)
    @State var countries = [
        "Estonia",
        "France",
        "Germany",
        "Ireland",
        "Italy",
        "Nigeria",
        "Poland",
        "Russia",
        "Spain",
        "UK",
        "US"
    ]
    
    // Creates a random number that is used to determine which flag name to display and which is the correct flag to select
    @State var correctAnswer = Int.random(in: 0...2)
    
    //
    @State var scoreTitle = ""
    @State var currentScore = 0
    @State var showingAlert = false
    
    // Function that shuffles/randomizes the order of the flags in the countries. Also, creates a new flag to guess.
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    //
    func flagTapped(num: Int){
        if num == correctAnswer {
            scoreTitle = "Correct"
        } else {
            scoreTitle = "Wrong"
        }
            
        showingAlert = true
    }

    var body: some View {
        ZStack {
            
            Color.blue.ignoresSafeArea()

            VStack {
                Spacer()

                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)

                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))

                        // Using the "correctAnswer" state variable to randomize the correct flag for each turn
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }

                    
                    // Loop that runs three times and creates a new Button element each time. Also, the value for "number" is 0 first time  through the loop, 1 second time, and 2 third time.
                    ForEach(0..<3) { number in
                        
                        Button {
                            flagTapped(num: number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }

                    }
                    
//                    Button {
//                        flagTapped(num: 0)
//                    } label: {
//                        Image(countries[0])
//                            .renderingMode(.original)
//                            .clipShape(Capsule())
//                            .shadow(radius: 5)
//                    }
//
//                    Button {
//                        flagTapped(num: 1)
//                    } label: {
//                        Image(countries[1])
//                            .renderingMode(.original)
//                            .clipShape(Capsule())
//                            .shadow(radius: 5)
//                    }
//
//                    Button {
//                        flagTapped(num: 2)
//                    } label: {
//                        Image(countries[2])
//                            .renderingMode(.original)
//                            .clipShape(Capsule())
//                            .shadow(radius: 5)
//                    }

                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))

                Spacer()

                Text("DISPLAY SCORE HERE")
                    .foregroundColor(.white)
                    .font(.title.bold())

                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingAlert) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("You Guessed")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
