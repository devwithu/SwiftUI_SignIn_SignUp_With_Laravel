//
//  Response.swift
//  Demo
//
//  Created by jdj on 2020/01/28.
//  Copyright © 2020 mac-00018. All rights reserved.
//

import Foundation


struct LoginResponse: Decodable {
    var access_token: String
    var token_type: String
    var expires_in: Int
}


