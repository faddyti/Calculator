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
    var brain = CalculatorBrain()
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
    }
    // 操作符的处理
    @IBAction func operate(_ sender: UIButton) {
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(symbol: operation) {
                displayValue = result
            }
            else{
                displayValue = 0
            }
        }
        if userIsInTheTypingAnumber{
            enter()
        }
    }
    // 按回车键
    @IBAction func enter() {
        userIsInTheTypingAnumber = false
        if let result = brain.pushOperand(operand: displayValue) {
            displayValue = result
        }
        else{
            displayValue = 0
        }
    }
}

