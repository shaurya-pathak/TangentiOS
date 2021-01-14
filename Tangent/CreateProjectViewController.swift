//
//  CreateProjectViewController.swift
//  Tangent
//
//  Created by Shaurya Pathak on 7/24/20.
//  Copyright © 2020 Tangent. All rights reserved.
//

import UIKit
import DatePickerDialog
import IHKeyboardAvoiding

class CreateProjectViewController: UIViewController {
    
    @IBOutlet weak var projectNameTextField: UITextField!
    @IBOutlet weak var projectInstructionsTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.project.id = selectedCourseClass!
    }
    
    var project = Project()
    var selectedCourseClass : String!
    var dateString : String!
    
    @IBAction func dateSelectButtonTapped(_ sender: Any) {
        chooseDate()
        print("yes")
    }
    // groupSettingsSegue
    
    func chooseDate()   {
        print("this works")
        DatePickerDialog().show("Select Date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .date) {
            (date) -> Void in
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "MM/dd/yyyy"
                self.dateString = formatter.string(from: dt)
                    }
            else    {
                print("wut")
            }
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "groupSettingsSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "groupSettingsSegue" {
            let destination: CreateProjectSettingsViewController = segue.destination as! CreateProjectSettingsViewController
            self.project.projectName = projectNameTextField.text
            self.project.projectInstructions = projectInstructionsTextView.text
            self.project.dueDate = dateString
            destination.projectS = project
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
