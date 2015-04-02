//
//  ViewController.swift
//  20 -- Mission Briefing Two
//
//  Created by Richard Herndon on 4/1/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate
{
    @IBOutlet var agentNameTextField : UITextField!    // ! point means that these are optional
    @IBOutlet var agenPasswordTextField : UITextField!
    @IBOutlet var greetingLabel : UILabel!
    @IBOutlet var missionBriefingTextView : UITextView!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        agentNameTextField.delegate = self //set delegate to textfile
        agenPasswordTextField.delegate = self 
        
        agentNameTextField.text = ""
        agenPasswordTextField.text = ""
        greetingLabel.text = ""
        missionBriefingTextView.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func authenticateAgentButton(sender : AnyObject)
    {
        authenticateAgent()
    }
    
    func authenticateAgent()
    {
        
        if (!(agentNameTextField.text.isEmpty) && !(agenPasswordTextField.text.isEmpty))
        {
            self.view.backgroundColor = UIColor.greenColor()
            
            var fullName = agentNameTextField.text
            var fullNameArr = split(fullName) {$0 == " "}
            var firstName: String = fullNameArr[0]
            var lastName: String = fullNameArr[1]
            //            var lastName: String? = fullNameArr.count > 1 ? fullNameArr[1] : nil
            
            greetingLabel.text = "Good evening Agent, \(lastName)"
            
            missionBriefingTextView.text = "This mission will be an arduous one, fraught with peril. You will cover much strange and unfamiliar territory. Should you choose to accept this mission, Agent \(lastName), you will certainly be disavowed, but you will be doing your country a great service. This message will self destruct in 5 seconds. "
            
        }
        else
        {
            self.view.backgroundColor = UIColor.redColor()
        }
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool        //delegate method
    {
        textField.resignFirstResponder()
        
        println("entered textFieldShouldReturn")
        if !agentNameTextField.text.isEmpty && agenPasswordTextField.text.isEmpty
        {
            agentNameTextField.resignFirstResponder()
            agenPasswordTextField.becomeFirstResponder()
        }
        if !agenPasswordTextField.text.isEmpty
        {
            agentNameTextField.resignFirstResponder()
            authenticateAgent()
        }
        
        return true
    }

}

