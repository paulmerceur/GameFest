//
//  SignUpView.swift
//  GameFest
//
//  Created by Paul Merceur on 16/03/2023.
//

import Foundation
import SwiftUI

import SwiftUI

struct SignUpView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    
    @StateObject private var viewModel = SignUpViewModel()
    
    @State private var signedUp = false
    @State private var message = ""

    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack {
            Spacer().frame(height: 60)
            
            Text("Inscription")
                .font(.largeTitle)
                .padding(.top)
            
            TextField("Prénom", text: $viewModel.firstName)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)
            
            TextField("Nom", text: $viewModel.lastName)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)
            
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
                presentationMode.wrappedValue.dismiss()
                viewModel.signUp()
            }) {
                Text("S'inscrire")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.adaptiveBlue(colorScheme: colorScheme))
                    .cornerRadius(8)
            }
            .padding()
            
            Spacer()
            
            if viewModel.isSignedUp {
                Text(viewModel.message)
                    .foregroundColor(Color.adaptiveBlue(colorScheme: colorScheme))
                    .multilineTextAlignment(.center)
                    .padding()
            }
        }
    }

}
