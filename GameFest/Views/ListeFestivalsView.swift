//
//  ListeFestivalsView.swift
//  GameFest
//
//  Created by Paul Merceur on 26/03/2023.
//

import Foundation
import SwiftUI

struct ListeFestivalsView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @StateObject private var viewModel: ListeFestivalsViewModel
    
    init(benevole: BenevoleModel) {
        self._viewModel = StateObject(wrappedValue: ListeFestivalsViewModel(benevole: benevole))
    }
    
    var body: some View {
        VStack {
            Spacer().frame(height: 20)
            Text("Liste des Festivals")
                .font(.title)
                .fontWeight(.bold)
            List(viewModel.festivals) { festival in
                if viewModel.benevole.isAdmin {
                    NavigationLink(destination: AdminDashboardView(festival: festival)) {
                        VStack(alignment: .leading) {
                            Text(festival.nom)
                                .font(.headline)
                            HStack {
                                Text("Du \(festival.dateDebut) au \(festival.dateFin)")
                                    .font(.subheadline)
                            }
                        }
                    }
                } else {
                    NavigationLink(destination: BenevoleDashboardView(benevole: viewModel.benevole, festival: festival)) {
                        VStack(alignment: .leading) {
                            Text(festival.nom)
                                .font(.headline)
                            HStack {
                                Text("Du \(festival.dateDebut) au \(festival.dateFin)")
                                    .font(.subheadline)
                            }
                        }
                    }
                }
            }.onAppear{self.viewModel.objectWillChange.send()}
            
            // Créer un festival
            if viewModel.benevole.isAdmin {
                NavigationLink(destination: CreateFestivalView(listeFestivals: self.viewModel)) {
                    Text("Ajouter un festival")
                        .fontWeight(.semibold)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }
            }
            
            // Déconnexion
            Button(action: viewModel.logout) {
                Text("Déconnexion")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
            NavigationLink("", destination: LoginView(), isActive: $viewModel.isLoggedOut)
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .background(Color.adaptiveBackground(colorScheme: colorScheme))
    }

    
}
