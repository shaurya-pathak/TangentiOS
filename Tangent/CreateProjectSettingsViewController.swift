//
//  CreateProjectSettingsViewController.swift
//  Tangent
//
//  Created by Shaurya Pathak on 9/3/20.
//  Copyright © 2020 Tangent. All rights reserved.
//

import UIKit
import GoogleAPIClientForREST

class CreateProjectSettingsViewController: UIViewController {

    @IBOutlet weak var autoManualSegmentedControl: UISegmentedControl!
    @IBOutlet weak var amtOfPeopleGroupTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    var projectS = Project()
    var students : [GTLRClassroom_Student] = []
    var studentNumber : [Int] = []
    var auto = true
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        getStudentData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "assignGroupsSegue"  {
            let destination: CreateProjectGroupsViewController = segue.destination as! CreateProjectGroupsViewController
            destination.projectG = projectS
            
            
            destination.automatic = auto
            
        }
    }
    
    func getStudentData()   {
        let id = projectS.id
        let studentsQuery = GTLRClassroomQuery_CoursesStudentsList.query(withCourseId: id!)
        studentsQuery.pageSize = 100
        googleClassroomService.executeQuery(studentsQuery, completionHandler: { ticket , studentList, error in
            
            if error != nil {
                let message = "Error: \(error?.localizedDescription ?? "")"
                print(message)
            } else {
                if let list = (studentList as? GTLRClassroom_ListStudentsResponse) {
                    self.students = list.students!
                    if self.auto {
                    self.studentNumber = self.randomizeOrder()
                    self.assignNumbers()
                    }
                    else    {
                        self.onlyAppendNames()
                    }
                }
                else {
                    print("Error: response is not a coursework list")
                    
                    
                }
                }
            self.performSegue(withIdentifier: "assignGroupsSegue", sender: self)
        }
        )
        
    }
    
    
    @IBAction func autoSegmentedIndexUpdated(_ sender: Any) {
        if autoManualSegmentedControl.selectedSegmentIndex == 1 {
            auto = false
        }
        else    {
            auto = true
        }
    }
    
    func randomizeOrder () -> [Int] {
        let count = students.count
        let max = Int(amtOfPeopleGroupTextField.text!)!
        var groupNumberArray : [Int] = []
        while groupNumberArray.count < count  {
        for i in 1...max    {
            if groupNumberArray.count < count   {
            groupNumberArray.append(i)
            }
        }
        }
        groupNumberArray.shuffle()
        return groupNumberArray
    }
    
    func assignNumbers ()   {
        for i in 0...studentNumber.count - 1  {
            let member = teamMember()
            member.groupNumber = studentNumber[i]
            member.memberName = students[i].profile?.name?.fullName
            print(i)
            projectS.memberArray.append(member)
        }
    }
    
    func onlyAppendNames () {
        for i in students   {
            let member = teamMember()
            member.memberName = i.profile?.name?.fullName
            projectS.memberArray.append(member)
        }
    }
    
    // Segue Name: assignGroupsSegue
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
