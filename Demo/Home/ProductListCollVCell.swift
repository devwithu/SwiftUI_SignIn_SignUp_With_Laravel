//
//  ProductListCollVCell.swift
//  SwiftUIWorkingDemo
//
//  Created by mac-00015 on 19/10/19.
//  Copyright © 2019 mac-00015. All rights reserved.
//

import SwiftUI

struct ProductListCollVCell: View {
    
    var category: Category
    
    var body: some View {

        ZStack {
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color.red)
                .frame(width: 80, height: 80)
                
            Text(category.title)
                    .foregroundColor(.white)
        }


    }
}

//struct ProductListCollVCell_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductListCollVCell(product: Product(name: "First Product", imageName: "bird"))
//            .previewLayout(.fixed(width: (UIScreen.main.bounds.width * 200) / 414, height: (UIScreen.main.bounds.width * 200) / 414))
//    }
//}

struct ProductListRedirection: View {
    
    var product: Product
    
    var body: some View {
        
        switch product.name {
        case "First Product":
            return AnyView(CurrentOrderVC())
        case "Second Product":
            return AnyView(NotificationVC())
        case "Third Product":
            return AnyView(FavouritesVC())
        default:
            return AnyView(Text(product.name))
        }
    }
}
