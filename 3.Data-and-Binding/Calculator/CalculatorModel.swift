//
//  CalculatorModel.swift
//  Calculator
//
//  Created by ray on 2020/5/30.
//  Copyright © 2020 ray. All rights reserved.
//

import Combine
import Foundation

class CalculatorModel: ObservableObject {
//    let objectWillChange = PassthroughSubject<Void, Never>()
//    var brain: CalculatorBrain = .left("0") {
//        willSet { objectWillChange.send() }
//    }
    @Published var brain: CalculatorBrain = .left("0")
    @Published var history: [CalculatorButtonItem] = []
    var temporaryKept: [CalculatorButtonItem] = []

    var historyDetail: String {
        history.map { $0.description }.joined()
    }

    var totalCount: Int {
        history.count + temporaryKept.count
    }

    var slidingIndex: Float = 0 {
        didSet {
            // 维护 history 和 temporaryKept
            keepHistory(upTo: Int(slidingIndex))
        }
    }

    @inline(__always) func keepHistory(upTo index:Int) {
        precondition(index <= totalCount, "Out of index")
        
        let total = history + temporaryKept
        
        history = Array(total[..<index])
        temporaryKept = Array(total[index...])
        
        brain = history.reduce(CalculatorBrain.left("0")) {
            result, item in
            result.apply(item: item)
        }
    }
    
    func apply(_ item: CalculatorButtonItem) {
        brain = brain.apply(item: item)
        history.append(item)
        
        temporaryKept.removeAll()
        slidingIndex = Float(totalCount)
    }
}
