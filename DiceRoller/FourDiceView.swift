//
//  FourDiceView.swift
//  DiceRoller
//
//  Created by Andres Marquez on 2021-09-10.
//

import SwiftUI

struct FourDiceView: View {
    var numberRolledFirst: Int
    var numberRolledSecond: Int
    var numberRolledThird: Int
    var numberRolledFourth: Int
    
    var body: some View {
        VStack {
            HStack {
                dieView(number: numberRolledFirst, size: 100)
                
                dieView(number: numberRolledSecond, size: 100)
            }
            
            HStack {
                dieView(number: numberRolledThird, size: 100)
                
                dieView(number: numberRolledFourth, size: 100)
            }
        }
    }
}

struct FourDiceView_Previews: PreviewProvider {
    static var previews: some View {
        FourDiceView(numberRolledFirst: 1, numberRolledSecond: 2, numberRolledThird: 3, numberRolledFourth: 4)
    }
}
