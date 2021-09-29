//
//  noteCalculationViewController.swift
//  Notes
//
//  Created by Bill on 11/18/20.
//  Copyright © 2020 Apple Developer. All rights reserved.
//

import UIKit


class noteCalculationViewController: UIViewController {

    @IBOutlet weak var weekTime: UITextField!
    @IBOutlet weak var weekTime_1: UITextField!
    @IBOutlet weak var weekTime_2: UITextField!
    @IBOutlet weak var weekTime_3: UITextField!
    
    @IBOutlet weak var salaryNetHour: UITextField!
    @IBOutlet weak var timeContrat: UITextField!
    @IBOutlet weak var remainingMonthly: UITextField!
    
    
    
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblOverTime: UILabel!
    @IBOutlet weak var lblTimeMonth: UILabel!
    @IBOutlet weak var lblExpectedMonthSalary: UILabel!
    @IBOutlet weak var lblOverTimeLegal: UILabel!
    @IBOutlet weak var lblTimeRemaining: UILabel!
    @IBOutlet weak var lblNetSalary: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    @IBAction func calcuTotal(_ sender: Any) {
        
        var week:Double = 0
        var week_1:Double = 0
        var week_2:Double = 0
        var week_3:Double = 0
        var totalTime:Double = 0
        var monthTime:Double = 0
        var overTime:Double = 0
        
        var expectSalary:Double = 0
        var netSalary:Double = 0
        var salaryNetHourNumber:Double = 0
        var timeContratNumber:Double = 0
        var overTimeLegal:Double = 0
        var timeRemaining:Double = 0
        
        if salaryNetHour.text != "" {
            salaryNetHourNumber = Double(salaryNetHour.text!)!
        }
        if timeContrat.text != "" {
            timeContratNumber = Double(timeContrat.text!)!
        }
        if remainingMonthly.text != "" {
            timeRemaining = Double(remainingMonthly.text!)!
        }
        if weekTime.text != "" {
            week = Double(weekTime.text!)!
        }
        if weekTime_1.text != "" {
            week_1 = Double(weekTime_1.text!)!
        }
        if weekTime_2.text != "" {
            week_2 = Double(weekTime_2.text!)!
        }
        if weekTime_3.text != "" {
            week_3 = Double(weekTime_3.text!)!
        }
        
        totalTime = week + week_1 + week_2 + week_3 + timeRemaining
        
        monthTime = timeContratNumber * 4
        
        expectSalary = totalTime * salaryNetHourNumber
        
        lblTotal.text = "Total Month's Time : " + String(format: "%.1f",totalTime) + " hours"
        
        if totalTime <= monthTime {
            lblTimeMonth.text = "Month's Time : " + String(format: "%.1f",totalTime) + " hours"
        } else {
            lblTimeMonth.text = "Month's Time : " + String(format: "%.1f",monthTime) + " hours"
        }
        
        
        if totalTime > monthTime {
            overTime = totalTime - monthTime
            lblOverTime.text = "Month's Overtime : " + String(format: "%.1f",overTime) + " hours"
            
            overTimeLegal = round(monthTime * 8 / 100)
            let OTLegal = overTimeLegal + monthTime
            
            timeRemaining = overTime - overTimeLegal
            
            if totalTime <= OTLegal {
                netSalary = totalTime * salaryNetHourNumber
            } else {
                netSalary = OTLegal * salaryNetHourNumber
            }
            
            
            if timeRemaining <= 0 {
                timeRemaining = 0
            }
            lblOverTimeLegal.text = "Month's Overtime Legal : " + String(format: "%.1f",OTLegal) + " hours"
            lblTimeRemaining.text = "Month's time remaining : " + String(format: "%.1f",timeRemaining) + " hours"
            
        } else {
            netSalary = expectSalary
            lblOverTimeLegal.text = "Month's Overtime Legal : 0.0 hour"
            lblTimeRemaining.text = "Month's time remaining : 0.0 hour"
            lblOverTime.text = "Month's Overtime : 0.0 hour"
        }
        lblNetSalary.text = "Net monthky salary : " + String(format: "%.2f",netSalary) + " €"
        lblExpectedMonthSalary.text = "Expected monthly salary : " + String(format: "%.2f",expectSalary) + " €"
        
    }

    
}
