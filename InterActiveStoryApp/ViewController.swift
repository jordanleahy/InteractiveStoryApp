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
    @IBOutlet weak var textFieldBottomConstraint: NSLayoutConstraint! //
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //When the system is about to display a keyboard, it fires off the UIKeyboardWillShow notification that is routed thRough NotificationCenter.  UIKeyboardWillShow is the name of the notification we are listening to.
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
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
                if let name = nameTextField.text { //unwrap text field property
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
        //
        if let info = notification.userInfo, let keyboardFrame = info[UIKeyboardFrameEndUserInfoKey] as? NSValue { //
            let frame = keyboardFrame.cgRectValue //convert the result from NSValue to cgRect so we can access frame.size.height
            textFieldBottomConstraint.constant = frame.size.height + 10 //access outlet constraint assign and add 10 points to keyboard height
            
            UIView.animate(withDuration: 0.8) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    
    @objc func keyboardWillHide(_ notification: Notification) {//Accept as an argument the notification that fired this off which is of type Notification
        // set constant on constraint back to original
        textFieldBottomConstraint.constant = 40
        
        UIView.animate(withDuration: 0.8) {
            self.view.layoutIfNeeded()
        }
    }
    
    //Once the ViewController subclass is deallocated and done with, we need to deregister ourselves as an observer
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    

}

extension ViewController: UITextFieldDelegate {
    
    //This method is called when a user taps on the Done button to get rid of keyboard.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() //transfer the first responder control back to ViewController.  Once we resignFirstResponder status, the system knows to get rid of the keyboard
        return true
    }
}




















