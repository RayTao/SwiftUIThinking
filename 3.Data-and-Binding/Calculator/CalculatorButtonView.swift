//
//  CalculatorButtonView.swift
//  Calculator
//
//  Created by ray on 2020/5/25.
//  Copyright © 2020 ray. All rights reserved.
//

import Foundation
import SwiftUI

struct CalculatorButtonPad: View {
//    @Binding var brain: CalculatorBrain
//    var model: CalculatorModel
    let pad: [[CalculatorButtonItem]] = [
        [
            .command(.clear), .command(.flip),
            .command(.percent), .op(.divide)
        ],
        [
            .digit(7), .digit(8),
            .digit(9), .op(.multiply)
        ],
        [
            .digit(4), .digit(5),
            .digit(6), .op(.minus)
        ],
        [
            .digit(1), .digit(2),
            .digit(3), .op(.plus)
        ],
        [
            .digit(0), .dot,
            .op(.equal)
        ]
    ]
    var body: some View {
        VStack(spacing: 8) {
            ForEach(pad, id: \.self) { row in
//                CalculatorButtonRow(brain: self.$brain, row: row)
//                CalculatorButtonRow(model: self.model, row: row)
                CalculatorButtonRow(row: row)
            }
        }
    }
}

struct CalculatorButtonRow: View {
//    @Binding var brain: CalculatorBrain
//    var model: CalculatorModel
    @EnvironmentObject var model: CalculatorModel
    let row: [CalculatorButtonItem]
    var body: some View {
        HStack() {
            ForEach(row, id: \.self) { item in
                CalculatorButton(title: item.title, size: item.size, backgroundColorName: item.backgroundColorName)
                {
                    print("Button: \(item.title)")
                    self.model.apply(item)
                }
            }
        }
    }
}

struct CalculatorButton: View {
    let fontSize: CGFloat = 38
    let title: String
    let size: CGSize
    let backgroundColorName: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(.white)
                .font(.system(size: fontSize))
                .frame(width: size.width, height: size.height, alignment: .center)
                .background(Color(backgroundColorName))
                .cornerRadius(size.height / 2)
        }
    }
}
