//
//  DetailView.swift
//  FurnitureStore
//
//  Created by İbrahim Güler on 30.05.2022.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var appModel : AppViewModel
    
    var products : Products
    var animation : Namespace.ID
    
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            
            VStack {
                HStack {
                    Button {
                        withAnimation(.easeInOut) {
                            appModel.showDetailContent = false
                        }
                        
                        withAnimation(.easeInOut.delay(0.05)) {
                            appModel.showDetailView = false
                        }
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color("Black"))
                            .padding(12)
                            .background {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(Color("BG"))
                            }
                    }
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "suit.heart.fill")
                            .foregroundColor(Color.red)
                            .padding(12)
                            .background {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(Color("BG"))
                            }
                    }
                    
                }
                .padding()
                .opacity(appModel.showDetailContent ? 1 : 0)
                
                Images(products: products)
                    .matchedGeometryEffect(id: products.product_id + "IMAGE", in: animation)
                    .frame(height: size.height / 3)
                
                
                
                VStack(alignment: .leading) {
                    HStack(spacing: 10) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(products.title)
                                .font(.title.bold())
                                .foregroundColor(Color("Black"))
                                .matchedGeometryEffect(id: products.product_id + "TITLE", in: animation)
                  
                            
                            Text("by Guler Home")
                                .font(.caption2)
                                .bold()
                                .foregroundColor(.gray)
                                .matchedGeometryEffect(id: products.product_id + "SUBTITLE", in: animation)
                        }
                        .frame(alignment: .leading)
                        
                        Label {
                            Text("4.7")
                                .font(.callout)
                                .fontWeight(.bold)
                        } icon: {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                        }
                        .padding(.horizontal, 15)
                        .padding(.vertical, 10)
                        .background {
                            Capsule()
                                .strokeBorder(Color("Black").opacity(0.2), lineWidth: 1)
                        }
                        .scaleEffect(0.8)
                        
                    }
                    
                    Text("Crafted with a perfect construction by Seto Febriant and have a balancing ergonomic for humans body, top quality leather in the back of the rest.")
                        .font(.callout)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                        .padding(.vertical)
                    
                    HStack(spacing: 10) {
                        
                        HStack(spacing: 10) {
                            Image(systemName: "minus")
                                .onTapGesture {
                                    if appModel.cartCount > 0 { appModel.cartCount -= 1 }
                                }
                            
                            Text("\(appModel.cartCount)")
                            
                            Image(systemName: "plus")
                                .onTapGesture {
                                    appModel.cartCount += 1
                                }
                        }
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Color("Black"))
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background {
                            Capsule()
                                .fill(Color("Black").opacity(0.1))
                        }
                    }
                    
                    Spacer(minLength: 5)
                    
                    Rectangle()
                        .fill(Color("Black").opacity(0.1))
                        .frame(height: 1)
                    
                    HStack {
                        Text("$\(products.price.rounded(toPlaces: 2))")
                            .font(.largeTitle.bold())
                            .foregroundColor(Color("Black"))
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Text("Buy Now")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .padding(.horizontal, 30)
                                .background {
                                    Capsule()
                                        .fill(Color("Orange"))
                                }
                        }
                        
                    }
                    .padding(.bottom, 5)
                }
                .padding(.top, 35)
                .padding(.horizontal)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .background {
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                        .fill(Color("BG"))
                        .ignoresSafeArea()
                }
                .opacity(appModel.showDetailView ? 1 : 0)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        .background {
            Color.white
                .ignoresSafeArea()
                .opacity(appModel.showDetailContent ? 1 : 0)
        }
        .onAppear {
            withAnimation(.easeInOut) {
                appModel.showDetailContent = true
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
