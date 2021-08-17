//
//  CartPageView.swift
//  MiniMart
//
//  Created by Xiangyu Qin on 2021/08/17.
//

import SwiftUI

struct CartPageView: View {
    @EnvironmentObject var cartState: CartState
    @State private var showAlert = false
    var body: some View {
        VStack (alignment: .leading) {
            List(cartState.products, id: \.id) {product in
                HStack(alignment: .top) {
                  RemoteImage(urlString: product.imageUrl)
                    .frame(width: 100, height: 100)
                    VStack(alignment: .leading) {
                       Text(product.name)
                       Text("\(product.price)円")
                        Text("\(cartState.numProduct[product.id]!)個")
                    }
                }
            }
            Text("合計: \(cartState.totalPrice)円")
                .frame(maxWidth: .infinity, alignment: .trailing)
            Button("注文する", action: {
                showAlert = true
            })
            .frame(maxWidth: .infinity, maxHeight: 50, alignment: .center)
                .background(Color.orange)
                .foregroundColor(Color.white)
                .cornerRadius(10)
            .padding()
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("注文しました"),
                dismissButton: Alert.Button.default(Text("ラジャりました"), action: {
                    cartState.clear()
                    cartState.isCartViewPresented = false
                })
            )
        }
        .navigationTitle("カート")
    }
}
