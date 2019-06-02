//
//  ViewController.swift
//  calculter
//
//  Created by Apple44 on 19/3/18.
//  Copyright © 2019年 zhy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var main: UILabel!
    @IBOutlet weak var describ: UILabel!
    @IBOutlet weak var sin: UIButton!
    @IBOutlet weak var tan: UIButton!
    @IBOutlet weak var cos: UIButton!
    
    var haspoint = false
    var isopt = false
    var hasleft = false
    var isResult = false
    var isNaN = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.main.text = "0"
        self.describ.text = ""
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clear(_ sender: UIButton) {
        self.describ.text = ""
        self.main.text = "0"
        self.haspoint = false
        self.isopt = false
        self.hasleft = false
        self.isNaN = false
        self.brain.clearDecscibsion()
        //恢复变大的结果
        main.font = UIFont.systemFont(ofSize: 28)
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
        //恢复变大的结果
        main.font = UIFont.systemFont(ofSize: 28)
        //处理当前显示为上一次的处理结果的场景
        if isResult {
            main.text = "0"
            haspoint=false
        }
        isResult = false
        //处理当前显示不合法的场景
        isNaN = false

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
    
    @IBAction func last(_ sender: UIButton) {
        main.text = String(lastequal)
        isResult = true
    }
    
    @IBAction func back(_ sender: UIButton) {
        //结果不许回退
        if isResult {
            return
        }
        
        let pretext:String? = self.main.text
        let len=pretext?.characters.count
        //回退时如果是小数点就重置小数点flag
        if pretext?.substring(from: (pretext?.index((pretext?.endIndex)!, offsetBy: -1))!) == "."{
            self.haspoint = false
        }
        //回退
        if len! >= 1 {
            self.main.text = self.main.text?.substring(to: (pretext?.index((pretext?.endIndex)!, offsetBy: -1))!)
        }
        if len == 1{
            self.main.text = "0"
        }
    }
    var brain = calculatorBrain()
    let magicWord : Dictionary<String,String>=[
        "520":"520 i love you",
        "4.1":"4.1 your festival",
        "521":"521 fffffffffffff",
    ]
    @IBAction func one_opts(_ sender: UIButton) {
        //结果变大
        if sender.currentTitle == "="{
            main.font = UIFont.systemFont(ofSize: 50)
            
        }
        else{
            //恢复变大的结果
            main.font = UIFont.systemFont(ofSize: 28)
            
        }
        //魔术词的计算
        for word in magicWord.keys{
            if magicWord[word] == self.main.text{
                self.main.text = word
            }
        }
        //当结果不合法时禁止继续计算
        if self.isNaN == true {
            self.brain.clearDecscibsion()
            return
        }
        //开始计算
        brain.setOperand(self.curValue)
        brain.performOpt(sender.currentTitle!)
        if let res=brain.result  {
            //处理不合法结果
            if res.isNaN || res.isInfinite {
                self.main.text = "超出范围或不合法"
                isNaN = true
            }
            //  处理整数的小数点问题 520.0 －>520 和 结果的小数点
                
            
            else if String(res).substring(from: String(res).index(String(res).endIndex, offsetBy: -2)) == ".0" {
                self.main.text=String(res).substring(to: String(res).index(String(res).endIndex, offsetBy: -2))
                self.haspoint=false
            }
            else{
                self.curValue = res
                self.haspoint=true
            }
            //魔力词显示
            for word in magicWord.keys {
                if word == main.text  {
                    self.main.text = magicWord[word]
                }
             }
         }
        describ.text = brain.descirbsion!
        isResult = true
    }
    
    @IBAction func changTriFunc(_ sender: UIButton) {
        if sin.currentTitle == "sin"{
            sin.setTitle("sin-¹", for: UIControlState.normal)
            cos.setTitle("cos-¹", for: UIControlState.normal)
            tan.setTitle("tan-¹", for: UIControlState.normal)
        }
        else{
            sin.setTitle("sin", for: UIControlState.normal)
            cos.setTitle("cos", for: UIControlState.normal)
            tan.setTitle("tan", for: UIControlState.normal)
        }
    }
    

    @IBOutlet weak var line1: UIStackView!
    @IBOutlet weak var line2: UIStackView!
    @IBOutlet weak var x: UIButton!
    @IBOutlet weak var genhao: UIButton!
    @IBOutlet weak var daoshu: UIButton!
    @IBOutlet weak var pai: UIButton!
    @IBOutlet weak var e: UIButton!
    @IBAction func turn(_ sender: UIButton) {
        let super_opt  :[UIView ] = [line1,line2,x,genhao,daoshu,pai,e]
        if line1.isHidden == false {
            for each in super_opt {
                each .isHidden = true
            }
        }
        else{
            for each in super_opt {
                each .isHidden = false
            }
        }

        
        
        
    }
}

