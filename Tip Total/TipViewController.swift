//
//  TipViewController.swift
//  Tip Total
//
//  Created by Mayank Bhatia on 2/28/17.
//  Copyright © 2017 Mayank Bhatia. All rights reserved.
//

import UIKit

class TipViewController: UIViewController {

    @IBOutlet weak var AmountLabel: UILabel!
    @IBOutlet weak var AmountField: UITextField!
    
    @IBOutlet weak var TipTotalView: UIView!
    @IBOutlet weak var TipLabel: UILabel!
    @IBOutlet weak var TipAmount: UILabel!
    @IBOutlet weak var TipUnderlineLabel: UILabel!
    
    
    @IBOutlet weak var TotalLabel: UILabel!
    @IBOutlet weak var TotalAmount: UILabel!
    @IBOutlet weak var TotalUnderlineLabel: UILabel!
    
    @IBOutlet weak var tipPercentSegment: UISegmentedControl!
    
    @IBOutlet var TipTotalCollection: [UIView]!
    
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
        
        //select correct color theme
        let defaults = UserDefaults.standard
        let colorTheme = defaults.integer(forKey: "colorTheme")
        
        //if light
        if (colorTheme == 0)
        {
            self.view.tintColor = UIColor.black
            self.view.backgroundColor = UIColor.white

            
            for myView in TipTotalCollection
            {
                if let aLabel = myView as? UILabel
                {
                    aLabel.textColor = UIColor.black
                }
                else if let aLabel = myView as? UITextField
                {
                    aLabel.textColor = UIColor.black
                }

                // Apply your styles
                myView.tintColor = UIColor.black
                myView.backgroundColor = UIColor.white
            }
            
        }
        else //dark
        {
            self.view.tintColor = UIColor.white
            self.view.backgroundColor = UIColor.black
            
            for myView in TipTotalCollection
            {
                if let aLabel = myView as? UILabel
                {
                    aLabel.textColor = UIColor.white
                }
                else if let aLabel = myView as? UITextField
                {
                    aLabel.textColor = UIColor.white
                }
                
                myView.tintColor = UIColor.white
                myView.backgroundColor = UIColor.black
            }

        }
        
        if (AmountField.text?.isEmpty)!
        {
            if (self.TipTotalView.alpha == 1)
            {
                //fade out all other fields
                UIView.animate(withDuration: 0.4, animations: {
                    
                    let y_offset = self.view.frame.height/5
                    let x_offset = self.view.frame.width/4
                    
                    self.AmountField.frame.origin.x -= x_offset
                    
                    self.AmountField.frame.origin.y += y_offset
                    self.AmountLabel.frame.origin.y += y_offset
                    
                    self.TipTotalView.frame.origin.y += 400
                    self.TipTotalView.alpha = 0
                })
            }
        }
        
        
        //set default tip
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
            
            if (self.TipTotalView.alpha == 1)
            {
                //fade out all other fields
                UIView.animate(withDuration: 0.4, animations: {
                    
                    let y_offset = self.view.frame.height/5
                    let x_offset = self.view.frame.width/4
                    
                    self.AmountField.frame.origin.x -= x_offset

                    self.AmountField.frame.origin.y += y_offset
                    self.AmountLabel.frame.origin.y += y_offset
                    
                    self.TipTotalView.frame.origin.y += 400
                    self.TipTotalView.alpha = 0
                })
            }
        }
        else
        {
            AmountField.text = currencyString
            
            if (self.TipTotalView.alpha == 0)
            {
                UIView.animate(withDuration: 0.4, animations: {
                    
                    let y_offset = self.view.frame.height/5
                    let x_offset = self.view.frame.width/4
                    
                    self.AmountField.frame.origin.x += x_offset

                    self.AmountField.frame.origin.y -= y_offset
                    self.AmountLabel.frame.origin.y -= y_offset
                    
                    self.TipTotalView.frame.origin.y -= 400
                    self.TipTotalView.alpha = 1
                })
            }
        }
        
        let tipPercent = [15, 18, 20]
        
        let tip = (amount * Double(tipPercent[tipPercentSegment.selectedSegmentIndex]))/100
        
        let tempNumber = tip as NSNumber

        formatter.numberStyle = NumberFormatter.Style.currency

        currencyString = "\(formatter.string(from: tempNumber)!)"
        TipAmount.text = currencyString
        
        let total = (amount + tip) as NSNumber
        currencyString = "\(formatter.string(from: total)!)"
        TotalAmount.text = currencyString
        
    

        //Save amount to load later
        
        let defaults = UserDefaults.standard
        defaults.set(amount, forKey: "amount")
        defaults.synchronize()

        
    }

}

