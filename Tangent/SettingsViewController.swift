//
//  SettingsViewController.swift
//  Tangent
//
//  Created by Shaurya Pathak on 7/6/20.
//  Copyright © 2020 Tangent. All rights reserved.
//

import UIKit

class Colors    {
    var primary : UIColor!
    var secondary : UIColor!
    var showGradient : Bool!
    var themeTag : Int!
}
var Themes : [Colors] = []
var selectedTheme = 0

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var gradientBackground: UIImageView!
    @IBOutlet weak var themeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var settingsText: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet var backgroundView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setTheme()
    }
    
    
    
    
    
    func setTheme   ()  {
        
        let theme = Themes[selectedTheme]
        themeSegmentedControl.selectedSegmentIndex = selectedTheme
        gradientBackground.isHidden = !(theme.showGradient)
        backgroundView.backgroundColor = theme.primary
        settingsText.textColor = theme.secondary
        backButton.setTitleColor(theme.secondary, for: .normal)
        
        
    }
    
    @IBAction func themeSelectorDidChange(_ sender: Any) {
        selectedTheme = themeSegmentedControl.selectedSegmentIndex
        setTheme()
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
