//
//  Genre.swift
//  MovieDict
//
//  Created by Kevin Tanuhardi on 04/07/21.
//

import Foundation
import SwiftyJSON

struct Genre {
    
    let id: Int
    let name: String
    
    init(_ json: JSON) {
        id = json["id"].intValue
        name = json["name"].stringValue
    }
}
