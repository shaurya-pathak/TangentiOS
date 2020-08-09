//
//  SignInMenuViewController.swift
//  Simul
//
//  Created by Shaurya Pathak on 6/8/20.
//  Copyright © 2020 Simul Workout. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import GoogleSignIn
import FirebaseDatabase
import FirebaseAuth
import GoogleAPIClientForREST
import GTMSessionFetcher

var goatUser = Auth.auth().currentUser?.uid

let googleDriveService = GTLRDriveService()
var googleUser: GIDGoogleUser?

class ViewController: UIViewController, GIDSignInDelegate   {
    
    var db : Firestore!
    var docRef : DocumentReference!
    
    var postData = [String]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        autoSignIn()
        db = Firestore.firestore()
        docRef = db.collection("locations").document("location2")
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        //print(user)
        print("ned")
        
        
    }
    
    func autoSignIn ()  {
        if goatUser != nil  {
            performSegue(withIdentifier: "registerSegueGoogle", sender: self)
        }
    }
    
    /*override func viewDidAppear(_ animated: Bool) {
     docRef.getDocument { (docSnapshot, error) in
     guard let docSnapshot = docSnapshot, docSnapshot.exists else { return }
     let myData = docSnapshot.data()
     let latestData = myData?["latitude"]
     print(latestData!)
     }
     }*/
    
    // Present a sign-in with Google window
    @IBAction func googleSignIn(sender: AnyObject) {
        GIDSignIn.sharedInstance().signIn()
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        print("Google Sign In didSignInForUser")
        if let error = error {
            print(error.localizedDescription)
            googleDriveService.authorizer = nil
            googleUser = nil
            
            return
        }
        else    {
            googleDriveService.authorizer = user.authentication.fetcherAuthorizer()
            googleUser = user
        }
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: (authentication.idToken)!, accessToken: (authentication.accessToken)!)
        // When user is signed in
        Auth.auth().signIn(with: credential, completion: { (user, error) in
            if let error = error {
                print("Login error: \(error.localizedDescription)")
                return
            }
            else    {
                goatUser = Auth.auth().currentUser?.uid
                self.performSegue(withIdentifier: "registerSegueGoogle", sender: self)
                
            }
        })
    }
    // Start Google OAuth2 Authentication
    func sign(_ signIn: GIDSignIn?, present viewController: UIViewController?) {
        
        // Showing OAuth2 authentication window
        if let aController = viewController {
            present(aController, animated: true) {() -> Void in }
        }
    }
    // After Google OAuth2 authentication
    func sign(_ signIn: GIDSignIn?, dismiss viewController: UIViewController?) {
        // Close OAuth2 authentication window
        dismiss(animated: true) {() -> Void in }
    }
    @IBAction func tempPresser(_ sender: Any) {
        
    }
}

