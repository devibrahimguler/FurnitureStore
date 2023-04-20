//
//  Favorite.swift
//  FurnitureStore
//
//  Created by İbrahim Güler on 18.04.2023.
//

import SwiftUI

struct Favourite: View {
    @EnvironmentObject var homeViewModel : HomeViewModel
    @EnvironmentObject var cartViewModel : CartViewModel
    
    var animation : Namespace.ID
    let black : Color = Color("Black")
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 15) {
                
                Text("Favourite")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if  homeViewModel.favourite.isEmpty {
                   
                } else {
                    ForEach(homeViewModel.favourite) { products in
                        CardView(products: products)
                    }
                }
                
            }
            .padding()
            .padding(.bottom, 100)
        }
    }
    
    @ViewBuilder
    func CardView(products: Products) -> some View {
        HStack(spacing: 12) {
            
             Group {
                 if homeViewModel.currentActiveItem?.id == products.id && homeViewModel.showDetailView{
                     Images(products: products)
                         .opacity(0)
                 } else {
                     Images(products: products)
                         .matchedGeometryEffect(id: "\(products.id)IMAGE", in: animation)
                 }
             }
             .frame(width: 120)
             .padding()
             .background {
                 RoundedRectangle(cornerRadius: 20, style: .continuous)
                     .fill(.white)
             }
             
            
            VStack(alignment: .leading, spacing: 10) {
                
                Group {
                    if homeViewModel.currentActiveItem?.id == products.id && homeViewModel.showDetailView {
                        Text(products.title)
                            .lineLimit(2)
                            .foregroundColor(black)
                            .opacity(0)
                        
                        Text("by Guler Home")
                            .font(.caption2.bold())
                            .foregroundColor(.gray)
                            .padding(.top, -5)
                            .opacity(0)
                    } else {
                        Text(products.title)
                            .lineLimit(2)
                            .foregroundColor(black)
                            .matchedGeometryEffect(id: "\(products.id)TITLE", in: animation)
                        
                        Text("by Guler Home")
                            .font(.caption2.bold())
                            .foregroundColor(.gray)
                            .matchedGeometryEffect(id: "\(products.id)SUBTITLE", in: animation)
                            .padding(.top, -5)
                    }
                }
                
                Text("\(products.model_number)")
                    .font(.system(size: 14))
                    .foregroundColor(black.opacity(0.8))
                
                HStack {
                    Text("$\(products.price.rounded(toPlaces: 2))")
                        .font(.title3.bold())
                        .foregroundColor(black)
                    
                    Spacer()
                    
                    Button {
                        withAnimation(.easeInOut) {
                            cartViewModel.appendStore(products: products, count: 1)
                            cartViewModel.showAlert = true
                        }
                    } label: {
                        Text("Buy")
                            .font(.callout)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 20)
                            .background {
                                Capsule()
                                    .fill(Color("Orange"))
                            }
                    }
                    .scaleEffect(0.9)
                    
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
        .onTapGesture(perform: {
            withAnimation(.easeInOut) {
                homeViewModel.currentActiveItem = products
                homeViewModel.showDetailView = true
            }
        })
        .padding(.bottom, 6)
    }
    
}

struct Favourite_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
