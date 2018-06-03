//
//  ViewController.swift
//  Calculator
//
//  Created by JY on 2018/6/1.
//  Copyright © 2018年 JY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //MARK: 属性
    // 计算结果显示
    @IBOutlet weak var display: UILabel!
    // 是否在输入数字状态
    var userIsInTheTypingAnumber = false
    // 数字栈
    var operandStack = [Double]()
    // 将显示数字做属性处理
    var displayValue: Double {
        get{
            return NumberFormatter().number(from: display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            userIsInTheTypingAnumber = false
        }
    }
    //MARK: 方法
    // 输入状态不断添加数字
    @IBAction func appendDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheTypingAnumber {
            display.text = display.text! + digit
        }
        else{
            display.text = digit
            userIsInTheTypingAnumber = true
        }
        print("digit = \(digit)")
    }
    // 操作符的处理
    @IBAction func operate(_ sender: UIButton) {
        let opertation = sender.currentTitle!
        if userIsInTheTypingAnumber{
            enter()
        }
        switch opertation {
        case "×": performOperation { $0 * $1 }
        case "÷": performOperation { $1 / $0 }
        case "+": performOperation { $0 + $1 }
        case "−": performOperation { $1 - $0 }
        case "√": performOperation { sqrt($0) }
        default:break
            
        }
    }
    // 处理计算
    func performOperation(operation: (Double,Double) -> Double){
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    func performOperation(operation: (Double) -> Double){
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    // 按回车键
    @IBAction func enter() {
        userIsInTheTypingAnumber = false
        operandStack.append(displayValue)
        print("operandStack = \(operandStack)")
    }
}

