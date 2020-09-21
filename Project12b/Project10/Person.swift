//
//  Person.swift
//  Project10
//
//  Created by Saurabh Deshpande on 9/13/20.
//  Copyright © 2020 Saurabh Deshpande. All rights reserved.
//

import UIKit

class Person: NSObject, Codable {

    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
