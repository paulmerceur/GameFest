//
//  ModifierAffectationView.swift
//  GameFest
//
//  Created by Paul Merceur on 24/03/2023.
//

import Foundation
import SwiftUI

struct ModifierAffectationView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme

    @ObservedObject var viewModel: ModifierAffectationViewModel
    @State var zone: String
    
    init(affectation: AffectationViewModel) {
        self.viewModel = ModifierAffectationViewModel(affectation: affectation)
        self._zone = State(initialValue: affectation.zone)
    }

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(viewModel.affectationVM.date)
                    .font(.headline)
                Text(viewModel.affectationVM.creneau)
                    .font(.subheadline)
            }
            .padding()

            List(viewModel.zones, id: \.self) { zone in
                HStack {
                    Text(zone)
                    Spacer()
                    if self.zone == zone {
                        Image(systemName: "checkmark")
                            .foregroundColor(.blue)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    self.zone = zone
                }
            }

            HStack {
                // Bouton Annuler
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Annuler")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.trailing)

                // Bouton Valider
                Button(action: {
                    viewModel.affectationVM.zone = self.zone
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
            }
            .padding(.top)
            Spacer()
        }
        .background(Color.adaptiveBackground(colorScheme: colorScheme))
        .navigationBarTitle("Modifier Affectation", displayMode: .inline)
    }
}


