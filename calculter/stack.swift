//
//  stack.swift
//  calculter
//
//  Created by Zheng Max on 2019/3/24.
//  Copyright © 2019年 zhy. All rights reserved.
//

import Foundation

class stack{
    var elements = [String]()
    public var count:Int{
        return elements.count
    }
    public init(){}
    public func pop()-> String?{
        return elements.popLast()
    }
    public func push(_ element: String){
        elements.append(element)
    }
    public func peek() ->String?{
        return elements.last
    }
    public func isEmpty()->Bool{
        return elements.isEmpty
    }
}
