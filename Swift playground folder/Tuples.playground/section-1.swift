//(404, "Not Found!") // Tuple

let tipAndTotal = (4.00, 25.19)
tipAndTotal.0
tipAndTotal.1

let (theTipAmount, theTotal) = tipAndTotal
theTipAmount
theTotal

let tipAndTotalNamed = (tipAmount: 4.00, total: 25.19)
tipAndTotalNamed.tipAmount
tipAndTotalNamed.total

let total = 21.19
let taxPercent = 0.06
let subtotal = total / (taxPercent + 1)
//func calcTipWithTipPercent(tipPercent:Double) -> (tipAmount: Double, total: Double)
//{
//    let tipAmount = subtotal * tipPercent
//    let finalTotal = total * tipAmount
//    return (tipAmount, finalTotal)
//}
//
//calcTipWithTipPercent(0.20)

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
        let tipAmount = subtotal * tipPercent
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


let tipCalc = TipCalculatorModel(total: 33.25, taxPercent: 0.06)
tipCalc.returnPossibleTips()
































