//
//  ProfileViewModel.swift
//  FurnitureStore
//
//  Created by İbrahim Güler on 6.05.2023.
//

import SwiftUI
import Firebase

class ProfileViewModel: ObservableObject {
    let auth = Auth.auth()
    @Published var email = ""
    @Published var password = ""
    @Published var isFocused = false
    @Published var showAlert = false
    @Published var alertMessage = "Something went wrong."
    
    @Published var isLoading : Bool = false
    
    @Published var offsetLogin : Double = 1000
    @Published var isLogged : Bool = UserDefaults.standard.bool(forKey: "isLogged")
    
    func login() {
        
        self.isFocused = false
        self.isLoading = true
        auth.signIn(withEmail: email, password: password) { Result, error in
            
            
            if error != nil {
                self.alertMessage = error?.localizedDescription ?? ""
                self.showAlert = true
                self.isLoading = false
            } else {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    
                    self.email = ""
                    self.password = ""
                    self.isLoading = false
                    self.offsetLogin = 1000
                    
                    self.isLogged = true
                    UserDefaults.standard.set(true, forKey: "isLogged")
                }
            }
        }
    }
    
    func logOut() {
        self.isLoading = true
        do {
            try auth.signOut()
            auth.checkActionCode("exit") { action, error in
                self.isLoading = false
                self.isLogged = false
                UserDefaults.standard.set(false, forKey: "isLogged")
            }
        } catch {
            self.alertMessage = "Hata"
            self.showAlert = true
        }
    }
}
