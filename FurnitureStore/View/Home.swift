//
//  Home.swift
//  FurnitureStore
//
//  Created by İbrahim Güler on 30.05.2022.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject var homeViewModel : HomeViewModel
    @EnvironmentObject var cartViewModel : CartViewModel
    var animation : Namespace.ID
    let black : Color = Color("Black")
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 15) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Guler Home")
                        .font(.title.bold())
                    
                    Text("Good Design!")
                        .font(.callout)
                }
                .foregroundColor(black)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack(spacing: 12) {
                    HStack(spacing: 12) {
                        Image("Search")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .foregroundColor(black)
                        
                        TextField("Search", text: $homeViewModel.searchText)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 12)
                    .background {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.white)
                    }
                    
                    Menu {
                        VStack {
                            Button {
                                homeViewModel.sortByPrice(isAscending: true)
                            } label: {
                                Text("Sort by Price (Ascending)")
                            }
                            
                            Button {
                                homeViewModel.sortByPrice(isAscending: false)
                            } label: {
                                Text("Sort by Price (Descending)")
                            }

                        }
                    } label: {
                        Image("Filter")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(black)
                            .frame(width: 25, height: 25)
                            .padding(12)
                            .background {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.white)
                            }
                    }
                    
                }
                
                CustomMenu()
                
                ForEach(homeViewModel.searchProducts.isEmpty ? homeViewModel.products : homeViewModel.searchProducts) { products in
                    CardView(products: products)
                }
                
            }
            .padding()
            .padding(.bottom, 100)
        }
        .onChange(of: homeViewModel.currentMenu) { newValue in
            homeViewModel.updateMenu(newValue: newValue)
        }
        .onChange(of: homeViewModel.searchText) { newValue in
            if(newValue.isEmpty) {
                homeViewModel.updateMenu(newValue: .chair)
            } else {
                homeViewModel.searchFromProducts()
            }
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
    
    @ViewBuilder
    func CustomMenu() -> some View {
        HStack(spacing: 0) {
            ForEach(SliderMenu.allCases, id:\.rawValue) { menu in
                Text(menu.rawValue)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundColor(homeViewModel.currentMenu != menu ? black : .white)
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
                    .background {
                        if homeViewModel.currentMenu == menu {
                            Capsule()
                                .fill()
                                .shadow(color: black.opacity(0.1), radius: 5, x: 5, y: 5)
                                .matchedGeometryEffect(id: "MENU", in: animation)
                        }
                    }
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            homeViewModel.currentMenu = menu
                        }
                    }
            }
        }
        .padding(.top, 10)
        .padding(.bottom, 20)
    }
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Double {
    // Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> String {
        let divisor = pow(10.0, Double(places))
        return "\((self * divisor).rounded() / divisor)"
    }
}
