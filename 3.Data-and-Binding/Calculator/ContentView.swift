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
//    @ObservedObject var model = CalculatorModel()
    @EnvironmentObject var model: CalculatorModel
    @State private var editingHistory = false
    @State private var tapNumber = false

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
                .onTapGesture {
                    self.tapNumber = true
            }.alert(isPresented: $tapNumber) {
                Alert(title: Text("\(model.historyDetail)"),
                      message: nil,
                      dismissButton: .cancel(Text("OK")))
            }
//            CalculatorButtonPad(model: self.model)
            CalculatorButtonPad()
                .padding(.bottom)
        }
//        .scaleEffect(scale) // 简单除暴适配不同屏幕
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
//            ContentView().previewDevice("iPad Air 2")
            ContentView().environmentObject(CalculatorModel()).previewDevice("iPhone XR")
//            ContentView().environmentObject(CalculatorModel()).environment(\.colorScheme, .dark).previewDevice("iPhone 6s")
        }
    }
}
