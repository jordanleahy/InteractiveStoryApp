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
 - Every view controller has an optional property, navigation controller

*/


import UIKit

//Create this extensions so we don't have to create range: on the fly everytime.
extension NSAttributedString {
    var stringRange: NSRange {
        return NSMakeRange(0, self.length) //We do self.length because we're in the stype type right now.
    }
}

extension Story {
    // Add computed property called attributedString that simply returns an attributed string with our style applied.
    var attributedText: NSAttributedString {
        //Contains the string we want to display along with a dictionary with certain keys to make modifications.
        let attributedString = NSMutableAttributedString(string: text)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        
        attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: attributedString.stringRange)
        
        return attributedString
    }
}

// If attributed is true, we want to return story.attributedText otherwise we'll return the plain story without any styles applied but as an NSAttributedString
extension Page {
    func story(attributed: Bool) -> NSAttributedString {
        if attributed {
            return story.attributedText
        } else {
            return NSAttributedString(string: story.text)
        }
    }
}

class PageController: UIViewController {
    
    //Add stored property to hold the page we'll be working with.
    var page: Page?
    
    // MARK: - User Interface Stored Properties
    
    //Closure/Anonymous immediately executing function
    //lazy stored property that is created after the class's initialization is complete which allows us to use page: Page?
    lazy var artworkView: UIImageView = {
        let imageView = UIImageView()
        //Turn off iOS's automatic constraint view so we can add our own constraints
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //Shows first image/artwork inside of an image view for the first page in our story
        imageView.image = self.page?.story.artwork
        
        return imageView
    }()
    
    //Closure/Anonymous immediately executing function
    lazy var storyLabel: UILabel = {
        let label = UILabel()
        //Turn off iOS's automatic constraint view so we can add our own constraints
        label.translatesAutoresizingMaskIntoConstraints = false
        //Allows swift to determine how many lines it needs to display to show all the text. Default is 1 line
        label.numberOfLines = 0
        label.attributedText = self.page?.story(attributed: true)

        return label
    }()
    
    //Closure/Anonymous immediately executing function
    lazy var firstChoiceButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        
        // nil coalescing operator. The added benefit here is that we get to use a single constant, "title" rather than declaring an empty string variable and assigning a value depending on an if statement.
        let title = self.page?.firstChoice?.title ?? "Play Again"
        // ternary conditional operator. If this returns true, meaning firstChoice isn't nil, we provide a true case and after colon : provide false case.
        let selector = self.page?.firstChoice != nil ? #selector(PageController.loadFirstChoice) : #selector(PageController.playAgain)
        
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: selector, for: .touchUpInside)
        
        return button
    }()
    
    //Closure/Anonymous immediately executing function
    lazy var secondChoiceButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle(self.page?.secondChoice?.title, for: .normal)
        button.addTarget(self, action: #selector(PageController.loadSecondChoice), for: .touchUpInside)
        
        return button
    }()
    
    //Call superclass initializer because init coder is a designated initializer.  Without, we'd get 'required initializer 'init(c0der:)' must be provided by sublcass of 'UIViewcontroller' Error.  We need init coder since we are loading a ViewController through storyboard.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //This is our subclass designated initializer. Call appropriate designated initializer on UIViewController to initialize up the chain and pass in nil, nil
    init(page: Page) {
        self.page = page
        super.init(nibName: nil, bundle: nil)
    }

    //MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
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
        
        
        
        //Set constraints by pinning artworkView anchors to main view anchors
        NSLayoutConstraint.activate([
            artworkView.topAnchor.constraint(equalTo: view.topAnchor),
            artworkView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            artworkView.rightAnchor.constraint(equalTo: view.rightAnchor),
            artworkView.leftAnchor.constraint(equalTo: view.leftAnchor)
            ])
        
        //Add storyLabel as a subview in our main view.
        view.addSubview(storyLabel)
        
        
        NSLayoutConstraint.activate([
            storyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0), // 16 points
            storyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            storyLabel.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -48.0)
            
            ])
        //Add firstChoiceButton as a subviw in our main view
        view.addSubview(firstChoiceButton)
        
        NSLayoutConstraint.activate([
            firstChoiceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstChoiceButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80.0)
            ])
        
        //Add secondChoiceButton as a subviw in our main view
        view.addSubview(secondChoiceButton)
        
        NSLayoutConstraint.activate([
            secondChoiceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondChoiceButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32)
            ])
    }
    
    //MARK: - Button pre and post conditions
    
    ///Allows us to spin up a new page when one of the buttons are tapped. Inside this method we will retrieve the page instance stored in the firstChoice property and initialize a new PageController with it.
    @objc func loadFirstChoice() {
        if let page = page, let firstChoice = page.firstChoice { //unwrap page and firstChoice
            let nextPage = firstChoice.page // new page used to create page controller instance and assign to constant
            let pageController = PageController(page: nextPage) // Create new PageController instance.
            
            //Ask navigationController to push pageController onto the stack
            navigationController?.pushViewController(pageController, animated: true)
        }
    }
    
    ///Allows us to spin up a new page when one of the buttons are tapped. Inside this method we will retrieve the page instance stored in the firstChoice property and initialize a new PageController.
    @objc func loadSecondChoice() {
        if let page = page, let secondChoice = page.secondChoice {
            let nextPage = secondChoice.page
            let pageController = PageController(page: nextPage)
            
            navigationController?.pushViewController(pageController, animated: true)
        }
    }
    
    @objc func playAgain() {
        navigationController?.popToRootViewController(animated: true)
    }

}
