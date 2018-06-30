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

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    ///Called anytime the segue is about to fire off. Added "startAdventure" as identifier 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Ensure code is only run if "startAdventure" segue is being executed
        if segue.identifier == "startAdventure" {
            // Acccess PageController via segue property 'destination' of type UIViewController and use conditional downcasting get instance we need.
            guard let pageController = segue.destination as? PageController else {
                return }
            
            pageController.page = Adventure.story
            
        }
    }


}

