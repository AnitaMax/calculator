//
//  calculatorBrain.swift
//  calculter
//
//  Created by Apple44 on 19/3/25.
//  Copyright © 2019年 zhy. All rights reserved.
//

import Foundation
func jiecheng(_ num:Double)->Double{
    if num <= 1{
        return num
    }
    else{
        return num*jiecheng(num-1)
    }
}
struct binaryopt{
    let firstoprend:Double
    let binoptfunc:((Double,Double)->Double)
    func perform(with sencondoprend:Double)->Double{
        return binoptfunc(firstoprend,sencondoprend)
    }
}

struct calculatorBrain{
    init(){
        
    }
    private var accumluation:Double?
    var result:Double?{
        get{
            return accumluation
        }
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
        
        "2nd":Operation.unaryOperation{num in pow(num,2)},
        "^":Operation.binaryOpt(pow),
        "x!":Operation.unaryOperation(jiecheng),
        "1/x":Operation.unaryOperation{num in 1 / num},
        "lg":Operation.unaryOperation(log10),
        "ln":Operation.unaryOperation(log),
        "%":Operation.unaryOperation{num in num/100},
        
    ]
    var binOptStruct:binaryopt?
    mutating func performOpt(_ opt:String){
        if let opration=operations[opt]{
            switch opration {
            case .Constant(let value):
                accumluation = value
            case .unaryOperation(let function):
                if accumluation != nil{
                    accumluation = function(accumluation!)
                }
            case .binaryOpt(let function):
                if accumluation != nil{
                    binOptStruct = binaryopt(firstoprend: accumluation!, binoptfunc: function)
                    accumluation = nil
                }
            case .equals:
                if binOptStruct != nil && accumluation != nil {
                    accumluation = binOptStruct?.perform(with: accumluation!)
                    binOptStruct = nil
                }
            }
            
            
        }
        
    }

    
    mutating func setOperand(_ operand :Double){
        self.accumluation = operand
    }
}
