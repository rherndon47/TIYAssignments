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
        //        subTotal = total / (taxPercent + 1)
    }
    
    func calcTipWithTipPercent(tipPercent:Double) -> (tipAmount: Double, total: Double)
    {
        let tipAmount = subTotal * tipPercent
        let finalTotal = total * tipAmount
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
        var rValue = Dictionary<Int, (tipAmount:Double, total:Double)>() //initing an empty var
        for possibleTip in possibleTips
        {
            let integerPercent = Int(possibleTip*100)
            rValue[integerPercent] = calcTipWithTipPercent(possibleTip)
        }
        return rValue
    }
}

import UIKit

class TestDataSource:   NSObject, UITableViewDataSource
{
    let tipCalc = TipCalculatorModel(total:42.75, taxPercent: 0.06)
    var possibleTips = Dictionary<Int, (TipAmount:Double, total:Double)>()
    var sortedKerys:[Int] = []
    
    override init()
    {
        possibleTips = tipCalc.returnPossibleTips()
        sortedKerys = sorted(Array(possibleTips.keys))
        super.init()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return sortedKeys.count
    }
    
    func func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style:UITableViewCellStyle.Value2, reuseIdentifier: nil)
        let tipPercent = sortedKeys[indexPath.row]
        let tipAmount = possibleTips[tipPercent]!.tipAmount
    }
    
   
}






