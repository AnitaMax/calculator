//
//  calculatorBrain.swift
//  calculter
//
//  Created by Apple44 on 19/3/25.
//  Copyright © 2019年 zhy. All rights reserved.
//

import Foundation
//定义阶乘函数
func jiecheng(_ num:Double)->Double{
    if num>100{
        return Double.nan
    }
    if num <= 1{
        return num
    }
    else{
        return num*jiecheng(num-1)
    }
}
//定义二元运算结构
struct binaryopt{
    let firstoprend:Double
    let binoptfunc:((Double,Double)->Double)
    func perform(with sencondoprend:Double)->Double{
        return binoptfunc(firstoprend,sencondoprend)
    }
}
//储存上一次等号后的得数
var lastequal:Double = 0
//运算结构体
struct calculatorBrain{
    init(){
        
    }
    private var accumluation:Double?
    public var descirbsion:String?=""
    var result:Double?{
        get{
            return accumluation
        }
    }
    
    public mutating func clearDecscibsion(){
        descirbsion = ""
    }
    private enum Operation{
        case Constant(Double)
        case unaryOperation((Double)->Double)
        case binaryOpt((Double,Double)->Double)
        case equals
    }
    private var operations:Dictionary<String,Operation>=[
        "π":Operation.Constant(Double.pi),
        "e":Operation.Constant(M_E),
        "√":Operation.unaryOperation(sqrt),
        "cos":Operation.unaryOperation(cos),
        "sin":Operation.unaryOperation(sin),
        "tan":Operation.unaryOperation(tan),
        
        "+":Operation.binaryOpt(+),
        "-":Operation.binaryOpt(-),
        "*":Operation.binaryOpt(*),
        "/":Operation.binaryOpt(/),
        "+-":Operation.unaryOperation(-),
        "=":Operation.equals,
        
        "²":Operation.unaryOperation{num in pow(num,2)},
        "^":Operation.binaryOpt(pow),
        "x!":Operation.unaryOperation(jiecheng),
        "1/x":Operation.unaryOperation{num in 1 / num},
        "lg":Operation.unaryOperation(log10),
        "ln":Operation.unaryOperation(log),
        "%":Operation.unaryOperation{num in num/100},
        
        "tan-¹":Operation.unaryOperation(atan),
        "sin-¹":Operation.unaryOperation(asin),
        "cos-¹":Operation.unaryOperation(acos),
        
        "last":Operation.Constant(lastequal),
        
    ]
    var binOptStruct:binaryopt?
    mutating func performOpt(_ opt:String){
        if let opration=operations[opt]{
            switch opration {
            case .Constant(let value):
                accumluation = value
                descirbsion = opt
            case .unaryOperation(let function):
                if accumluation != nil{
                    var num:String
                    if opt == "+-"{
                        num = String(function(accumluation!))
                    }
                    else if opt == "%" {
                        num = String(accumluation!)+opt
                    }
                    else if opt.range(of: "x") != nil {
                        num = opt.replacingOccurrences(of: "x", with:String(accumluation!))
                    }
                    else if opt == "²" {
                        num = String(accumluation!) + opt
                    }
                    else{
                        num = opt+String(accumluation!)
                    }
                    if binOptStruct != nil{
                        
                    }
                    else{
                        descirbsion = num
                    }
                    accumluation = function(accumluation!)
                }
            case .binaryOpt(let function):
                if accumluation != nil{
                    binOptStruct = binaryopt(firstoprend: accumluation!, binoptfunc: function)
                    descirbsion = String(accumluation!)+opt
                    accumluation = nil
                }
            case .equals:
                if binOptStruct != nil && accumluation != nil {
                    descirbsion = descirbsion!+String(accumluation!)
                    accumluation = binOptStruct?.perform(with: accumluation!)
                    descirbsion = descirbsion!+"="+String(accumluation!)
                    binOptStruct = nil
                }
                else{
                    if ((descirbsion?.range(of: "=")) != nil) || descirbsion == ""  {
                        descirbsion = String(accumluation!)+"="+String(accumluation!)
                    }
                    else{
                        descirbsion = descirbsion!+"="+String(accumluation!)
                    }
                }
                lastequal = accumluation!
                operations["last"] = Operation.Constant(lastequal)

            }
            
            
        }
        
    }

    
    mutating func setOperand(_ operand :Double){
        self.accumluation = operand
    }
}
