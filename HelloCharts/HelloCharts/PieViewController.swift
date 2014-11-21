//
//  PieViewController.swift
//  HelloCharts
//
//  Created by Hayley Guillou on 2014-11-17.
//  Copyright (c) 2014 hayleyguillou. All rights reserved.
//

import UIKit

class PieViewController: UIViewController {
    var stepsToday = 100
    var stepsPast = 4908
    var goalSteps = 50000
    
    
    @IBOutlet weak var pieView: PieView!
    @IBOutlet weak var goalTextField: UITextField!
    @IBOutlet weak var historyTextField: UITextField!
    @IBOutlet weak var todayTextField: UITextField!
    
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    
    override func viewDidLoad() {
        todayLabel.text = "\(stepsToday)"
        pieView.loadInitialData(stepsToday, completed: stepsPast, required: max(0, goalSteps - stepsPast - stepsToday))
        var percentage: Double = Double(stepsToday + stepsPast) / Double(goalSteps) * 100.0
        percentLabel.text = "\(Int(percentage))%"
        todayLabel.text = "\(stepsToday)"
        
        // Timer to autoincrement steps
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
    }
    
    @IBAction func pedometerStart(sender: AnyObject) {
        
        update()
        
    }
    
    func update() {
        stepsToday = stepsToday + 4
        pieView.updateGraph(stepsToday, completed: stepsPast, required: max(0, goalSteps - stepsPast - stepsToday))
        var percentage: Double = Double(stepsToday + stepsPast) / Double(goalSteps) * 100.0
        percentLabel.text = "\(Int(percentage))%"
        todayLabel.text = "\(stepsToday)"
    }
    
    @IBAction func submitValues(sender: AnyObject) {
        
        if (goalTextField.text.isEmpty || historyTextField.text.isEmpty || todayTextField.text.isEmpty) {
            //Error: break
            return
        }
        
        var goalNum: Int = goalTextField.text.toInt()!
        var historyNum: Int = historyTextField.text.toInt()!
        var todayNum: Int = todayTextField.text.toInt()!
        var stepsLeft: Int = max(goalNum - todayNum - historyNum, 0)
        var percentage: Double = Double(todayNum + historyNum) / Double(goalNum) * 100.0
        
        pieView.updateGraph(todayNum, completed: historyNum, required: stepsLeft)
        
        percentLabel.text = "\(Int(percentage))%"
        
        goalSteps = goalNum
        stepsToday = todayNum
        stepsPast = historyNum
    }
}
