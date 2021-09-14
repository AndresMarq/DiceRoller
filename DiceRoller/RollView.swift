//
//  RollView.swift
//  DiceRoller
//
//  Created by Andres Marquez on 2021-09-06.
//

import SwiftUI
import CoreHaptics

struct RollView: View {
    @State private var amountOfDice = 4
    @State private var dieMaxNumber = 6.0
    
    @Environment(\.managedObjectContext) var moc
    
    //Number rolled on each die, max number of dice: 4
    @State private var numberRolledFirst = 1
    @State private var numberRolledSecond: Int? = nil
    @State private var numberRolledThird: Int? = nil
    @State private var numberRolledFourth: Int? = nil
    
    @State private var engine: CHHapticEngine?
    
    
    var body: some View {
        NavigationView {
            VStack {
                Stepper(value: $amountOfDice, in: 1 ... 4 , step: 1) {
                    diceStepperIcons(numberOfIcons: amountOfDice)
                        .font(.title)
                        .padding()
                }
                
                Slider(value: $dieMaxNumber, in: 6 ... 100, step: 1)
                
                Text("\(dieMaxNumber, specifier: "%.f")-sided die")
                    .bold()
                    .foregroundColor(.secondary)
                    .padding(.bottom)
                
                Spacer()
                
                showDice(numberofDice: amountOfDice)
                
                Spacer()
                
                Button(action: {
                    rollAction()
                }, label: {
                    Text("Roll")
                        .font(.title)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .padding()
                })
            }
            .navigationBarTitle("DiceRoller")
            .onAppear(perform: prepareHaptics)
        }
    }
    
    func rollAction() {
        let timers = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1, 1.1, 1.2, 1.3, 1.4, 1.5, 1.75, 2, 2.25]
        
        for time in timers {
            DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                fakeRoll(numberofDice: amountOfDice)
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            rollDice(numberofDice: amountOfDice)
            rollHaptics()
        }
    }
    
    func rollDice(numberofDice: Int) {
        let maxInt = Int(dieMaxNumber)
        
        func rollFirstDie() {
            self.numberRolledFirst = Int.random(in: 1...maxInt)
            self.saveRoll(numberRolled: Int16(numberRolledFirst))
        }
        func rollSecondDie() {
            self.numberRolledSecond = Int.random(in: 1...maxInt)
            self.saveRoll(numberRolled: Int16(numberRolledSecond ?? 0))
        }
        func rollThirdDie() {
            self.numberRolledThird = Int.random(in: 1...maxInt)
            self.saveRoll(numberRolled: Int16(numberRolledThird ?? 0))
        }
        func rollFourthDie() {
            self.numberRolledFourth = Int.random(in: 1...maxInt)
            self.saveRoll(numberRolled: Int16(numberRolledFourth ?? 0))
        }
        
        switch numberofDice {
        case 1:
            rollFirstDie()
        case 2:
            rollFirstDie()
            rollSecondDie()
        case 3:
            rollFirstDie()
            rollSecondDie()
            rollThirdDie()
        default:
            rollFirstDie()
            rollSecondDie()
            rollThirdDie()
            rollFourthDie()
        }
    }
    
    func fakeRoll(numberofDice: Int) {
        let maxInt = Int(dieMaxNumber)
        
        switch numberofDice {
        case 1:
            self.numberRolledFirst = Int.random(in: 1...maxInt)
        case 2:
            self.numberRolledFirst = Int.random(in: 1...maxInt)
            self.numberRolledSecond = Int.random(in: 1...maxInt)
        case 3:
            self.numberRolledFirst = Int.random(in: 1...maxInt)
            self.numberRolledSecond = Int.random(in: 1...maxInt)
            self.numberRolledThird = Int.random(in: 1...maxInt)
        default:
            self.numberRolledFirst = Int.random(in: 1...maxInt)
            self.numberRolledSecond = Int.random(in: 1...maxInt)
            self.numberRolledThird = Int.random(in: 1...maxInt)
            self.numberRolledFourth = Int.random(in: 1...maxInt)
        }
    }
    
    func saveRoll(numberRolled: Int16) {
        let newRoll = HistoricalRolls(context: moc)
        newRoll.roll = numberRolled
        newRoll.date = Date()
        PersistenceController.shared.save()
    }
    
    func diceStepperIcons(numberOfIcons: Int) -> some View {
        HStack {
            switch numberOfIcons {
            case 1:
                Image(systemName: "die.face.1.fill")
            case 2:
                Image(systemName: "die.face.1.fill")
                Image(systemName: "die.face.1.fill")
            case 3:
                Image(systemName: "die.face.1.fill")
                Image(systemName: "die.face.1.fill")
                Image(systemName: "die.face.1.fill")
            default:
                Image(systemName: "die.face.1.fill")
                Image(systemName: "die.face.1.fill")
                Image(systemName: "die.face.1.fill")
                Image(systemName: "die.face.1.fill")
            }
        }
    }
    
    @ViewBuilder
    func showDice(numberofDice: Int) -> some View {
        switch numberofDice {
        case 1:
            SingleDieView(numberRolledFirst: numberRolledFirst)
        case 2:
            TwoDiceView(numberRolledFirst: numberRolledFirst, numberRolledSecond: numberRolledSecond ?? 1)
        case 3:
            ThreeDiceView(numberRolledFirst: numberRolledFirst, numberRolledSecond: numberRolledSecond ?? 1, numberRolledThird: numberRolledThird ?? 1)
        default:
            FourDiceView(numberRolledFirst: numberRolledFirst, numberRolledSecond: numberRolledSecond ?? 1, numberRolledThird: numberRolledThird ?? 1, numberRolledFourth: numberRolledFourth ?? 1)
        }
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

        do {
            self.engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    func rollHaptics() {
        // device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()

        // create event
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 5)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 10)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)

        // convert events into a pattern and play it immediately
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
}

struct RollView_Previews: PreviewProvider {
    static var previews: some View {
        RollView()
    }
}
