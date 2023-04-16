//
//  Home.swift
//  FurnitureStore
//
//  Created by İbrahim Güler on 30.05.2022.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject var appModel : AppViewModel
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
                        
                        TextField("Search", text: $appModel.searchText)
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
                                appModel.sortByPrice(isAscending: true)
                            } label: {
                                Text("Sort by Price (Ascending)")
                            }
                            
                            Button {
                                appModel.sortByPrice(isAscending: false)
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
                
                ForEach(appModel.searchProducts.isEmpty ? appModel.products : appModel.searchProducts) { products in
                    CardView(products: products)
                }
                
            }
            .padding()
            .padding(.bottom, 100)
        }
        .onChange(of: appModel.currentMenu) { newValue in
            appModel.updateMenu(newValue: newValue)
        }
        .onChange(of: appModel.searchText) { newValue in
            if(newValue.isEmpty) {
                appModel.updateMenu(newValue: .all)
            } else {
                appModel.searchFromProducts()
            }
        }
    }
    
    @ViewBuilder
    func CardView(products: Products) -> some View {
        HStack(spacing: 12) {
            
             Group {
                 if appModel.currentActiveItem?.product_id == products.product_id && appModel.showDetailView{
                     Images(products: products)
                         .opacity(0)
                 } else {
                     Images(products: products)
                         .matchedGeometryEffect(id: products.product_id + "IMAGE", in: animation)
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
                    if appModel.currentActiveItem?.product_id == products.product_id && appModel.showDetailView {
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
                            .matchedGeometryEffect(id: products.product_id + "TITLE", in: animation)
                        
                        Text("by Guler Home")
                            .font(.caption2.bold())
                            .foregroundColor(.gray)
                            .matchedGeometryEffect(id: products.product_id + "SUBTITLE", in: animation)
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
                appModel.currentActiveItem = products
                appModel.showDetailView = true
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
                    .foregroundColor(appModel.currentMenu != menu ? black : .white)
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
                    .background {
                        if appModel.currentMenu == menu {
                            Capsule()
                                .fill()
                                .shadow(color: black.opacity(0.1), radius: 5, x: 5, y: 5)
                                .matchedGeometryEffect(id: "MENU", in: animation)
                        }
                    }
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            appModel.currentMenu = menu
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
