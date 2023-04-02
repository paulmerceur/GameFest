//
//  AdminDashboardView.swift
//  GameFest
//
//  Created by Paul Merceur on 23/03/2023.
//

import Foundation
import SwiftUI

struct AdminDashboardView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    
    @StateObject private var viewModel: AdminDashboardViewModel
    
    init(festival: FestivalModel) {
        self._viewModel = StateObject(wrappedValue: AdminDashboardViewModel(festival: festival))
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                Spacer().frame(height: 20)
                Text("Mon Dashboard")
                    .font(.title)
                    .fontWeight(.bold)
                    .cornerRadius(10)
                
                Spacer()
                
                // Liste des zones du festival
                NavigationLink(destination: ListeZonesFestivalView(festival: viewModel.festival)) {
                    Text("Zones du festival")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.adaptiveBlue(colorScheme: colorScheme))
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                
                // Liste des bénévoles du festival
                NavigationLink(destination: ListeBenevolesFestivalView(festival: viewModel.festival)) {
                    Text("Bénévoles du festival")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.adaptiveBlue(colorScheme: colorScheme))
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                
                // Revenir à la liste des festivals
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Liste des festivals")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
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
            .background(Color.adaptiveBackground(colorScheme: colorScheme))
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct AdminDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        AdminDashboardView(
            festival: FestivalModel(
                nom: "Festival1",
                dateDebut: "02/04/2023",
                dateFin: "03/04/2023",
                heureDebut: "08:00",
                heureFin: "21:00",
                zones: [
                    Zone(
                        id: 1,
                        festival: -1,
                        nom: "Zone1",
                        nbBenevolesMin: 3),
                    Zone(
                        id: 2,
                        festival: -1,
                        nom: "Zone2",
                        nbBenevolesMin: 3),
                    Zone(
                        id: 3,
                        festival: -1,
                        nom: "Zone3",
                        nbBenevolesMin: 3),
                    Zone(
                        id: 4,
                        festival: -1,
                        nom: "Zone4",
                        nbBenevolesMin: 3)
                ]
            )
        )
    }
}
