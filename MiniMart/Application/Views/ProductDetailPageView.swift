//
//  ProductDetailPageView.swift
//  MiniMart
//
//  Created by Xiangyu Qin on 2021/08/17.
//

import SwiftUI

struct ProductDetailPageView: View {
    var product: FetchProductsQuery.Data.Product
    var body: some View {
        NavigationLink(destination: ProductDetailPageView(product: product)) {
            HStack(alignment: .top) {
              RemoteImage(urlString: product.imageUrl)
                .frame(width: 100, height: 100)
                VStack(alignment: .leading) {
                   Text(product.name)
                    Spacer()
                        .frame(height: 8)
                   Text(product.summary)
                    Spacer()
                   Text("\(product.price)円")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(.vertical, 8)
            }
        }
        .onAppear {
            Network.shared.apollo.fetch(query: FetchProductsQuery()) { result in
               switch result {
               case let .success(graphqlResult):
                   self.products = graphqlResult.data?.products ?? []
               case .failure:
                   break
               }
            }
        }
    }
}

struct ProductDetailPageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProductDetailPageView(
                product: FetchProductsQuery.Data.Product(
                    id: UUID().uuidString,
                    name: "商品 \(1)",
                    price: 100,
                    summary: "おいしい食材 \(1)",
                    imageUrl: "https://image.mini-mart.com/dummy/1"
                )
            )
        }
    }
}
