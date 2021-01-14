//
//  ImportFromGoogleClassroomViewController.swift
//  Tangent
//
//  Created by Shaurya Pathak on 8/19/20.
//  Copyright © 2020 Tangent. All rights reserved.
//

import UIKit
import SimpleCheckbox
import GoogleAPIClientForREST

class selectFromGoogleClassroomCell : UITableViewCell   {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var deadlineLabel: UILabel!
    @IBOutlet weak var checkBox: Checkbox!
    
}

class ImportFromGoogleClassroomViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var selectFromClassroomTableVIew: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        selectFromClassroomTableVIew.dataSource = self
        selectFromClassroomTableVIew.delegate = self
        loadCoursework()
    }
    
    var selectedCourseClass : GTLRClassroom_Course!
    var assignmentsArray : [GTLRClassroom_CourseWork] = []
    var checkedArray : [Bool] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        for i in 0...assignmentsArray.count {
            checkedArray.append(false)
        }
        return assignmentsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "selectFromGoogleClassroomCell", for: indexPath) as? selectFromGoogleClassroomCell else {
            fatalError("No CardTableViewCell for cardCell id")
        }
        let index = indexPath.row
        let currentAssignment = assignmentsArray[index]
        cell.checkBox.borderStyle = .circle
        cell.checkBox.checkedBorderColor = .white
        cell.checkBox.uncheckedBorderColor = .white
        cell.checkBox.checkmarkStyle = .circle
        cell.checkBox.checkmarkColor = .white
        cell.checkBox.tag = index
        cell.checkBox.isChecked = checkedArray[index]
        cell.checkBox.borderLineWidth = 3
        cell.titleLabel.text = currentAssignment.title
        let day = currentAssignment.dueDate?.day
        if day != nil   {
            let date = "\((currentAssignment.dueDate!.month)!)/\((currentAssignment.dueDate!.day)!)/\((currentAssignment.dueDate!.year)!)"
        cell.deadlineLabel.text = date
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let inx = indexPath.row
        checkedArray[inx] = !checkedArray[inx]
        selectFromClassroomTableVIew.reloadData()
    }
    
    func loadCoursework()   {
        
        let id = selectedCourseClass.identifier
        let courseWorkQuery = GTLRClassroomQuery_CoursesCourseWorkList.query(withCourseId: id!)
        courseWorkQuery.pageSize = 10
        let classQuery = googleClassroomService.executeQuery(courseWorkQuery, completionHandler: { ticket , courseworkList, error in
            
            if error != nil {
                let message = "Error: \(error?.localizedDescription ?? "")"
                print(message)
            } else {
                if let list = (courseworkList as? GTLRClassroom_ListCourseWorkResponse) {
                    //self.fileList = list
                    print("List: \(list.courseWork![0].materials![0].link?.url)")
                    self.addCourseworkFromClassroom(list.courseWork!)
                }
                else {
                    print("Error: response is not a coursework list")
                    print(courseworkList)
                    
                    
                }
                }
        }
        )
    }
    
    func addCourseworkFromClassroom (_ courseworks: [GTLRClassroom_CourseWork])  {
        for coursework in courseworks   {
            assignmentsArray.append(coursework)
        }
        selectFromClassroomTableVIew.reloadData()
    }
    
    @IBAction func checkBoxWasSelected(_ sender: Checkbox) {
        let inx = sender.tag
        checkedArray[inx] = !checkedArray[inx]
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
