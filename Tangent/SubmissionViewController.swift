//
//  SubmissionViewController.swift
//  Tangent
//
//  Created by Shaurya Pathak on 7/9/20.
//  Copyright © 2020 Tangent. All rights reserved.
//

import UIKit
import LGButton
import SCLAlertView
import GoogleAPIClientForREST
import GoogleSignIn
import HSGoogleDrivePicker

class SubmissionViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var firstPageImage: UIImageView!
    @IBOutlet weak var secondPageImage: UIImageView!
    @IBOutlet weak var thirdPageImage: UIImageView!
    @IBOutlet weak var gradientBg: UIImageView!
    @IBOutlet weak var submitProjectLabel: UILabel!
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var page1View: UIView!
    @IBOutlet weak var page2View: UIView!
    @IBOutlet weak var page3View: UIView!
    @IBOutlet weak var page1Label: UILabel!
    @IBOutlet weak var page2Label: UILabel!
    @IBOutlet weak var page3Label: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet var backgroundView: UIView!
    
    // Google Drive Access
    let picker = HSDrivePicker()
    
    var imagePicker = UIImagePickerController()
    var indexImagePicker = 0
    var img : [UIImageView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imagePicker.delegate = self
        img = [firstPageImage, secondPageImage, thirdPageImage]
        //setTheme()
    }
    
    @IBAction func firstPageButtonPress(_ sender: Any) {
        addImage(0)
    }
    
    @IBAction func secondPageButtonPress(_ sender: Any) {
        addImage(1)
    }
    
    @IBAction func thirdPageButtonPress(_ sender: Any) {
        addImage(2)
    }
    
    @IBAction func addFileFromGoogleDriveButtonPressed(_ sender: Any) {
        addFileFromGoogleDrive()
    }
    
    
    func addImage (_ index: Int)    {
        indexImagePicker = index
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            img[indexImagePicker].image = image
            
        }
        else    {
            print("fail")
        }
        dismiss(animated: true, completion: nil)
        //img.layer.cornerRadius = img.frame.size.height / 2
        
        
        
    }
    
    @IBAction func submitButton(_ sender: Any) {
        showCustomAlertView()
    }
    
    func showSimpleAlert() {
        let alert = UIAlertController(title: "Submit Assignment?", message: "This will submit your work to Google Classroom as well",         preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
            //Cancel Action
        }))
        alert.addAction(UIAlertAction(title: "Submit",
                                      style: UIAlertAction.Style.default,
                                      handler: {(_: UIAlertAction!) in
                                        //Sign out action
                                        print("yes")
                                        progress = 1.0
                                        projectText = "Done!"
                                        self.performSegue(withIdentifier:"afterSubmitSegue", sender: self)
                                        
                                        
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showCustomAlertView    ()  {
        let appearance = SCLAlertView.SCLAppearance(
            showCircularIcon: false
        )
        let alertView = SCLAlertView(appearance: appearance)
        alertView.addButton("Submit") {
            progress = 1.0
            projectText = "Done!"
            self.performSegue(withIdentifier:"afterSubmitSegue", sender: self)
        }
        alertView.showInfo("Submit", subTitle: "This will submit your work to Google Classroom as well.")
    }
    
    func setTheme   ()  {
        let theme = Themes[selectedTheme]
        let primary = theme.primary
        let secondary = theme.secondary
        submitProjectLabel.textColor = secondary
        projectNameLabel.textColor = secondary
        page1View.backgroundColor = secondary
        page2View.backgroundColor = secondary
        page3View.backgroundColor = secondary
        page1Label.textColor = primary
        page2Label.textColor = primary
        page3Label.textColor = primary
        submitButton.backgroundColor = secondary
        submitButton.setTitleColor(primary, for: .normal)
        backgroundView.backgroundColor = primary
        
        
        
    }
    
    func addFileFromGoogleDrive()  {
        picker.pick(from: self) {
            (manager, file) in

            print("picked file: \(file?.name ?? "-none-")")
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

