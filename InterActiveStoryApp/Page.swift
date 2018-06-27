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
    
    typealias Choice = (title: String, page: Page)
    
    var firstChoice: Choice?
    var secondChoice: Choice?
    
    init(story: Story) {
        self.story = story
    }

}

extension Page {
    
    /// Inside the body of this method, we'll use the story that we're passing in to create a page, and initialize it with a story and then simply call through to func addChoiceWith(title: String, page: Page) -> Page to do all the work.
    func addChoiceWith(title: String, story: Story) -> Page {
        let page = Page(story: story)
        return addChoiceWith(title: title, page: page)
    }
    
    ///Method to take title and page as a parameter and add choice to a Page instance.  A switch statement can switch on multiple values by compounding them into a tuple.
    func addChoiceWith(title: String, page: Page) -> Page {
        switch (firstChoice, secondChoice) {
        case (.some, .some): break // or we could put return self instead of break
        case (.none, .none), (.none, .some): firstChoice = (title, page)
        case (.some, .none): secondChoice = (title, page)
        
        }
       
        return page
    }
}

