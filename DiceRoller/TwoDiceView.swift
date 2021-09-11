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
            Text("\(numberRolledFirst)")
                .font(.system(size: 150))
                .frame(width: 150, height: 150, alignment: .center)
                .border(Color.black, width: 7)
                .padding()
            
            Text("\(numberRolledSecond)")
                .font(.system(size: 150))
                .frame(width: 150, height: 150, alignment: .center)
                .border(Color.black, width: 7)
                .padding()
        }
    }
}

struct TwoDiceView_Previews: PreviewProvider {
    static var previews: some View {
        TwoDiceView(numberRolledFirst: 1, numberRolledSecond: 2)
    }
}
