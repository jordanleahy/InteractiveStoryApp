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


import UIKit

class PageController: UIViewController {
    
    //Add stored property to hold the page we'll be working with.
    var page: Page?
    
    // MARK: - User Interface Properties
    
    let artworkView = UIImageView()
    let storyLabel = UILabel()
    let firstChoiceButton = UIButton(type: .system)
    let secondChoiceButton = UIButton(type: .system)
    
    
    //Call superclass initializer because init coder is a designated initializer.  Without, we'd get 'required initializer 'init(c0der:)' must be provided by sublcass of 'UIViewcontroller' Error. 
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //Call appropriate designated initialer on UIViewController to initialize up the chain and pass in nil, nil
    init(page: Page) {
        self.page = page
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Unwrap since page is an optional property. 
        if let page = page {
            
            artworkView.image = page.story.artwork  //Shows first image/artwork inside of an image view for the first page in our story
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    ///Creating Views Progammatically
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        //Add artworkView as a subview of our main view.  Same as dragging UIImageView in IB
        view.addSubview(artworkView)
        //Turn off iOS's automatic constraint view so we can add our own constraints
        artworkView.translatesAutoresizingMaskIntoConstraints = false
        
        
        ///Set constraints by pinning artwork anchors to subview to main view anchors
        NSLayoutConstraint.activate([
            artworkView.topAnchor.constraint(equalTo: view.topAnchor),
            artworkView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            artworkView.rightAnchor.constraint(equalTo: view.rightAnchor),
            artworkView.leftAnchor.constraint(equalTo: view.leftAnchor)
            ])
    }
    

}
