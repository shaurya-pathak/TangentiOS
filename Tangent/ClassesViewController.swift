//
//  ClassesViewController.swift
//  Tangent
//
//  Created by Shaurya Pathak on 7/13/20.
//  Copyright © 2020 Tangent. All rights reserved.
//


import UIKit
import SCLAlertView

class classesCell :  UITableViewCell  {
    
    @IBOutlet weak var classesView: UIView!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var verticalMenuButton: UIButton!
    @IBOutlet weak var instructorName: UILabel!
    
}

class TangentClass {
    var subject : String!
    var period: Int!
    var instructor: String!
}


class ClassesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var classesLabel: UILabel!
    @IBOutlet weak var addNewClassButton: UIButton!
    @IBOutlet weak var classesTableView: UITableView!
    
    var classArray : [TangentClass] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let class1 = classesMaker("Engineering", period: 2, instructor: "Mrs. Smith")
        classArray.append(class1)
        
        classesTableView.delegate = self
        classesTableView.dataSource = self
        classesTableView.backgroundColor = UIColor.clear
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "classesCell", for: indexPath) as? classesCell else {
            fatalError("No CardTableViewCell for cardCell id")
        }
        let index = indexPath.row
        let currentClass = classArray[index]
        cell.subjectLabel.text = currentClass.subject
        cell.instructorName.text = currentClass.instructor
        cell.periodLabel.text = "\(currentClass.period ?? 2)"
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToClassSegue", sender: self)
    }
    
    @IBAction func addClassButton(_ sender: Any) {
        showCustomAlert()
    }
    
    func classesMaker  (_ subject: String, period: Int, instructor: String!) -> TangentClass {
        let newClass = TangentClass()
        newClass.instructor = instructor
        newClass.period = period
        newClass.subject = subject
        
        return newClass
    }
    
    func showCustomAlert    ()  {
        
        let appearance = SCLAlertView.SCLAppearance(
            showCircularIcon: false
        )
        let alertView = SCLAlertView(appearance: appearance)
        
        alertView.addButton("Create Class") {
            self.performSegue(withIdentifier: "createClassSegue", sender: self)
        }
        alertView.addButton("Join Class") {
            let createClassAlertView = SCLAlertView(appearance: appearance)

            let joinCodeText = createClassAlertView.addTextField("Class Code") //Silence Warning
            createClassAlertView.addButton("Join") {
                self.joinPreExistingClass(joinCodeText.text!)
            }
            createClassAlertView.showInfo("Join Class", subTitle: "Enter class code", closeButtonTitle: "Cancel")
        }
        alertView.showInfo("Add Class", subTitle: "Either create a new class or join a preexisting class", closeButtonTitle: "Cancel")
        
    }
    
    func joinPreExistingClass   (_ joinCode: String)  {
        print(joinCode)
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
