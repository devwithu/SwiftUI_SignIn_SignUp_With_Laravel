//
//  Category.swift
//  Demo
//
//  Created by jdj on 2020/01/31.
//  Copyright © 2020 mac-00018. All rights reserved.
//

import Foundation

struct Category: Identifiable, Hashable, Encodable, Decodable {
    let id: Int
    let title: String
    let body: String
}
