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

    @IBOutlet weak var keyboardDismissingView: KeyboardDismissingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func dateSelectButtonTapped(_ sender: Any) {
        chooseDate()
        print("yes")
    }
    
    
    func chooseDate()   {
        print("this works")
        DatePickerDialog().show("Select Date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .date) {
            (date) -> Void in
            if let dt = date {
                        let formatter = DateFormatter()
                        formatter.dateFormat = "MM/dd/yyyy"
                        let dateString = formatter.string(from: dt)
                        print(dateString)
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
