//
//  ContentView.swift
//  Calculator
//
//  Created by ray on 2020/5/24.
//  Copyright © 2020 ray. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

struct ContentView: View {
    let scale: CGFloat = UIScreen.main.bounds.width / 414
//    @State private var brain: CalculatorBrain = .left("0")
    @ObservedObject var model = CalculatorModel()
    @State private var editingHistory = false
    
    var body: some View {
        VStack(spacing: 12) {
//            Spacer()
            Text("")
                .frame(maxHeight: .infinity)
            Button("操作履历： \(model.history.count)") {
                self.editingHistory = true
            }.sheet(isPresented: $editingHistory) {
                HistoryView(model: self.model)
            }
            Text(model.brain.output)
                .font(.system(size: 76))
                .foregroundColor(.black)
                .minimumScaleFactor(0.5)
                .padding(.trailing, 24 * scale)
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    alignment: .trailing)
            CalculatorButtonPad(model: self.model)
                .padding(.bottom)
        }
//        .scaleEffect(scale) // 简单除暴适配不同屏幕
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
//            ContentView().previewDevice("iPad Air 2")
            ContentView().previewDevice("iPhone XR")
            ContentView().environment(\.colorScheme, .dark).previewDevice("iPhone 6s")
        }
    }
}
