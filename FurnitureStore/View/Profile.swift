//
//  Profile.swift
//  FurnitureStore
//
//  Created by İbrahim Güler on 5.05.2023.
//

import SwiftUI

struct Profile: View {
    @EnvironmentObject var profileViewModel : ProfileViewModel
    @Binding var currentTab: Tab
    
    var body: some View {
        VStack {
            
            
            VStack {
                Circle()
                    .stroke(style: .init(lineWidth: 2))
                    .background {
                        Image(systemName: "person")
                            .font(.system(size: 100,weight: .bold, design: .monospaced))
                        
                    }
                    .mask(Circle())
                    .frame(width: 130, height: 130)

                Text("User Name")
            }
            .frame(width: getRect().width)
            .padding(20)
            .background {
                Color("CardBG")
                    .ignoresSafeArea()
            }
            
            Button {
                profileViewModel.logOut()
                currentTab = .home
            } label: {
                Text("log out")
            }

            
            Spacer()
            
            
            
        }
       
        
    }
    
    @ViewBuilder
    func BuyManager() -> some View {
        VStack {
            
        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
