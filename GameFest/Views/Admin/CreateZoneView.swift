//
//  CreateZoneView.swift
//  GameFest
//
//  Created by Paul Merceur on 01/04/2023.
//

import Foundation
import SwiftUI

struct CreateZoneView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel: CreateZoneViewModel
    
    init(festival: FestivalModel) {
        self._viewModel = StateObject(wrappedValue: CreateZoneViewModel(festival: festival))
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer().frame(height: 30)
            
            Group {
                Text("Nom")
                    .font(.headline)
                TextField("Nom de la zone", text: $viewModel.nom)
                   .font(.body)
                   .padding(.all, 10)
                   .background(Color(UIColor.systemGray6))
                   .cornerRadius(5)
            }
            Spacer().frame(height: 30)
            
            Group {
                Text("Nombre de bénévoles nécessaires")
                    .font(.headline)
                Stepper("Nombre Bénévoles: \(viewModel.nbBenevolesMin)", value: $viewModel.nbBenevolesMin)
            }
            Spacer().frame(height: 30)
            
            
            Spacer()
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
                self.viewModel.createZone()
            }) {
                Text("Valider")
                    .fontWeight(.semibold)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
            }
        }
        .padding()
        .navigationBarTitle("Créer un festival", displayMode: .inline)
    }
}
