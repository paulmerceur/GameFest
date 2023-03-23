//
//  ContentView.swift
//  GameFest
//
//  Created by Paul Merceur on 16/03/2023.
//

import Foundation
import SwiftUI

struct LoginView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @StateObject private var viewModel = LoginViewModel()
    
    @State private var isAdmin = false
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer().frame(height: 100)
                
                Text("Connexion")
                    .font(.largeTitle)
                    .padding(.top)
                
                TextField("Email", text: $viewModel.email)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                SecureField("Mot de passe", text: $viewModel.password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                Button(action: {
                    viewModel.login()
                }) {
                    Text("Se connecter")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.adaptiveBlue(colorScheme: colorScheme))
                        .cornerRadius(8)
                }
                .padding()
                
                NavigationLink(destination: SignUpView()) {
                    Text("Créer un compte")
                        .foregroundColor(Color(red: 0, green: 0.35, blue: 0.6))
                }
                
                Spacer()
                
                if viewModel.isAdmin {
                    NavigationLink("", destination: AdminDashboardView(), isActive: $viewModel.isLoggedIn)
                        .hidden()
                } else {
                    NavigationLink("", destination: BenevoleDashboardView(), isActive: $viewModel.isLoggedIn)
                        .hidden()
                }
            }
        }
    }
    
    /*struct LoginView_Previews: PreviewProvider {
        static var previews: some View {
            LoginView()
        }
    }*/
}
