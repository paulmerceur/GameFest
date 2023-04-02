//
//  ListeZonesFestivalView.swift
//  GameFest
//
//  Created by Paul Merceur on 01/04/2023.
//

import Foundation
import SwiftUI

struct ListeZonesFestivalView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    
    @StateObject private var viewModel: ListeZonesFestivalViewModel
    
    init(festival: FestivalModel) {
        self._viewModel = StateObject(wrappedValue: ListeZonesFestivalViewModel(festival: festival))
    }
    
    var body: some View {
        VStack {
            Spacer().frame(height: 20)
            Text("\(viewModel.festival.nom)")
                .font(.title)
                .fontWeight(.bold)
            
            List(viewModel.zones.sorted(by: { $0.id < $1.id })) { zone in
                NavigationLink(destination: ModifierZoneView(zone: zone)) {
                    VStack(alignment: .leading) {
                        Text(zone.nom)
                            .font(.headline)
                        Text("Bénévoles nécessaires: \(zone.nbBenevolesMin)")
                    }
                }
                
            }.onAppear{self.viewModel.objectWillChange.send()}
            
            NavigationLink(destination: CreateZoneView(festival: viewModel.festival)) {
                Text("Ajouter une zone")
                    .fontWeight(.semibold)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .background(Color.adaptiveBackground(colorScheme: colorScheme))
    }
}
