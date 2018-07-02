//
//  page.swift
//  InterActiveStoryApp
//
//  Created by Jordan Leahy on 6/27/18.
//  Copyright © 2018 Jordan Leahy. All rights reserved.
//

import Foundation

class Page {
    let story: Story
    
    // MARK: 
    
    typealias Choice = (title: String, page: Page)
    
    var firstChoice: Choice?
    var secondChoice: Choice?
    
    init(story: Story) {
        self.story = story
    }

}

extension Page {
    
    //MARK: - Helper Methodss
    
    /// Inside the body of this method, we'll use the story that we're passing in to create a page, and initialize it with a story and then simply call through to func addChoiceWith(title: String, page: Page) -> Page to do all the work.
    func addChoiceWith(title: String, story: Story) -> Page {
        let page = Page(story: story)
        return addChoiceWith(title: title, page: page)
    }
    
    ///Method to take title and page as a parameter and add Choice to a page instance.  A switch statement can switch on multiple values by compounding them into a tuple.
    func addChoiceWith(title: String, page: Page) -> Page {
        switch (firstChoice, secondChoice) {
        case (.some, .some): break // or we could put return self instead of break
        case (.none, .none), (.none, .some): firstChoice = (title, page)
        case (.some, .none): secondChoice = (title, page)
        
        }
       
        return page
    }
}

///Wrapper to construct a story.  Use this wrapper struct object to initialize the ViewController. 
struct Adventure {
    static var story: Page {
        let returnTrip = Page(story: .returnTrip)
        let touchdown = returnTrip.addChoiceWith(title: "Stop and Investigate", story: .touchDown)
        let homeward = returnTrip.addChoiceWith(title: "Continue home to Earth", story: .homeward)
        let rover = touchdown.addChoiceWith(title: "Explore the Rover", story: .rover)
        let crate = touchdown.addChoiceWith(title: "Open the Crate", story: .crate)
        
        homeward.addChoiceWith(title: "Head back to Mars", page: touchdown)
        let home = homeward.addChoiceWith(title: "Continue Home to Earth", story: .home)
        
        let cave = rover.addChoiceWith(title: "Explore the Coordinates", story: .cave)
        rover.addChoiceWith(title: "Return to Earth", page: home)
        
        cave.addChoiceWith(title: "Continue towards faint light", story: .droid)
        cave.addChoiceWith(title: "Refill the ship and explore the rover", page: rover)
        
        crate.addChoiceWith(title: "Explore the Rover", page: rover)
        crate.addChoiceWith(title: "Use the key", story: .monster)
        
        return returnTrip
    }
}

