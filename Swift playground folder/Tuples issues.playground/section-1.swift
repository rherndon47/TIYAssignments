let tipAndTotal = (4.00, 25.19)   // a tuple
tipAndTotal.0
tipAndTotal.1     // decomposing a tuple

let (theTipAmount, theTotal) = tipAndTotal
theTipAmount
theTotal

let tipAndTotalName = (tipAmount: 4.00, total: 25.19) // combining 1 and 5

tipAndTotalName.tipAmount

let total = 21.19
let taxPercent = 0.06
let subtotal = total / (taxPercent + 1)
//func calcTipWithPercent(tipPercent:Double) -> (tipAmount: Double, Total:Double)
//{
//    let tipAmount = subtotal * tipPercent
//    let finalTotal = total + tipAmount
//    return (tipAmount, finalTotal)
//}
//calcTipWithPercent(0.20)

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
    
    func calcTipWithPercent(tipPercent:Double) -> (tipAmount: Double, Total:Double)
    {
        let tipAmount = subtotal * tipPercent
        let finalTotal = total + tipAmount
        return (tipAmount, finalTotal)
    }
    
    func printPossibleTips()
    {
        println("15%: \(calcTipWithPercent(0.15))")
        println("18%: \(calcTipWithPercent(0.18))")
        println("20%: \(calcTipWithPercent(0.20))")
    }
    
    func returnPossibleTips() -> [Int: (tipAmount:Double, total:Double)]
    {
        let possibleTips = [0.15, 0.18, 0.20]               // creates an array initialized with values
        // arrays must be of all one type
        var rValue = Dictionary<Int, (tipAmount:Double, total:Double)>()   // initializing bran new empty variable
        for possibleTips in possibleTips                    // for loop number of times there is members of array
        {
            let integerPercent = Int(possibleTips*100)        // store percent as integer
//            rValue[integerPercent] = calcTipWithPercent(possibleTips)
            rValue[integerPercent] = calcTipWithPercent(possibleTips)
        }
        return rValue
        
    }
}

let tipCalc = TipCalculatorModel(total: 33.25, taxPercent: 0.06)
tipCalc.returnPossibleTips()
