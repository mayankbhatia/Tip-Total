//
//  SettingsViewController.swift
//  Tip Total
//
//  Created by Mayank Bhatia on 3/3/17.
//  Copyright © 2017 Mayank Bhatia. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var defaultTipSegment: UISegmentedControl!
    
    
    @IBAction func selectDefaultTip(_ sender: Any) {
        
        let defaults = UserDefaults.standard
        defaults.set(defaultTipSegment.selectedSegmentIndex, forKey: "tipIndex")
        defaults.synchronize()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let defaults = UserDefaults.standard
        defaultTipSegment.selectedSegmentIndex = defaults.integer(forKey: "tipIndex")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
