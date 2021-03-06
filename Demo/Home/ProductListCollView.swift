//
//  ProductListCollView.swift
//  SwiftUIWorkingDemo
//
//  Created by mac-00015 on 19/10/19.
//  Copyright © 2019 mac-00015. All rights reserved.
//

import SwiftUI
import WaterfallGrid

struct ProductListCollView: View {
    
    //let arrProduct: [Product]
    @ObservedObject var model = CategoryListViewModel()
    
    var body: some View {
        
//        GridCollection(arrProduct, columns: 2, vSpacing: 20, hSpacing: 10, vPadding: 0, hPadding: 0) {
//            ProductListCollVCell(product: $0)
//        }

//        List(model.categories) { item in
//            Text(item.title)
//
//        }
        
        WaterfallGrid(model.categories) { item in
          ProductListCollVCell(category: item)

        }.gridStyle(columns: 4)
    }
}

//struct ProductListCollView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductListCollView(arrProduct: [Product(name: "First Product", imageName: "bird"),
//        Product(name: "Second Product", imageName: "bird")])
//    }
//}
