//
//  CalculatorButtonItem.swift
//  Calculator
//
//  Created by ray on 2020/5/24.
//  Copyright © 2020 ray. All rights reserved.
//

import CoreGraphics
import Foundation
import UIKit

enum CalculatorButtonItem {
    enum Op: String {
        case plus = "+"
        case minus = "-"
        case divide = "➗"
        case multiply = "✖️"
        case equal = "="
    }

    enum Command: String {
        case clear = "AC"
        case flip = "+/-"
        case percent = "%"
    }

    case digit(Int)
    case dot
    case op(Op)
    case command(Command)
}

extension CalculatorButtonItem {
    var title: String {
        switch self {
        case .digit(let value): return String(value)
        case .dot: return "."
        case .op(let op): return op.rawValue
        case .command(let command): return command.rawValue
        }
    }

    var size: CGSize {
        let scale: CGFloat = UIScreen.main.bounds.width / 414

        if case .digit(let value) = self, value == 0 {
            return CGSize(width: 88 * 2 * scale + 8, height: 88 * scale)
        }
        
        return CGSize(width: 88 * scale, height: 88 * scale)
    }

    var backgroundColorName: String {
        switch self {
        case .digit, .dot: return "digitBackground"
        case .op: return "operatorBackground"
        case .command: return "commandBackground"
        }
    }
}

extension CalculatorButtonItem: Hashable, CustomStringConvertible {
    var description: String {
        return title
    }
}
