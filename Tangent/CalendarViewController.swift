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
    
    var amountToDisplay = 0
    var selectedDate = "none"
    
    var deadlineArray : [Deadline] = []
    var deadlineMatchDateArray : [Deadline] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let deadline = deadlineMaker("Assignment Due", date: "07/15/2020", time: "11:59")
        let deadline2 = deadlineMaker("Finish Research", date: "07/15/2020", time: "11:59")
        let deadline3 = deadlineMaker("Finish HW", date: "07/17/2020", time: "11:59")
        deadlineArray.append(deadline)
        deadlineArray.append(deadline2)
        deadlineArray.append(deadline3)
        deadlineTableView.dataSource = self
        deadlineTableView.delegate = self
        calendar.dataSource = self
        calendar.delegate = self
        calendar.appearance.titleFont = UIFont(name: "Futura", size: 14)
        calendar.appearance.headerTitleFont = UIFont(name: "Futura-Bold", size: 20)
        calendar.calendarHeaderView.backgroundColor = Themes[0].secondary
        calendar.select(Date())
        newDateSelected(Date())
        calendar.reloadData()
        
            
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = ("MM/dd/yyyy")
        let formattedDate = dateFormatter.string(from: date)
        var amtOfDeadlines = 0
        for i in deadlineArray  {
            if formattedDate == i.deadlineDate    {
            amtOfDeadlines += 1
        }
        }
        return amtOfDeadlines
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        newDateSelected(date)
    }
    
    func newDateSelected    (_ date: Date)  {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = ("MM/dd/yyyy")
        let formattedDate = dateFormatter.string(from: date)
        if formattedDate == selectedDate    {
            calendar.deselect(date)
            selectedDate = "none"
            deadlineTableView.reloadData()
        }
        else    {
            deadlineMatchDateArray = []
            selectedDate = formattedDate
            
            for i in deadlineArray  {
                if i.deadlineDate == selectedDate   {
                    deadlineMatchDateArray.append(i)
                }
            }
            amountToDisplay = calendar.dataSource?.calendar?(calendar, numberOfEventsFor: date) as! Int
            if amountToDisplay > 0  {
                deadlineTableView.separatorColor = UIColor.lightGray
            }
            else    {
                deadlineTableView.separatorColor = UIColor.white
            }
            deadlineTableView.reloadData()
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
        
        
            cell.deadlineDateLabel.text = deadlineMatchDateArray[index].deadlineDate
            cell.deadlineLabel.text = deadlineMatchDateArray[index].deadlineTitle
            cell.deadlineTimeLabel.text = deadlineMatchDateArray[index].deadlineTime
            
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func deadlineMaker (_ title: String, date: String, time: String) -> Deadline  {
        let deadline = Deadline()
        deadline.deadlineTitle = title
        deadline.deadlineDate = date
        deadline.deadlineTime = time
        return deadline
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        performSegue(withIdentifier: "submitFromCalendarSegue", sender: self)
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
