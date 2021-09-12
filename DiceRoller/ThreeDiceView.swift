//
//  ThreeDiceView.swift
//  DiceRoller
//
//  Created by Andres Marquez on 2021-09-10.
//

import SwiftUI

struct ThreeDiceView: View {
    var numberRolledFirst: Int
    var numberRolledSecond: Int
    var numberRolledThird: Int
    
    var body: some View {
        VStack {
            HStack {
                dieView(number: numberRolledFirst, size: 100)
                
                dieView(number: numberRolledSecond, size: 100)
            }
            dieView(number: numberRolledThird, size: 100)
        }
    }
}

struct ThreeDiceView_Previews: PreviewProvider {
    static var previews: some View {
        ThreeDiceView(numberRolledFirst: 1, numberRolledSecond: 2, numberRolledThird: 3)
    }
}
