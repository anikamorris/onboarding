//
//  Models.swift
//  onboarding2
//
//  Created by Anika Morris on 2/11/20.
//  Copyright © 2020 Anika Morris. All rights reserved.
//

import Foundation

struct Item {
    let name: String
    let category: String
    let image: String
}

struct Box {
    let date: String
    let items: [Item]
}

enum Category {
    case necklace
    case bracelet
    case earrings
    case rings
    case body
}
