//
//  ProductDetailPageView.swift
//  MiniMart
//
//  Created by Xiangyu Qin on 2021/08/17.
//

import SwiftUI

struct ProductDetailPageView: View {
    @EnvironmentObject var cartState: CartState
    var product: FetchProductsQuery.Data.Product
    var body: some View {
          RemoteImage(urlString: product.imageUrl)
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity)
            VStack(alignment: .leading) {
                Text(product.name)
                Spacer()
                    .frame(height: 8)
                Text("\(product.price)円")
                Spacer()
                Text(product.summary)
                Spacer()
                Button("カートに追加", action: {
                    cartState.addProduct(newProduct: product)
                })
                .frame(maxWidth: .infinity, maxHeight: 50, alignment: .center)
                    .background(Color.orange)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                .padding()
            }
            .listStyle(PlainListStyle())
            .toolbar {
               ToolbarItemGroup(placement: .navigationBarTrailing) {
                VStack{
                    Button(action: {
                        cartState.isCartViewPresented = true
                    }) {
                            Image(systemName: "folder")
                    }
                    Text("\(cartState.totalProduct)")
                }
               }
            }
            .sheet(isPresented: $cartState.isCartViewPresented) {
                CartPageView()
                    .environmentObject(self.cartState)
           }
    }
}
