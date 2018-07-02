//
//  PageController.swift
//  InterActiveStoryApp
//
//  Created by Jordan Leahy on 6/28/18.
//  Copyright © 2018 Jordan Leahy. All rights reserved.
//
/*
 - PageController should never be created without an instance of page.
 - page is of type Page? optional since assigning dummy value in init coder is not good nor will fatalError("Init Code not implement") suitable.

*/

import Foundation
import UIKit

class PageController: UIViewController {
    
    //Add stored property to hold the page we'll be working with.
    var page: Page?
    
    // MARK: - User Interface Properties
    
    let artworkView = UIImageView()
    let storyLabel = UILabel()
    let firstChoiceButton = UIButton(type: .system)
    let secondChoiceButton = UIButton(type: .system)
    
    
    //Call superclass initializer because init coder is a designated initializer.  Without, we'd get 'required initializer 'init(c0der:)' must be provided by sublcass of 'UIViewcontroller' Error.  We need init coder since we are loading a ViewController throught storyboard.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //This is our subclass designated initializer. Call appropriate designated initialer on UIViewController to initialize up the chain and pass in nil, nil
    init(page: Page) {
        self.page = page
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Unwrap since page is an optional property. 
        if let page = page {
            
            artworkView.image = page.story.artwork  //Shows first image/artwork inside of an image view for the first page in our story
            
            //Contains the string we want to display along with a dictionary with certain keys to make modifications
            let attributedString = NSMutableAttributedString(string: page.story.text)
          
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 10
            
            attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
            
            storyLabel.attributedText = attributedString
            
            // See if firstChoice is nil or not. Set button text to firstChoice text. If firstChoice nil, "Play Again"
            if let firstChoice = page.firstChoice {
                firstChoiceButton.setTitle(firstChoice.title, for: .normal)
            } else {
                firstChoiceButton.setTitle("Play Again", for: .normal)
            }
            
            if let secondChoice = page.secondChoice {
                secondChoiceButton.setTitle(secondChoice.title, for: .normal)
            }
            
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Creating Views Progammatically
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        //Add artworkView as a subview of our main view.  Same as dragging UIImageView in IB
        view.addSubview(artworkView)
        //Turn off iOS's automatic constraint view so we can add our own constraints
        artworkView.translatesAutoresizingMaskIntoConstraints = false
        
        
        //Set constraints by pinning artworkView anchors to main view anchors
        NSLayoutConstraint.activate([
            artworkView.topAnchor.constraint(equalTo: view.topAnchor),
            artworkView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            artworkView.rightAnchor.constraint(equalTo: view.rightAnchor),
            artworkView.leftAnchor.constraint(equalTo: view.leftAnchor)
            ])
        
        //Add storyLabel as a subview in our main view.
        view.addSubview(storyLabel)
        //Allows swift to determine how many lines it needs to display to show all the text. Default is 1 line
        storyLabel.numberOfLines = 0
        
        //Turn off iOS's automatic constraint view so we can add our own constraints
        storyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            storyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0), // 16 points
            storyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            storyLabel.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -48.0)
            
            ])
        //Add firstChoiceButton as a subviw in our main view
        view.addSubview(firstChoiceButton)
        firstChoiceButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            firstChoiceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstChoiceButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80.0)
            ])
        //Add secondChoiceButton as a subviw in our main view
        view.addSubview(secondChoiceButton)
        secondChoiceButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            secondChoiceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondChoiceButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32)
            ])
    }
    

}
