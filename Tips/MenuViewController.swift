//
//  MenuViewController.swift
//  Tips
//
//  Created by Gelei Chen on 30/11/2015.
//  Copyright © 2015 geleichen. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var control: UISegmentedControl!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBAction func segenControl(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            bottomLabel.text = "12%"
            defaults.setDouble(0.12, forKey: "defaultTip")
        case 1:
            bottomLabel.text = "20%"
            defaults.setDouble(0.20, forKey: "defaultTip")
        default:
            bottomLabel.text = "25%"
            defaults.setDouble(0.25, forKey: "defaultTip")
            
        }
    }
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Utils.mainColor
        control.tintColor = Utils.bottomColor
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        let rate = NSUserDefaults.standardUserDefaults().doubleForKey("defaultTip")
        if(rate != 0){
            
            switch rate {
            case 0.12:
                control.selectedSegmentIndex = 0
            case 0.20:
                control.selectedSegmentIndex = 1
            default:
                control.selectedSegmentIndex = 2
                
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
