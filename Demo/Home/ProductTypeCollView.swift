//
//  ProductTypeCollView.swift
//  SwiftUIWorkingDemo
//
//  Created by mac-00015 on 19/10/19.
//  Copyright © 2019 mac-00015. All rights reserved.
//

import SwiftUI
import WaterfallGrid

struct ProductTypeCollView: View {
    
    @ObservedObject var model = CategoryListViewModel()
    
    var body: some View {
        
//        ScrollView(.horizontal, showsIndicators: false) {
//
//            HStack {
//
//                ForEach(self.model.categories, id: \.self) { category -> Text in
//                    print(self.model.categories.count)
//                    //return ProductTypeCollVCell()
//                    return Text(category.title)
//                }
//            }
//        }
//        List(model.categories) { item in
//            Text("aa")
//
//        }
        WaterfallGrid((0..<10), id: \.self) { index in
          Image("bird")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: (UIScreen.main.bounds.width * 105) / 414, height: (UIScreen.main.bounds.width * 105) / 414)
            .cornerRadius(10)

        }
        
    }
}

struct ProductTypeCollView_Previews: PreviewProvider {
    static var previews: some View {
        ProductTypeCollView()
    }
}
