//
//  TwoDiceView.swift
//  DiceRoller
//
//  Created by Andres Marquez on 2021-09-10.
//

import SwiftUI

struct TwoDiceView: View {
    var numberRolledFirst: Int
    var numberRolledSecond: Int
    
    var body: some View {
        HStack {
            dieView(number: numberRolledFirst, size: 125)
            
            dieView(number: numberRolledSecond, size: 125)
        }
    }
}

struct TwoDiceView_Previews: PreviewProvider {
    static var previews: some View {
        TwoDiceView(numberRolledFirst: 1, numberRolledSecond: 20)
    }
}
