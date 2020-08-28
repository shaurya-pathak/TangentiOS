//
//  ProjectsViewController.swift
//  Tangent
//
//  Created by Shaurya Pathak on 7/17/20.
//  Copyright © 2020 Tangent. All rights reserved.
//

import UIKit
import GoogleAPIClientForREST

class projectCell : UITableViewCell {
    
    @IBOutlet weak var projectLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    
}

class project   {
    var projectName : String!
    var projectId: String!
    var projectDueDate: String!
    var projectTime: String!
}

class ProjectsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var instructorLabel: UILabel!
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var projectsTableView: UITableView!
    
    var selectedCourse : GTLRClassroom_Course!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        projectsTableView.dataSource = self
        projectsTableView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        courseWorkCreate()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "projectCell", for: indexPath) as? projectCell else {
            fatalError("No CardTableViewCell for cardCell id")
        }
        let index = indexPath.row
        cell.projectLabel.text = "TYE Worlds"
        cell.dueDateLabel.text = "07/17/2020"
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func datePicker()   {
        
    }
    
    @IBAction func createProjectButtonTapped(_ sender: Any) {
        seguePerform(name: "createProjectSegue")
    }
    
    func seguePerform(name: String) {
        performSegue(withIdentifier: name, sender: self)
    }
    
    func courseWorkCreate() {
        let id = selectedCourse.identifier
        let coursework = GTLRClassroom_CourseWork.init()
        GTLRClassroomQuery_CoursesCourseWorkCreate.query(withObject: coursework, courseId: "127062596928")
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createProjectSegue" {
            let destination: ImportFromGoogleClassroomViewController = segue.destination as! ImportFromGoogleClassroomViewController
            destination.selectedCourseClass = selectedCourse
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
