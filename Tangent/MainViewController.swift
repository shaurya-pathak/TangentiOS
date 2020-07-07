//
//  MainViewController.swift
//  Tangent
//
//  Created by Shaurya Pathak on 7/6/20.
//  Copyright © 2020 Tangent. All rights reserved.
//

import UIKit
import SFProgressCircle

class Gradient  {
    var startColor: UIColor!
    var endColor: UIColor!
}

class MainViewController: UIViewController {

    
    @IBOutlet weak var progressCircle: SFCircleGradientView!
    @IBOutlet weak var progressCircleLabel: UILabel!
    @IBOutlet weak var accountabilityGrade: UILabel!
    @IBOutlet weak var gradientBg: UIImageView!
    @IBOutlet weak var deadlineLabel: UILabel!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var settingsLabel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressCircle.progress = 0.775
        progressCircleLabel.text = "Done"
        accountabilityGrade.layer.cornerRadius = 15
        accountabilityGrade.clipsToBounds = true
        initalizeThemes()
        initalizeGradients()
        setTheme()
        // Do any additional setup after loading the view.
    }
    
    var gradientArray : [Gradient] = []
    
    func setTheme   ()  {
        let gradient = gradientArray[selectedTheme]
        let theme = Themes[selectedTheme]
        gradientBg.isHidden = !(theme.showGradient)
        backgroundView.backgroundColor = theme.primary
        deadlineLabel.textColor = theme.secondary
        settingsLabel.setTitleColor(theme.secondary, for: .normal)
        accountabilityGrade.backgroundColor = theme.secondary
        accountabilityGrade.textColor = theme.primary
        progressCircle.startColor = gradient.startColor
        progressCircle.endColor = gradient.endColor
        progressCircleLabel.textColor = theme.secondary
    }
    
    func initalizeThemes    ()  {
        let white = UIColor(displayP3Red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        let tangentBlue = UIColor(displayP3Red: 0/255, green: 71/255, blue: 212/255, alpha: 1.0)
        let standard = colorMaker(tangentBlue, secondary: white, gradient: true, tag: 0)
        let light = colorMaker(white, secondary: UIColor(displayP3Red: 0/255, green: 71/255, blue: 212/255, alpha: 1.0), gradient: false, tag: 1)
        let dark = colorMaker(UIColor(displayP3Red: 56/255, green: 56/255, blue: 56/255, alpha: 1.0), secondary: UIColor(displayP3Red: 212/255, green: 183/255, blue: 0/255, alpha: 1.0), gradient: false, tag: 2)
        Themes.append(standard)
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
