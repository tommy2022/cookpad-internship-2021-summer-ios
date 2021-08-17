import Foundation
import Combine

final class CartState: ObservableObject {
    var totalProduct: Int = 0
    var totalPrice: Int = 0
    @Published var products: [FetchProductsQuery.Data.Product] = []
    @Published var numProduct: [String:Int] = [:]
    @Published var isCartViewPresented: Bool = false
    
    func addProduct(newProduct: FetchProductsQuery.Data.Product) {
        let id: String = newProduct.id as String
        let keyExists = numProduct[id] != nil
        if (!keyExists) {
            products.append(newProduct)
        }
        let numItem = keyExists ? numProduct[id]! : 0
        numProduct[id] = numItem + 1
        totalProduct += 1
        totalPrice += newProduct.price
    }
    
    func removeProduct(id: String) {
        let numItem = numProduct[id]!
        if (numItem == 0) {
            // T0D0 remove product from cart
        }
    }
    
    func clear() {
        products = []
        numProduct = [:]
        totalProduct = 0
        totalPrice = 0
    }
}
