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

struct submission   {
    
    var submitText : String!
    var icon : UIImage!
    var fileId : String!
    
}

class submitCell : UITableViewCell {
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var submissionLabel: UILabel!
    @IBOutlet weak var deleteSubmissionButton: UIButton!
    
}

class SubmissionViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    

    @IBOutlet weak var firstPageImage: UIImageView!
    @IBOutlet weak var secondPageImage: UIImageView!
    @IBOutlet weak var thirdPageImage: UIImageView!
    @IBOutlet weak var gradientBg: UIImageView!
    @IBOutlet weak var submitProjectLabel: UILabel!
    @IBOutlet weak var projectNameLabel: UILabel!
    /*@IBOutlet weak var page1View: UIView!
    @IBOutlet weak var page2View: UIView!
    @IBOutlet weak var page3View: UIView!
    @IBOutlet weak var page1Label: UILabel!
    @IBOutlet weak var page2Label: UILabel!
    @IBOutlet weak var page3Label: UILabel!*/
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var submissionTableView: UITableView!
    
    // Google Drive Access
    let picker = HSDrivePicker()
    
    var imagePicker = UIImagePickerController()
    var indexImagePicker = 0
    
    var submissionArray : [submission] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imagePicker.delegate = self
        submissionTableView.delegate = self
        submissionTableView.dataSource = self
        //setTheme()
        
    }

    
    @IBAction func addFileFromGoogleDriveButtonPressed(_ sender: Any) {
        let appearance = SCLAlertView.SCLAppearance(
            showCircularIcon: false
        )
        let alertView = SCLAlertView(appearance: appearance)
        alertView.addButton("Google Drive") {
            self.addFileFromGoogleDrive()
        }
        alertView.addButton("Add Image") {
            self.addImage()
        }
        alertView.showInfo("Add Files", subTitle: "What type of file would you like to add?")
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return submissionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "submitCell", for: indexPath) as? submitCell else {
            fatalError("No CardTableViewCell for cardCell id")
        }
        let index = indexPath.row
        cell.iconImage.image = submissionArray[index].icon
        cell.submissionLabel.text = submissionArray[index].submitText
        cell.deleteSubmissionButton.tag = index
        return cell
    }
    
    func addImage ()    {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            let img = image
            let imgName = "Image"
            submissionArray.append(submission(submitText: imgName, icon: img))
            submissionTableView.reloadData()
            
        }
        else    {
            print("fail")
        }
        dismiss(animated: true, completion: nil)
        //img.layer.cornerRadius = img.frame.size.height / 2
        
        
        
    }
    
    func revisionHistoryRetrieve (_ fileId: String!)    {
        let revisionQuery = GTLRDriveQuery_RevisionsList.query(withFileId: fileId)
        let revisionExecQuery = googleDriveService.executeQuery(revisionQuery) { (ticket, revisionList, error) in
            if error != nil {
                let message = "Error: \(error?.localizedDescription ?? "")"
                print(message)
            } else {
                if let list = (revisionList as? GTLRDrive_RevisionList) {
                    //self.fileList = list
                    print("List: \((list.revisions![0].lastModifyingUser))")
                }
                else {
                    print("Error: response is not a coursework list")
                    print(revisionList)
                    
                    
                }
                }
        }
    }
    
    @IBAction func submitButton(_ sender: Any) {
        //showCustomAlertView()
        let fileId = submissionArray[0].fileId
        revisionHistoryRetrieve(fileId)
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

    func addFileFromGoogleDrive()  {
        
        picker.pick(from: self) {
            (manager, file) in

            print("picked file: \(file?.iconLink ?? "-none-")")
            let name = file?.name
            let image = file?.iconLink
            let fileId = file?.identifier
            var pic : UIImage!
            if image == "https://drive-thirdparty.googleusercontent.com/16/type/application/vnd.google-apps.document"   {
                pic = UIImage(named: "googleDocsLogo")
            }
            if image == "https://drive-thirdparty.googleusercontent.com/16/type/application/vnd.google-apps.spreadsheet"    {
                pic = UIImage(named: "googleSheetsLogo")
            }
            if image == "https://drive-thirdparty.googleusercontent.com/16/type/application/pdf"    {
                pic = UIImage(named: "pdfLogo")
            }
            if image == "https://drive-thirdparty.googleusercontent.com/16/type/application/vnd.google-apps.presentation"    {
                pic = UIImage(named: "googleSlidesLogo")
            }
            
            self.submissionArray.append(submission(submitText: name, icon: pic, fileId: fileId))
            self.submissionTableView.reloadData()
        }
        
    }
    
    func addFileFromGallery()   {
        
    }
    
    
    @IBAction func deleteSubmissionAtIndex(_ sender: UIButton) {
        print(sender.tag)
        let fileToDelete = submissionArray[sender.tag].submitText!
        let appearance = SCLAlertView.SCLAppearance(
            showCircularIcon: false
        )
        let alertView = SCLAlertView(appearance: appearance)
        alertView.addButton("Remove") {
            self.submissionArray.remove(at: sender.tag)
            self.submissionTableView.reloadData()
        }
        alertView.showInfo("Delete", subTitle: "Are you sure you want to remove \(fileToDelete)")
        
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

