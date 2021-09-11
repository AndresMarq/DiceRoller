//
//  RollView.swift
//  DiceRoller
//
//  Created by Andres Marquez on 2021-09-06.
//

import SwiftUI

struct RollView: View {
    @State private var amountOfDice = 1
    
    @Environment(\.managedObjectContext) var moc
    
    //Number rolled on each die, max number of dice: 4
    @State private var numberRolledFirst = 1
    @State private var numberRolledSecond: Int? = nil
    @State private var numberRolledThird: Int? = nil
    @State private var numberRolledFourth: Int? = nil
    
    
    var body: some View {
        NavigationView {
            VStack {
                Stepper(value: $amountOfDice, in: 1 ... 4 , step: 1) {
                    diceStepperIcons(numberOfIcons: amountOfDice)
                        .font(.title)
                }
                
                Spacer()
                
                SingleDieView(numberRolledFirst: numberRolledFirst)
                
                Spacer()
                Button(action: {
                    self.numberRolledFirst = Int.random(in: 1...6)
                    self.saveRoll(numberRolled: Int16(numberRolledFirst))
                }, label: {
                    Text("Roll")
                        .font(.title)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                })
            }
            .navigationBarTitle("Roll Dice")
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
    /*
    func showDice(numberofDice: Int) -> some View {
        switch numberofDice {
        case 1:
            return SingleDieView(numberRolledFirst: numberRolledFirst)
        case 2:
            return TwoDiceView(numberRolledFirst: numberRolledFirst, numberRolledSecond: numberRolledSecond ?? 1)
        case 3:
            return ThreeDiceView(numberRolledFirst: numberRolledFirst, numberRolledSecond: numberRolledSecond ?? 1, numberRolledThird: numberRolledThird ?? 1)
        default:
            return FourDiceView(numberRolledFirst: numberRolledFirst, numberRolledSecond: numberRolledSecond ?? 1, numberRolledThird: numberRolledThird ?? 1, numberRolledFourth: numberRolledFourth ?? 1)
        }
    }
 */
}

struct RollView_Previews: PreviewProvider {
    static var previews: some View {
        RollView()
    }
}
