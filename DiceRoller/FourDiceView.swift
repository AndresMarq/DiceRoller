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
            
            HStack {
                Text("\(numberRolledThird)")
                    .font(.system(size: 150))
                    .frame(width: 150, height: 150, alignment: .center)
                    .border(Color.black, width: 7)
                    .padding()
                
                Text("\(numberRolledFourth)")
                    .font(.system(size: 150))
                    .frame(width: 150, height: 150, alignment: .center)
                    .border(Color.black, width: 7)
                    .padding()
            }
        }
    }
}

struct FourDiceView_Previews: PreviewProvider {
    static var previews: some View {
        FourDiceView(numberRolledFirst: 1, numberRolledSecond: 2, numberRolledThird: 3, numberRolledFourth: 4)
    }
}
