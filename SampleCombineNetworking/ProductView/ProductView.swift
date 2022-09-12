//
//  ProductView.swift
//  SampleCombineNetworking
//
//  Created by Sajjad Sarkoobi on 3.09.2022.
//

import SwiftUI

struct ProductView: View {
    
    @ObservedObject var viewModel: ProductViewModel = ProductViewModel()
    @State var presentAlert: Bool = false
    @State var newProduct: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    
                    HStack {
                        TextField("Add product", text: $newProduct)
                            .textFieldStyle(.plain)
                        Button("Add") {
                            viewModel.addProduct(productName: newProduct)
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                    
                    List(viewModel.products, id: \.self) { product in
                        Label("\(product.title)", systemImage: "rays")
                    }
                }
            }
            .navigationTitle("Products")
        }
        .alert("Product Added", isPresented: $presentAlert, actions: {
            Button("OK", role: .cancel) { }
        })
        .onChange(of: viewModel.productAdded, perform: { newValue in
                presentAlert.toggle()
        })
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            viewModel.getProducts()
        }
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView()
    }
}
