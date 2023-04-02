//
//  ListeBenevolesFestivalView.swift
//  GameFest
//
//  Created by Paul Merceur on 01/04/2023.
//

import Foundation
import SwiftUI

struct ListeBenevolesFestivalView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    
    @StateObject private var viewModel: ListeBenevolesFestivalViewModel
    
    init(festival: FestivalModel) {
        self._viewModel = StateObject(wrappedValue: ListeBenevolesFestivalViewModel(festival: festival))
    }
    
    var body: some View {
        VStack {
            Spacer().frame(height: 20)
            Text("\(viewModel.festival.nom)")
                .font(.title)
                .fontWeight(.bold)
            List(viewModel.benevoles) { benevole in
                HStack {
                    Text("\(benevole.prenom) \(benevole.nom)")
                }
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .background(Color.adaptiveBackground(colorScheme: colorScheme))
    }
}
