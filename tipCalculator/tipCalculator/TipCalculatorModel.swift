//
//  TipCalculatorModel.swift
//  tipCalculator
//
//  Created by Richard Herndon on 4/1/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//
//  updated to use tuple on 4/2/15.

import Foundation

class TipCalculatorModel
{
    var total: Double
    var taxPercent: Double
    var subTotal: Double
        {
        get
        {
            return total / (taxPercent + 1)
        }
    }
    
    init(total: Double, taxPercent: Double)
    {
        self.total = total
        self.taxPercent = taxPercent
    }
    
    func calcTipWithTipPercent(tipPercent: Double) -> (tipAmount:Double, total:Double)
    {
        let tipAmount = subTotal * tipPercent
        let finalTotal = total + tipAmount
        return (tipAmount, finalTotal)
    }
    
    func printPossibleTips()
    {
        println("15%: \(calcTipWithTipPercent(0.15))")
        println("18%: \(calcTipWithTipPercent(0.18))")
        println("20%: \(calcTipWithTipPercent(0.20))")
    }
    
    func returnPossibleTips() -> [Int: (tipAmount:Double, total:Double)]
    {
        let possibleTips = [0.15, 0.18, 0.20]
        var rValue = Dictionary<Int, (tipAmount:Double, total:Double)>()
        for possibleTip in possibleTips
        {
            let integerPercent = Int(possibleTip*100)
            rValue[integerPercent] = calcTipWithTipPercent(possibleTip)
        }
        return rValue
    }
}