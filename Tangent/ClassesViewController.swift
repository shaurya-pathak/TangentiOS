//
//  ClassesViewController.swift
//  Tangent
//
//  Created by Shaurya Pathak on 7/13/20.
//  Copyright © 2020 Tangent. All rights reserved.
//


import UIKit
import SCLAlertView
import GoogleAPIClientForREST

class classesCell :  UITableViewCell  {
    
    @IBOutlet weak var classesView: UIView!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var verticalMenuButton: UIButton!
    
}

class TangentClass {
    var subject : String!
    var period: String!
    var instructor: String!
}


class ClassesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var classesLabel: UILabel!
    @IBOutlet weak var addNewClassButton: UIButton!
    @IBOutlet weak var classesTableView: UITableView!
    
    var classArray : [TangentClass] = []
    var courseArray : [GTLRClassroom_Course] = []
    var selectedIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        classesTableView.delegate = self
        classesTableView.dataSource = self
        classesTableView.backgroundColor = UIColor.clear
        googleClassroomList()
        
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
        cell.periodLabel.text = "\(currentClass.period ?? "2")"
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let inx = indexPath.row
        selectedIndex = inx
        performSegue(withIdentifier: "goToClassSegue", sender: self)
    }
    
    @IBAction func addClassButton(_ sender: Any) {
        showCustomAlert()
    }
    
    func classesMaker  (_ subject: String, period: String) -> TangentClass {
        let newClass = TangentClass()
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
    
    func googleClassroomList()   {
        
        //let sharedInstance = GIDSignIn.sharedInstance()
        //let handler = sharedInstance
        googleClassroomService.apiKey = "AIzaSyBOGamjhRuu45T2jT7Qa3LmtntSwgIxeqo"
        let query = GTLRClassroomQuery_CoursesList.query()
        let group = DispatchGroup()
        
        
        query.pageSize = 1000
        print("HERE IS QUERY??? \(query)")
        group.enter()
        var allOfTheCourses : [GTLRClassroom_Course] = []
        
        let classQuery = googleClassroomService.executeQuery(query, completionHandler: { ticket , fileList, error in
        
        if error != nil {
            let message = "Error: \(error?.localizedDescription ?? "")"
            print(message)
        } else {
            group.leave()
            if let list = (fileList as? GTLRClassroom_ListCoursesResponse) {
                //self.fileList = list
                print("List: \(list.courses)")
                allOfTheCourses = list.courses!
            }
            else {
                print("Error: response is not a file list")
                print(fileList)
                
                
            }
            }
       group.notify(queue: DispatchQueue.main) {
            self.courseArray = allOfTheCourses
            self.addCoursesToList(allOfTheCourses)
            }
    }
    )
    }
    
    func addCoursesToList(_ courses: [GTLRClassroom_Course]) {
        
        for course in courses   {
            if course.courseState == "ACTIVE"   {
            let name = course.name!
            let period = course.section
                
            let tangentClass = classesMaker(name, period: (period ?? ""))
            classArray.append(tangentClass)
                
            }
        }
        classesTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToClassSegue"   {
            let destination: ProjectsViewController = segue.destination as! ProjectsViewController
            destination.selectedCourse = courseArray[selectedIndex]
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
