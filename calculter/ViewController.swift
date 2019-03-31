//
//  ViewController.swift
//  calculter
//
//  Created by Apple44 on 19/3/18.
//  Copyright © 2019年 zhy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var previous: UILabel!
    @IBOutlet weak var main: UILabel!
    @IBOutlet weak var result: UILabel!
    
    var haspoint = false
    var isopt = false
    var hasleft = false
    var isResult = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.previous.text = ""
        self.main.text = "0"
        self.result.text = ""
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clear(_ sender: UIButton) {
        self.main.text = "0"
        self.result.text = ""
        self.haspoint = false
        self.isopt = false
        self.hasleft = false
    }
    var curValue:Double{
        get{
            return Double(self.main.text!)!
        }
        set{
            self.main.text = String(newValue)
        }
    }
    @IBAction func numbers(_ sender: UIButton) {
        if isResult {
            main.text = "0"
        }
        isResult = false
        switch  sender.currentTitle! {
        case ".":
            if self.haspoint == true {
                return
            }
            if self.main.text == ""{
                self.main.text = self.main.text! + "0"
            }
            self.main.text = self.main.text! + sender.currentTitle!
            self.isopt = false
            self.haspoint = true
        case "0","1","2","3","4","5","6","7","8","9":
            if  main.text == "0"{
                if sender.currentTitle == "0"{
                    return
                }
                self.main.text?.removeAll()
            }
            self.main.text = self.main.text! + sender.currentTitle!
            self.isopt = false
        default:
            return
        }
        
    }
    
    
    @IBAction func back(_ sender: UIButton) {
        let pretext:String? = self.main.text
        let len=pretext?.characters.count
        if pretext?.substring(from: (pretext?.index((pretext?.endIndex)!, offsetBy: -1))!) == "."{
            self.haspoint = false
        }
        if len! >= 1 {
            self.main.text = self.main.text?.substring(to: (pretext?.index((pretext?.endIndex)!, offsetBy: -1))!)
        }
        if len == 1{
            self.main.text = "0"
        }
    }
    var brain = calculatorBrain()
    @IBAction func one_opts(_ sender: UIButton) {
        brain.setOperand(self.curValue)
        brain.performOpt(sender.currentTitle!)
        if let res=brain.result  {
            self.curValue = res
            if res == 520{
                self.main.text = "520 我爱你"
            }
        }
        isResult = true
    }
    
}

