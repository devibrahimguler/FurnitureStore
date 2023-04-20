//
//  Store.swift
//  FurnitureStore
//
//  Created by İbrahim Güler on 17.04.2023.
//

import SwiftUI

struct Cart: View {
    @EnvironmentObject var cartViewModel : CartViewModel
    let black : Color = Color("Black")
    
    var body: some View {
        VStack {
            HStack {
                
                Text("Store")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("Black"))
                
                Spacer(minLength: 10)

                
            }
            .padding(.horizontal, 30)
            .padding(.vertical,10)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    if cartViewModel.store.isEmpty {
                        VStack {
                            Text("You have not any product in cart!")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(Color("Orange"))
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .padding(10)
                    } else {
                        ForEach(cartViewModel.store) { store in
                            StoreCardView(store: store)
                                .padding(10)
                        }
                    }
                    
                    VStack {
                        VStack {
                            HStack {
                                Text("Subtotal : ")
                                Spacer(minLength: 10)
                                Text("$\(cartViewModel.subTotalPrice.rounded(toPlaces: 2))")
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 5)
                            
                            HStack {
                                Text("Shipping : ")
                                Spacer(minLength: 10)
                                Text("$100.00")
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 5)
                            
                            HStack {
                                Text("Estimated Tax : ")
                                Spacer(minLength: 10)
                                Text("$\(cartViewModel.tax.rounded(toPlaces: 2))")
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 5)
                            
                            Divider()
                                .padding(.vertical, 5)
                            
                            HStack {
                                Text("Total")
                                Spacer(minLength: 10)
                                Text("$\(cartViewModel.totalPrice.rounded(toPlaces: 2))")
                            }
                            .foregroundColor(Color("Orange"))
                            .padding(.horizontal, 20)
                            .padding(.vertical, 5)
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .bottom)
                        .padding(10)
                        .background {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color("CardBG"))
                                
                        }
                        
                        Button {
                            
                        } label: {
                            Text("Checkout")
                                .frame(maxWidth: .infinity)
                                .foregroundColor(Color("BG"))
                                .padding(.vertical , 10)
                                .background {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color("Orange"))
                                }
                                .padding(.horizontal, 30)
                        }
                        .padding(.bottom,100)
                    }
 
                }
            }
            
        }
    }
    
    @ViewBuilder
    func StoreCardView(store: Store) -> some View {
        HStack(spacing: 12) {
            
            Images(products: store.products)
             .frame(width: 100)
             .padding()
             .background {
                 RoundedRectangle(cornerRadius: 20, style: .continuous)
                     .fill(.white)
             }
             
            
            VStack(alignment: .leading, spacing: 10) {
                
                Text(store.products.title)
                    .lineLimit(2)
                    .foregroundColor(black)
                
                Text("by Guler Home")
                    .font(.caption2.bold())
                    .foregroundColor(.gray)
                    .padding(.top, -5)
                
                HStack {
                    VStack(alignment: .leading,spacing: 10) {
                        HStack(spacing: 0) {
                            Text("Unit : ")
                                .foregroundColor(Color("Black"))
                            Text("$\(store.products.price.rounded(toPlaces: 2))")
                        }
                       
               
                        HStack(spacing: 0) {
                            Text("Total : ")
                                .foregroundColor(Color("Black"))
                            Text("$\((store.products.price * Double(store.count)).rounded(toPlaces: 2))")
                        }
                       
    
                    }
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(Color("Orange"))
                    
                    Spacer(minLength: 10)
                    
                    HStack(spacing: 10) {
                        Image(systemName: "minus")
                            .onTapGesture {
                                if store.count > 1 {
                                    cartViewModel.appendStore(products: store.products, count: -1)
                                }
                            }
                        
                        Text("\(store.count)")
                        
                        Image(systemName: "plus")
                            .onTapGesture {
                                cartViewModel.appendStore(products: store.products, count: +1)
                            }
                    }
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(Color("Black"))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background {
                        Capsule()
                            .fill(Color("Black").opacity(0.1))
                    }
                    
                    
                }
                .offset(y: 10)
            }
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .padding(10)
        .background {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color("CardBG"))
                .shadow(color: black.opacity(0.08), radius: 5, x: 5, y: 5)
        }
        .padding(.bottom, 6)
    }
    
}

struct Cart_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
