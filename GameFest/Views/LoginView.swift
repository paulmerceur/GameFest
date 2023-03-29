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
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer().frame(height: 100)
                
                Text("Connexion")
                    .font(.largeTitle)
                    .padding(.top)
                
                TextField("Email", text: $viewModel.email)
                    .autocapitalization(.none)
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
                
                // Rediriger vers Créer un compte<
                NavigationLink(destination: SignUpView()) {
                    Text("Créer un compte")
                        .foregroundColor(Color(red: 0, green: 0.35, blue: 0.6))
                }
                
                // Display error message
                Text(viewModel.errorMessage)
                    .foregroundColor(.red)
                    .padding()
                
                Spacer()
                
                NavigationLink("", destination: ListeFestivalsView(benevole: viewModel.benevole), isActive: $viewModel.isLoggedIn)
                    .hidden()
            }
        }
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }

    
//    struct LoginView_Previews: PreviewProvider {
//        static var previews: some View {
//            LoginView()
//        }
//    }
}
