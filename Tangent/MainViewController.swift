//
//  MainViewController.swift
//  Tangent
//
//  Created by Shaurya Pathak on 7/6/20.
//  Copyright © 2020 Tangent. All rights reserved.
//

import UIKit
import SFProgressCircle
import GoogleAPIClientForREST
import GoogleSignIn

class Gradient  {
    var startColor: UIColor!
    var endColor: UIColor!
}

var Themes : [Colors] = []
var gradientArray : [Gradient] = []
var selectedTheme = 0
var progress = 0.80
var projectText = "Turn In Executive Summary"

class MainViewController: UIViewController {

    let googleClassroomService = GTLRClassroomService()
    
    @IBOutlet weak var progressCircle: SFCircleGradientView!
    @IBOutlet weak var progressCircleLabel: UILabel!
    @IBOutlet weak var accountabilityGrade: UILabel!
    @IBOutlet weak var deadlineLabel: UILabel!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var settingsLabel: UIButton!
    @IBOutlet weak var tangentIcon: UIImageView!
    @IBOutlet weak var helloTextLabel: UILabel!
    @IBOutlet weak var projectLabel: UILabel!
    @IBOutlet weak var navigationBar: UITabBarItem!
    @IBOutlet weak var submitButton: UIButton!
    var fileList: GTLRClassroomQuery_CoursesList!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressCircle.progress = CGFloat(progress)
        let progressInt = Int(progress * 100)
        progressCircleLabel.text = "\(progressInt)%"
        accountabilityGrade.layer.cornerRadius = 15
        accountabilityGrade.clipsToBounds = true
        //navigationController?.navigationBar.isHidden = true
        initalizeThemes()
        initalizeGradients()
        print()
        
        googleClassroomList()
        
        //setTheme()
        // Do any additional setup after loading the view.
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        //setTheme()
        //deadlineLabel.text = projectText
        //navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    }
    
    
    
    func setTheme   ()  {
        let gradient = gradientArray[selectedTheme]
        let theme = Themes[selectedTheme]
        backgroundView.backgroundColor = theme.primary
        //deadlineLabel.textColor = theme.secondary
        settingsLabel.setTitleColor(theme.secondary, for: .normal)
        accountabilityGrade.backgroundColor = theme.secondary
        accountabilityGrade.textColor = theme.primary
        //progressCircle.startColor = gradient.startColor
        //progressCircle.endColor = gradient.endColor
        progressCircleLabel.textColor = theme.secondary
        settingsLabel.tintColor = theme.secondary
        tangentIcon.tintColor = theme.secondary
        //helloTextLabel.textColor = theme.secondary
        projectLabel.textColor = theme.secondary
        tabBarController?.tabBar.barTintColor = theme.primary
        submitButton.setTitleColor(theme.primary, for: .normal)
        submitButton.backgroundColor = theme.secondary
        
    }
    
    func initalizeThemes    ()  {
        
        let white = UIColor(displayP3Red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        let tangentBlue = UIColor(displayP3Red: 39/255, green: 100/255, blue: 195/255, alpha: 1.0)
        let darkGray = UIColor(displayP3Red: 30/255, green: 30/255, blue: 30/255, alpha: 1.0)
        let yellow = UIColor(displayP3Red: 255/255, green: 40/255, blue: 0/255, alpha: 1.0)

        let light = colorMaker(white, secondary: tangentBlue, gradient: false, tag: 1)
        let dark = colorMaker(darkGray, secondary: white, gradient: false, tag: 2)
        Themes.append(light)
        Themes.append(dark)
    }
    
    func colorMaker (_ primary: UIColor, secondary: UIColor, gradient: Bool, tag: Int) -> Colors  {
        let customTheme = Colors()
        customTheme.primary = primary
        customTheme.secondary = secondary
        customTheme.showGradient = gradient
        customTheme.themeTag = tag
        return customTheme
    }
    
    func initalizeGradients ()  {
        let white = UIColor(displayP3Red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        let aqua = UIColor(displayP3Red: 0, green: 1, blue: 1, alpha: 1.0)
        let tangentBlue = UIColor(displayP3Red: 0/255, green: 71/255, blue: 212/255, alpha: 1.0)
        let yellow = UIColor(displayP3Red: 212/255, green: 183/255, blue: 0/255, alpha: 1.0)
        let gradient0 = gradientMaker(white, end: aqua)
        let gradient1 = gradientMaker(tangentBlue, end: aqua)
        let gradient2 = gradientMaker(white, end: yellow)
        gradientArray.append(gradient0)
        gradientArray.append(gradient1)
        gradientArray.append(gradient2)
    }
    
    func gradientMaker  (_ start: UIColor, end: UIColor) -> Gradient {
        let gradient = Gradient()
        gradient.startColor = start
        gradient.endColor = end
        return gradient
    }
    
    @IBAction func settingsButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "settingsSegue", sender: self)
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "submitSegue", sender: self)
    }
    
    func googleClassroomList()   {
        let classroomService = GTLRClassroomService()
        //let sharedInstance = GIDSignIn.sharedInstance()
        //let handler = sharedInstance
        //classroomService.key = "258602243547-vg2s8qec0dr9eipava9meu5fcq6tqmcd.apps.googleusercontent.com"
        let query = GTLRClassroomQuery_CoursesList.query()
        
        query.pageSize = 1000
        
        let classQuery = classroomService.executeQuery(query, completionHandler: { ticket , fileList, error in
        
        if error != nil {
            let message = "Error: \(error?.localizedDescription ?? "")"
            print(message)
        } else {
            if let list = fileList as? GTLRClassroomQuery_CoursesList {
                self.fileList = list
                print("HI THE LIST IS HERE SHARUUUU \(list)")
            }
            else {
                print("Error: response is not a file list")
            }
            }
            
    }
    ) }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
