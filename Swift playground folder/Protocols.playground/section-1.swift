

import Foundation

@objc protocol Speaker
{
    func Speak()
    optional func TellJoke()
}

class Sterling: Speaker
{
    func Speak()
    {
        println("Danger Zone!")
    }
    func TellJoke() {
        println("It's like Meowshwitz in there")
    }
}

class Lana: Speaker
{
    func Speak()
    {
        println("Watch It!")
    }
}

class Pam: Speaker
{
    func Speak()
    {
        println("Bear Claws!")
    }
}

class Animal
{
    
}

class Dog: Animal, Speaker
{
    func Speak()
    {
        println("Boof")
    }
}

//var speaker:Speaker
//speaker = Sterling()
//speaker.Speak()
//speaker.TellJoke!()
//(speaker as Sterling).TellJoke()
//speaker = Lana()
//speaker.Speak()
//speaker.TellJoke?()
//speaker = Dog()
//speaker.Speak()

class DateSimulator
{
    let a:Speaker
    let b:Speaker
    
    init(a:Speaker, b:Speaker)
    {
        self.a = a
        self.b = b
    }
    
    func simulate()
    {
        println("Off to dinner...")
        a.Speak()
        b.Speak()
        println("Walking back home")
        a.TellJoke?()
        b.TellJoke?()
        
    }
}

let sim = DateSimulator(a: Lana(), b:Sterling())
sim.simulate()











