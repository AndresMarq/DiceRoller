//
//  DieView.swift
//  DiceRoller
//
//  Created by Andres Marquez on 2021-09-11.
//

import SwiftUI

struct dieView: View {
    var number: Int
    var size: CGFloat
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Text("\(number)")
            .font(.system(size: 75))
            .frame(width: size, height: size, alignment: .center)
            .border(colorScheme == .dark ? Color.white : Color.black, width: 7)
            .padding()
    }
}
