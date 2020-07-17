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


class SettingsViewController: UIViewController {
    
    @IBOutlet weak var themeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var settingsText: UILabel!
    @IBOutlet var backgroundView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setTheme()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //navigationController?.navigationBar.isHidden = true
    }
    
    
    func setTheme   ()  {
        
        let theme = Themes[selectedTheme]
        themeSegmentedControl.selectedSegmentIndex = selectedTheme
        backgroundView.backgroundColor = theme.primary
        settingsText.textColor = theme.secondary
        navigationController?.navigationBar.barTintColor = theme.primary
        
        
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
