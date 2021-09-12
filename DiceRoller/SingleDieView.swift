//
//  SingleDieView.swift
//  DiceRoller
//
//  Created by Andres Marquez on 2021-09-10.
//

import SwiftUI

struct SingleDieView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var numberRolledFirst: Int
    
    var body: some View {
        Text("\(numberRolledFirst)")
            .font(.system(size: 150))
            .frame(width: 200, height: 200, alignment: .center)
            .border(colorScheme == .dark ? Color.white : Color.black, width: 7)
            .padding()
    }
}


struct SingleDieView_Previews: PreviewProvider {
    static var previews: some View {
        SingleDieView(numberRolledFirst: 1)
    }
}
