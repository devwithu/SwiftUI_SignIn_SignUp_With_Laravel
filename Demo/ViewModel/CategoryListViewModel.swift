//
//  CategoryListViewModel.swift
//  Demo
//
//  Created by jdj on 2020/01/31.
//  Copyright © 2020 mac-00018. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class CategoryListViewModel: ObservableObject {
    
    init() {
        fetchCategories()
    }
    
    @Published var categories = [Category]() {
        didSet {
            didChange.send(self)
        }
    }
    
    private func fetchCategories() {
        ApiService().getAllCategories {
            self.categories = $0
        }
    }
    let didChange = PassthroughSubject<CategoryListViewModel, Never>()
}
