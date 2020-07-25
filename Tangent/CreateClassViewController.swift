//
//  CreateClassViewController.swift
//  Tangent
//
//  Created by Shaurya Pathak on 7/18/20.
//  Copyright © 2020 Tangent. All rights reserved.
//

import UIKit

class CreateClassViewController: UIViewController {

    @IBOutlet weak var createClassLabel: UILabel!
    @IBOutlet weak var subjectNameTextField: UITextField!
    @IBOutlet weak var periodTextField: UITextField!
    @IBOutlet weak var teacherNameTextField: UITextField!
    @IBOutlet weak var finishCreateClassButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func finishedButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
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
