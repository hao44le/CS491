//
//  ViewController.swift
//  Tips
//
//  Created by Gelei Chen on 30/11/2015.
//  Copyright © 2015 geleichen. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate {
    var tipsAmountView : UILabel!
    var tableView : UITableView!
    var segmentedControl : UISegmentedControl!
    var tipsAmount = "0" {
        didSet{
            tipsAmountView.text = "$\(tipsAmount)"
            self.tableView.reloadData()
        }
    }
    var userCurrentInput : Double = 0.0 {
        didSet{
            self.tipsAmount = String(userCurrentInput * (tipsRate))
        }
    }
    
    var tipsRate  = 0.12 {
        didSet{
            if(userCurrentInput != 0.0){
              self.tipsAmount = String(userCurrentInput * (tipsRate))
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let rate = NSUserDefaults.standardUserDefaults().doubleForKey("defaultTip")
        if(rate != 0){
            tipsRate = rate
            switch rate {
            case 0.12:
                segmentedControl.selectedSegmentIndex = 0
            case 0.20:
                segmentedControl.selectedSegmentIndex = 1
            default:
                segmentedControl.selectedSegmentIndex = 2
                
            }
        }
    }
    func setUpView(){
        navigationController!.navigationBar.barTintColor = Utils.mainColor
        navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        navigationController!.navigationBar.barStyle = UIBarStyle.Black
        
        self.view.backgroundColor = Utils.mainColor
        
        let textField = UITextField(frame: CGRectMake(0,64,ScreenSize.SCREEN_WIDTH,100))
        textField.placeholder = "$"
        textField.keyboardType = UIKeyboardType.DecimalPad
        textField.textAlignment = NSTextAlignment.Right
        textField.textColor = UIColor.whiteColor()
        textField.font = UIFont.systemFontOfSize(60)
        textField.delegate = self
        textField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        
        segmentedControl = UISegmentedControl (items: ["15%","20%","25%"])
        segmentedControl.frame = CGRectMake(0,164,ScreenSize.SCREEN_WIDTH,29)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: "segmentedControlAction:", forControlEvents: .ValueChanged)
        segmentedControl.tintColor = Utils.bottomColor
        
        
        tipsAmountView = UILabel(frame: CGRectMake(ScreenSize.SCREEN_WIDTH - 200,193,200,40))
        tipsAmountView.text = "$\(tipsAmount)"
        tipsAmountView.textColor = UIColor.whiteColor()
        tipsAmountView.textAlignment = NSTextAlignment.Right
        
        let bottomView = UIView(frame: CGRectMake(0,233,ScreenSize.SCREEN_WIDTH,ScreenSize.SCREEN_HEIGHT - 233))
        bottomView.backgroundColor = Utils.bottomColor
        
        
        
        
        
        tableView = UITableView(frame: CGRectMake(0, 40, ScreenSize.SCREEN_WIDTH, bottomView.frame.height - 40))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = UIColor.clearColor()
        tableView.userInteractionEnabled = false
        tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        tableView.backgroundColor = Utils.bottomColor
        tableView.scrollEnabled = false
        
        
        bottomView.addSubview(tableView)
        
        
        
        self.view.addSubview(textField)
        self.view.addSubview(segmentedControl)
        self.view.addSubview(tipsAmountView)
        self.view.addSubview(bottomView)
    }
    func textFieldDidChange(textField: UITextField) {
//        print(textField.text)
        if(textField.text != ""){
            userCurrentInput = Double(textField.text!)!
        } else {
           userCurrentInput = 0.0
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func segmentedControlAction(sender:UISegmentedControl){
        switch sender.selectedSegmentIndex {
        case 0:
            self.tipsRate = 0.12
        case 1:
            self.tipsRate = 0.20
        default:
            self.tipsRate = 0.25
        }
        
        
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        for subView in cell.contentView.subviews {
            subView.removeFromSuperview()
        }
        let imageView:UIImageView = UIImageView(image: UIImage(named: "baby"))
        imageView.frame = CGRectMake(20, cell.frame.height / 2 - 20/2, 20, 20)
        cell.contentView.addSubview(imageView)
        // Configure the cell...
        
        switch indexPath.row {
        case 0 :
            let amountView = UILabel(frame: CGRectMake(50, 0, cell.frame.width - 80, cell.frame.height))
            amountView.text = "$\(String(Double((userCurrentInput * (1 + tipsRate)) / 1 ).format(".1")))"

            amountView.font = UIFont.systemFontOfSize(50)
            amountView.textColor = UIColor.whiteColor()
            amountView.textAlignment = NSTextAlignment.Right
            cell.contentView.addSubview(amountView)
        case 1:
            let imageView :UIImageView = UIImageView(image: UIImage(named: "baby"))
            imageView.frame = CGRectMake(50, cell.frame.height / 2 - 20/2, 20, 20)
            cell.contentView.addSubview(imageView)
            
            let amountView = UILabel(frame: CGRectMake(60, 0, cell.frame.width - 90, cell.frame.height))
            amountView.text = "$\(String(Double((userCurrentInput * (1 + tipsRate)) / 2 ).format(".1")))"

            amountView.font = UIFont.systemFontOfSize(40)
            amountView.textColor = UIColor.whiteColor()
            amountView.textAlignment = NSTextAlignment.Right
            cell.contentView.addSubview(amountView)

        case 2:
            let imageView :UIImageView = UIImageView(image: UIImage(named: "baby"))
            imageView.frame = CGRectMake(50, cell.frame.height / 2 - 20/2, 20, 20)
            cell.contentView.addSubview(imageView)
            
            let imageView2 :UIImageView = UIImageView(image: UIImage(named: "baby"))
            imageView2.frame = CGRectMake(80, cell.frame.height / 2 - 20/2, 20, 20)
            cell.contentView.addSubview(imageView2)
            
            let amountView = UILabel(frame: CGRectMake(110, 0, cell.frame.width - 140, cell.frame.height))
            amountView.text = "$\(String(Double((userCurrentInput * (1 + tipsRate)) / 3 ).format(".1")))"

            amountView.font = UIFont.systemFontOfSize(30)
            amountView.textColor = UIColor.whiteColor()
            amountView.textAlignment = NSTextAlignment.Right
            cell.contentView.addSubview(amountView)

        default:
            let imageView :UIImageView = UIImageView(image: UIImage(named: "baby"))
            imageView.frame = CGRectMake(50, cell.frame.height / 2 - 20/2, 20, 20)
            cell.contentView.addSubview(imageView)
            
            let imageView2 :UIImageView = UIImageView(image: UIImage(named: "baby"))
            imageView2.frame = CGRectMake(80, cell.frame.height / 2 - 20/2, 20, 20)
            cell.contentView.addSubview(imageView2)
            
            let imageView3 :UIImageView = UIImageView(image: UIImage(named: "baby"))
            imageView3.frame = CGRectMake(110, cell.frame.height / 2 - 20/2, 20, 20)
            cell.contentView.addSubview(imageView3)
            
            let amountView = UILabel(frame: CGRectMake(140, 0, cell.frame.width - 170, cell.frame.height))
            amountView.text = "$\(String(Double((userCurrentInput * (1 + tipsRate)) / 4 ).format(".1")))"
            amountView.font = UIFont.systemFontOfSize(20)
            amountView.textColor = UIColor.whiteColor()
            amountView.textAlignment = NSTextAlignment.Right
            cell.contentView.addSubview(amountView)
            
        }
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.backgroundColor = Utils.bottomColor
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if DeviceType.IS_IPHONE_5 {
            return 70
        } else if DeviceType.IS_IPHONE_6 {
            return 100
        } else if DeviceType.IS_IPHONE_6P {
            return 120
        } else if DeviceType.IS_IPHONE_4_OR_LESS {
            return 40
        } else {
            //ipad
            return 100
        }
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toPopup"{
            let popupSegue = segue as! CCMPopupSegue
            
            
            if (self.view.bounds.size.height < 420) {
                
                popupSegue.destinationBounds = CGRectMake(0, 0, 300, 400)
                //6 plus
            } else if (self.view.bounds.size.height == 736) {
                popupSegue.destinationBounds = CGRectMake(0, 0, (UIScreen.mainScreen().bounds.size.height-200) * 0.6, UIScreen.mainScreen().bounds.size.height-260)
                // 6
            } else if (self.view.bounds.size.height == 667) {
                popupSegue.destinationBounds = CGRectMake(0, 0, (UIScreen.mainScreen().bounds.size.height-150) * 0.65, UIScreen.mainScreen().bounds.size.height-200)
                // 5s / 5
            } else if (self.view.bounds.size.height == 568) {
                popupSegue.destinationBounds = CGRectMake(0, 0, (UIScreen.mainScreen().bounds.size.height-150) * 0.7, UIScreen.mainScreen().bounds.size.height-200)
                // 4s
            } else if (self.view.bounds.size.height == 480) {
                popupSegue.destinationBounds = CGRectMake(0, 0, (UIScreen.mainScreen().bounds.size.height-100) * 0.76, UIScreen.mainScreen().bounds.size.height-150)
                // ipad
            } else {
                popupSegue.destinationBounds = CGRectMake(0, 0, (UIScreen.mainScreen().bounds.size.height-100) * 0.7, UIScreen.mainScreen().bounds.size.height-150)
            }
            popupSegue.backgroundBlurRadius = 7
            popupSegue.backgroundViewAlpha = 0.3
            popupSegue.backgroundViewColor = UIColor.blackColor()
            popupSegue.dismissableByTouchingBackground = true
            
        }
        
    }
    
    
}

