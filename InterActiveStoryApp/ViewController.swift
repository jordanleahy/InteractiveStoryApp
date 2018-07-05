//
//  ViewController.swift
//  InterActiveStoryApp
//
//  Created by Jordan Leahy on 6/26/18.
//  Copyright © 2018 Jordan Leahy. All rights reserved.
//
/*
 Class - UIStoryboardSegue: An object that prepares for and performs the visual transition between two view controllers
 Instance Method - prepare(for:sender): Notifies controller that a segue is about to be performed
 
 */

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var textFieldBottomConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    ///Called anytime the segue is about to fire off. Added "startAdventure" as identifier 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Ensure code is only run if "startAdventure" segue is being executed
        if segue.identifier == "startAdventure" {
            
            //Handle error right as it is thrown
            do {
                if let name = nameTextField.text {
                    if name == "" { //UITextField.text default is an empty string
                        throw AdventureError.nameNotProvided
                    } else {
                        // Acccess PageController via segue property 'destination' of type UIViewController and use conditional downcasting get instance we need.
                        guard let pageController = segue.destination as? PageController else {
                            return }
                        
                        pageController.page = Adventure.story(withName: name) //withName is story computed property
                    }
                }
            } catch AdventureError.nameNotProvided {
                //
                let alertController = UIAlertController(title: "Name Not Provideded", message: "Provide a name to start the story", preferredStyle: .alert)
                
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(action) // add action to alertController
                present(alertController, animated: true, completion: nil) //presents alertController modally.
                
            } catch let error { // generic catch bloack to account for system exhaustiveness
                fatalError("\(error.localizedDescription)")
            }
            
        }
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let info = notification.userInfo, let keyboardFrame = info[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let frame = keyboardFrame.cgRectValue
            textFieldBottomConstraint.constant = frame.size.height + 10
            
            UIView.animate(withDuration: 0.8) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }


}

