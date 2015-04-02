class TipCalculator
{
    let total: Double
    let taxPercent: Double
    let subTotal: Double
    
    init(total: Double, taxPercent: Double)
    {
        self.total = total
        self.taxPercent = taxPercent
        subTotal = total / (taxPercent + 1)
    }
    
    func calcTipWithPercent(tipPercent: Double) -> Double   // function declare
    {
        return subTotal * tipPercent
    }
    
    func printPossibleTips()
    {
        println("15%: \(calcTipWithPercent(0.15))")
        println("18%: \(calcTipWithPercent(0.18))")
        println("20%: \(calcTipWithPercent(0.20))")
    }
    
    func returnPossibleTips() -> [Int: Double]
    {
        let possibleTips = [0.15, 0.18, 0.20]               // creates an array initialized with values
                                                            // arrays must be of all one type
        var rValue = [Int: Double]()                        // initializing bran new empty variable
        for possibleTips in possibleTips                    // for loop number of times there is members of array
        {
            let integerPercent = Int(possibleTips*100)        // store percent as integer
            rValue[integerPercent] = calcTipWithPercent(possibleTips)
        }
        return rValue
        
    }
}

let tipCalc = TipCalculator(total: 33.25, taxPercent: 0.06)
//tipCalc.printPossibleTips()
tipCalc.returnPossibleTips()



