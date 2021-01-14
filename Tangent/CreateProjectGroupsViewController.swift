//
//  CreateProjectGroupsViewController.swift
//  Tangent
//
//  Created by Shaurya Pathak on 9/3/20.
//  Copyright © 2020 Tangent. All rights reserved.
//

import UIKit
import GoogleAPIClientForREST

class assignGroupCell : UITableViewCell {
    
    @IBOutlet weak var studentsCellView: UIView!
    @IBOutlet weak var studentNameLabel: UILabel!
    @IBOutlet weak var groupNumberTextField: UITextField!
    
}

class CreateProjectGroupsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        studentsTableView.delegate = self
        studentsTableView.dataSource = self
    }
    
    var projectG = Project()
    var automatic : Bool!
    
    @IBOutlet weak var studentsTableView: UITableView!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(projectG.memberArray.count)
        return projectG.memberArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "assignGroupCell", for: indexPath) as? assignGroupCell else {
            fatalError("No CardTableViewCell for cardCell id")
        }
        let inx = indexPath.row
        cell.studentNameLabel.text = "\(projectG.memberArray[inx].memberName!)"
        if automatic   {
            cell.groupNumberTextField.text = "\(projectG.memberArray[inx].groupNumber!)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    
    /*@IBAction func projectAssigned(_ sender: Any) {
        let coursework : GTLRClassroom_CourseWork!
        coursework.
        GTLRClassroomQuery_CoursesCourseWorkCreate.query(withObject: <#T##GTLRClassroom_CourseWork#>, courseId: <#T##String#>)
    }*/
    
}
