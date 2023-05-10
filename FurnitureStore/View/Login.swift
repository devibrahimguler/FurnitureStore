//
//  Login.swift
//  FurnitureStore
//
//  Created by İbrahim Güler on 5.05.2023.
//

import SwiftUI

struct Login: View {
    @EnvironmentObject var homeViewModel : HomeViewModel
    @EnvironmentObject var profileViewModel : ProfileViewModel
    
    private let black : Color = Color("Black")
    private let cardBG : Color = Color("CardBG")
    private let bG : Color = Color("BG")
    var body: some View {
        VStack(alignment: .leading) {
            Button {
                profileViewModel.offsetLogin = 1000
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(black)
                    .frame(width: 44, height: 44)
                    .background(bG)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
                    .padding(.leading, 30)
            }
            
            VStack{
                
                Spacer(minLength: 10)
                
                Text("Guler Home")
                    .foregroundColor(black)
                    .font(.system(size: 40,weight: .bold, design: .rounded))
                    .frame( width: getRect().width, alignment: .center)
                
                
                
            }
            
            VStack{
                VStack {
                    
                    HStack {
                        Image(systemName: "person.crop.circle.fill")
                            .foregroundColor(black)
                            .frame(width: 44, height: 44)
                            .background(bG)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .shadow(color: black.opacity(0.15), radius: 5, x: 0, y: 5)
                            .padding(.leading)
                        
                        TextField("Your Email".uppercased(), text: $profileViewModel.email)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                            .font(.subheadline)
                            .padding(.leading)
                            .frame(height: 44)
                            .onTapGesture {
                                profileViewModel.isFocused = true
                            }
                    }
                    
                    Divider().padding(.leading, 80)
                    
                    HStack {
                        Image(systemName: "lock.fill")
                            .foregroundColor(black)
                            .frame(width: 44, height: 44)
                            .background(bG)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .shadow(color: black.opacity(0.15), radius: 5, x: 0, y: 5)
                            .padding(.leading)
                        
                        SecureField("Password".uppercased(), text: $profileViewModel.password)
                            .keyboardType(.default)
                            .font(.subheadline)
                            .padding(.leading)
                            .frame(height: 44)
                            .onTapGesture {
                                profileViewModel.isFocused = true
                            }
                    }
                }
                .frame(height: 136)
                .frame(maxWidth: 712)
                .background(cardBG)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: Color.black.opacity(0.15), radius: 20, x: 0, y: 20)
                .padding()
                
                HStack {
                    Text("Forgot password ?")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    Button(action: {
                        profileViewModel.login()
                    }) {
                        Text("Log in")
                            .foregroundColor(black)
                    }
                    .padding(12)
                    .padding(.horizontal, 30)
                    .background(bG)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .shadow(color: black.opacity(0.15), radius: 20, x: 0, y: 20)
                }
                .padding(.horizontal, 30)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .padding()
            
        }
        .offset(y: profileViewModel.isFocused ? -300 : 0)
        .animation(.easeInOut, value: profileViewModel.isFocused)
        .background(bG)
        .onTapGesture {
            profileViewModel.isFocused = false
            
        }
        .background()
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}
