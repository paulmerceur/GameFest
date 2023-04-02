//
//  ModifierZoneView.swift
//  GameFest
//
//  Created by Paul Merceur on 01/04/2023.
//

import Foundation
import SwiftUI

struct ModifierZoneView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme

    @ObservedObject var viewModel: ModifierZoneViewModel

    init(zone: Zone) {
        self.viewModel = ModifierZoneViewModel(zone:zone)
    }

    var body: some View {
        VStack {
            Text(viewModel.zone.nom)
                .font(.title)
                .padding()
            
            Stepper("Bénévoles nécessaires: \(viewModel.nbBenevolesMin)", value: $viewModel.nbBenevolesMin)

            List(viewModel.affectations) { affectation in
                HStack {
                    Text(String(affectation.benevole.prenom) + " " + String(affectation.benevole.nom))
                }
                .contentShape(Rectangle())
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
                    viewModel.updateNbBenevolesMin()
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
        .navigationBarTitle("Modifier Zone", displayMode: .inline)
    }
}
