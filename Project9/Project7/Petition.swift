//
//  Petition.swift
//  Project7
//
//  Created by Saurabh Deshpande on 8/22/20.
//  Copyright © 2020 Saurabh Deshpande. All rights reserved.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
