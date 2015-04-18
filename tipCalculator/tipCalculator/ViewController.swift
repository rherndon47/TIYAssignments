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
    @IBOutlet var tableView : UITableView!
    
    let tipCalc = TipCalculatorModel(total: 42.75, taxPercent: 0.06)
    var possibleTips = Dictionary<Int, (tipAmount:Double, total:Double)>()
    var sortedKeys:[Int] = []

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
        sortedKeys = sorted(Array(possibleTips.keys))
        tableView.reloadData()
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
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return sortedKeys.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: UITableViewCellStyle.Value2, reuseIdentifier: nil)
        
        let tipPercent = sortedKeys[indexPath.row]
        let tipAmount = possibleTips[tipPercent]!.tipAmount
        let total = possibleTips[tipPercent]!.total
        
        cell.textLabel?.text = "\(tipPercent)%:"
        cell.detailTextLabel?.text = String(format: "Tip: $%0.2f, Total: $%0.2f", tipAmount, total)
        return cell
    }
    
    
}

