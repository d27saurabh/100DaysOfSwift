//
//  Image.swift
//  Project1
//
//  Created by Saurabh Deshpande on 9/16/20.
//  Copyright © 2020 Saurabh Deshpande. All rights reserved.
//

import UIKit

class Image: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
