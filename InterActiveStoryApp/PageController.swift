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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
