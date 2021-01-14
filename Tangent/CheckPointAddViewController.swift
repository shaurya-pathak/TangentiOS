//
//  CheckPointAddViewController.swift
//  Tangent
//
//  Created by Shaurya Pathak on 10/17/20.
//  Copyright © 2020 Tangent. All rights reserved.
//

import UIKit
import SCLAlertView
import DatePickerDialog

class CheckPointAddViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var checkpointTableView: UITableView!
    
    @IBAction func addCheckPointButtonPressed(_ sender: Any) {
        showCustomAlert()
    }
    
    func showCustomAlert    ()  {
        
        let appearance = SCLAlertView.SCLAppearance(
            showCircularIcon: false
        )
        let alertView = SCLAlertView(appearance: appearance)
        
        alertView.addTextField("Name")
        alertView.addButton("Join Class") {
            let createClassAlertView = SCLAlertView(appearance: appearance)
            createClassAlertView.addTextField("Class Code") //Silence Warning
            createClassAlertView.addButton("Join") {
            }
            createClassAlertView.showInfo("Join Class", subTitle: "Enter class code", closeButtonTitle: "Cancel")
        }
        alertView.showInfo("Add Class", subTitle: "Either create a new class or join a preexisting class", closeButtonTitle: "Cancel")
        
    }
    
    func chooseDate()   {
        print("this works")
        DatePickerDialog().show("Select Date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .date) {
            (date) -> Void in
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "MM/dd/yyyy"
                var dateString = ""
                dateString = formatter.string(from: dt)
                    }
            else    {
                print("wut")
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
