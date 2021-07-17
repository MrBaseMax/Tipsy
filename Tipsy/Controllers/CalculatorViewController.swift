//
//  CalculatorViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    @IBOutlet weak var splitStepper: UIStepper!
    
    
    //    ------------------
    
    let segueName = "toResult"
    
    var pct = 0.1
    var pctLabel = "10%"
    var split = 2
    var bill = 0.0
    var total = "0.0"

    
    
    func count(bill: Double, tips: Double, people: Int)->String{
        assert(people != 0)
        let each = bill * ( 1 + tips ) / Double( people )
        return String( format: "%.2f", each )
    }
    
    
    @IBAction func tipChanged(_ sender: UIButton) {
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        sender.isSelected = true
        billTextField.endEditing(true)
        
        pctLabel = sender.currentTitle!
        
        switch sender.currentTitle {
            case "20%": pct = 0.2
            case "10%": pct = 0.1
            default: pct = 0
        }
    }
    
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        split = Int(sender.value)
        splitNumberLabel.text = String(split)
    }
    
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        bill = Double( billTextField.text! ) ?? 0.0
        total = count( bill: bill, tips: pct, people: split )
        
        performSegue(withIdentifier: segueName, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueName {
            let VC = segue.destination as! ResultsViewController
            VC.total = total
            VC.tips = pctLabel
            VC.people = String(split)
        }
    }
    
    
}

