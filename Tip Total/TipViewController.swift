//
//  TipViewController.swift
//  Tip Total
//
//  Created by Mayank Bhatia on 2/28/17.
//  Copyright © 2017 Mayank Bhatia. All rights reserved.
//

import UIKit

class TipViewController: UIViewController {

    @IBOutlet weak var AmountField: UITextField!
    
    @IBOutlet weak var TipLabel: UILabel!
    
    @IBOutlet weak var TotalLabel: UILabel!
    
    @IBOutlet weak var tipPercentSegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let formatter = NumberFormatter()
        
        let defaults = UserDefaults.standard
        let date = defaults.object(forKey: "date") as? NSDate
        let currDate = NSDate()
        
        //if less than 10 mins, load saved amount
        if (date != nil) && (currDate.timeIntervalSince((date as? Date)!) < 600)
        {
            let savedAmount = defaults.integer(forKey: "amount")
            
            if (savedAmount > 0)
            {
                AmountField.text = String(savedAmount)
            }
            else
            {
                AmountField.placeholder = formatter.currencySymbol
            }
            
        }
        else    //load 0
        {
            AmountField.placeholder = formatter.currencySymbol
        }
        
        AmountField.becomeFirstResponder()
        
    }

    @IBAction func tapped(_ sender: Any) {        AmountField.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func percentChanged(_ sender: Any) {
        self.calculateTip()
    }
    
    @IBAction func CalculateTip(_ sender: Any) {
        
        self.calculateTip()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //set default tip
        let defaults = UserDefaults.standard
        tipPercentSegment.selectedSegmentIndex = defaults.integer(forKey: "tipIndex")
        self.calculateTip()
        AmountField.becomeFirstResponder()
    }
    

    func calculateTip()
    {
        let formatter = NumberFormatter()
        
        let amount = Double(AmountField.text!) ?? 0
        
        let tempAmount = amount as NSNumber
        var currencyString = "\(formatter.string(from: tempAmount)!)"

        if (amount == 0)
        {
            AmountField.placeholder = formatter.currencySymbol
        }
        else
        {
            AmountField.text = currencyString
        }
        
        let tipPercent = [15, 18, 20]
        
        let tip = (amount * Double(tipPercent[tipPercentSegment.selectedSegmentIndex]))/100
        
        let tempNumber = tip as NSNumber

        formatter.numberStyle = NumberFormatter.Style.currency

        currencyString = "\(formatter.string(from: tempNumber)!)"
        TipLabel.text = currencyString
        
        let total = (amount + tip) as NSNumber
        currencyString = "\(formatter.string(from: total)!)"
        TotalLabel.text = currencyString
        
        //Save amount to load later
        
        let defaults = UserDefaults.standard
        defaults.set(amount, forKey: "amount")
        defaults.synchronize()

        
    }

}

