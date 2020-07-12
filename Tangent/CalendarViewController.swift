//
//  CalendarViewController.swift
//  Tangent
//
//  Created by Shaurya Pathak on 7/9/20.
//  Copyright © 2020 Tangent. All rights reserved.
//

import UIKit
import FSCalendar

class deadlineCell : UITableViewCell    {
    
    @IBOutlet weak var deadlineLabel: UILabel!
    @IBOutlet weak var deadlineDateLabel: UILabel!
    @IBOutlet weak var deadlineTimeLabel: UILabel!
    @IBOutlet weak var goToProjectButton: UIButton!
    
}

class Deadline  {
    
    var deadlineTitle : String!
    var deadlineDate : String!
    var deadlineTime : String!
    
}

class CalendarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {

    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var deadlineTableView: UITableView!
    
    var amountToDisplay = 1
    
    var deadlineArray : [Deadline] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        deadlineTableView.dataSource = self
        deadlineTableView.delegate = self
        calendar.dataSource = self
        calendar.delegate = self
        self.navigationController!.title = "Calendar"
            
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = ("MM/dd/yyyy")
        let formattedDate = dateFormatter.string(from: date)
        if formattedDate == "07/13/2020"    {
            return 1
        }
        else    {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return amountToDisplay
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "deadlineCell", for: indexPath) as? deadlineCell else {
            fatalError("No CardTableViewCell for cardCell id")
        }
        let index = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func deadlineMaker (_ title: String, date: String, time: String) -> Deadline  {
        let deadline = Deadline()
        deadline.deadlineTitle = title
        deadline.deadlineDate = date
        deadline.deadlineTime = time
        return deadline
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
