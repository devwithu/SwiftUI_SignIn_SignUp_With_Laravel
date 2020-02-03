//
//  ApiService.swift
//  Demo
//
//  Created by jdj on 2020/01/31.
//  Copyright © 2020 mac-00018. All rights reserved.
//

import Foundation
import Alamofire

class ApiService {
    func getAllCategories(completion: @escaping ([Category])->()){
        AF.request("https://dev.jdj.kr/api/categories").responseJSON {response in
            guard let data = response.data else {return}
            do{
                guard let categories = try? JSONDecoder().decode([Category].self, from: data) else {return}
                completion(categories)
            }
       }
    }
}
