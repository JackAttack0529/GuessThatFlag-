//
//  ContentView.swift
//  GuessThatFlag
//
//  Created by Jack Hyde on 4/17/23.
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
    
    // State variables used to keep track of user's score, display user's score, and determine if the alert is displayed
    @State var currentScore = 0
    @State var scoreTitle = ""
    @State var showingAlert = false
    
    // Function that shuffles/randomizes the order of the flags in the countries. Also, creates a new flag to guess.
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    // Function that accepts an argument for the "num" parameter. Argument is based off of user's guess (See ForEach loop below). Also, function determines if user's guess is correct or wrong and adjusts user's score accordingly.
    func flagTapped(num: Int){
        if num == correctAnswer {
            scoreTitle = "Correct"
            currentScore += 1
        } else {
            scoreTitle = "Wrong"
            
            if currentScore > 0 {
                currentScore -= 1
            }
        }
        
        // Causes the alert to display
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
                            
                            // Displays a flag using a String/name from the "countries" array
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

                // Displays the current score to the user
                Text("Score: " + String(currentScore))
                    .foregroundColor(.white)
                    .font(.title.bold())

                Spacer()
            }
            .padding()
        }
        // Alert letting the user know if their guess was correct. Also, letting the user know their current score
        // The value of the "showingAlert" state variable determines if the alert is displayed (True for yes and False for no)
        // NOTE: When the "Continue" button is clicked the alert is dismissed (AKA The value of showingAlert is changed to false)
        .alert(scoreTitle, isPresented: $showingAlert) {
            
            // The "askQuestion" function runs when the "Continue" button on the alert is clicked
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is " + String(currentScore))
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
