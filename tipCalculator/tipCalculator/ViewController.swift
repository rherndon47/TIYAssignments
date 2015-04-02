//
//  ViewController.swift
//  tipCalculator
//
//  Created by Richard Herndon on 4/1/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet var totalTextField : UITextField!    // ! point means that these are optional
    @IBOutlet var taxPercentSlider : UISlider!
    @IBOutlet var taxPercentLabel : UILabel!
    @IBOutlet var resultsTextView : UITextView!
    
    let tipCalc = TipCalculatorModel(total: 42.75, taxPercent: 0.06)

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func calculateTapped(sender : AnyObject)
    {
        tipCalc.total = Double((totalTextField.text as NSString).doubleValue)
        let possibleTips = tipCalc.returnPossibleTips()
        var results = ""
        
        var keys = Array(possibleTips.keys)
        sort(&keys)
        for tipPercent in keys
        {
            let tipValue = possibleTips[tipPercent]!    // ! is for an optional value
            let prettyTipValue = String(format: "%.2f", tipValue)
            results += "\(tipPercent)% : $\(prettyTipValue)\n"
        }
        
        resultsTextView.text = results
    }
    
    @IBAction func taxPercentageChanged(sender : AnyObject)
    {
        tipCalc.taxPercent = Double(taxPercentSlider.value) / 100
        refreshUI()
    }
    
    @IBAction func viewTapped(sender : AnyObject)
    {
        totalTextField.resignFirstResponder()
    }
    
    func refreshUI()
    {
        totalTextField.text = String(format: "%0.2f", tipCalc.total)
        taxPercentSlider.value = Float(tipCalc.taxPercent) * 100
        taxPercentLabel.text = "Tax Percentage (\(Int(taxPercentSlider.value))%)"
        resultsTextView.text = ""
    }
}

