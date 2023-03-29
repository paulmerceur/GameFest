//
//  ModifierDisponibilitesView.swift
//  GameFest
//
//  Created by Paul Merceur on 24/03/2023.
//

import Foundation
import SwiftUI

struct ModifierDisponibilitesView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var viewModel: ModifierDisponibilitesViewModel
    
    init(benevole: BenevoleModel) {
        self.viewModel = ModifierDisponibilitesViewModel(benevole: benevole)
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.affectationsVM.affectations, id: \.id) { affectation in
                    HStack {
                        Text(affectation.creneau.date)
                            .font(.subheadline)
                        Spacer()
                        Text(affectation.creneau.horaires)
                            .font(.subheadline)
                        Spacer()
                        if (affectation.isDispo) {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        affectation.isDispo = !affectation.isDispo
                    }
                }
            }

            // Bouton Valider
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Valider")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
            }
            .padding(.leading)
            .padding(.top)
            Spacer()
        }
        .background(Color.adaptiveBackground(colorScheme: colorScheme))
        .navigationBarTitle("Modifier mes Disponibilités", displayMode: .inline)
    }
}
