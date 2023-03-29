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
                    NavigationLink(destination: AdminDashboardView()) {
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
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
        .background(Color.adaptiveBackground(colorScheme: colorScheme))
    }
    
    struct ListeFestivalsView_Previews: PreviewProvider {
        static var previews: some View {
            ListeFestivalsView(benevole: BenevoleModel(prenom: "Paul", nom: "Merceur", email: "", isAdmin: false, affectations: [
                AffectationViewModel(model: AffectationModel(zone: "Zone 1", creneau: Creneau(date: "2023-03-20", horaires: "10:00 - 12:00"), isDispo: true)),
                AffectationViewModel(model: AffectationModel(zone: "Zone 2", creneau: Creneau(date: "2023-03-21", horaires: "10:00 - 12:00"), isDispo: false)),
                AffectationViewModel(model: AffectationModel(zone: "Zone 3", creneau: Creneau(date: "2023-03-19", horaires: "10:00 - 12:00"), isDispo: true)),
                AffectationViewModel(model: AffectationModel(zone: "Zone 2", creneau: Creneau(date: "2023-03-20", horaires: "12:00 - 14:00"), isDispo: true)),
                AffectationViewModel(model: AffectationModel(zone: "Zone 1", creneau: Creneau(date: "2023-03-21", horaires: "12:00 - 14:00"), isDispo: false)),
                AffectationViewModel(model: AffectationModel(zone: "Zone 4", creneau: Creneau(date: "2023-03-19", horaires: "12:00 - 14:00"), isDispo: true)),
                AffectationViewModel(model: AffectationModel(zone: "Zone 4", creneau: Creneau(date: "2023-03-22", horaires: "10:00 - 12:00"), isDispo: true)),
                AffectationViewModel(model: AffectationModel(zone: "Zone 3", creneau: Creneau(date: "2023-03-20", horaires: "14:00 - 16:00"), isDispo: true)),
                AffectationViewModel(model: AffectationModel(zone: "Zone 1", creneau: Creneau(date: "2023-03-20", horaires: "16:00 - 18:00"), isDispo: true)),
            ]))
        }
    }
}
