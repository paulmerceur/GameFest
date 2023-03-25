//
//  HomeView.swift
//  GameFest
//
//  Created by Paul Merceur on 17/03/2023.
//

import Foundation
import SwiftUI

struct BenevoleDashboardView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @StateObject private var viewModel: BenevoleDashboardViewModel
    
    @State private var isLoggedOut = false
    
    init(benevole: BenevoleModel) {
        self._viewModel = StateObject(wrappedValue: BenevoleDashboardViewModel(benevole: benevole))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text(viewModel.benevole.prenom + " " + viewModel.benevole.nom)
                    .font(.title)
                    .fontWeight(.bold)
                    .cornerRadius(10)
                
                Text("Mes affectations")
                    .font(.title2)
                    .fontWeight(.bold)
                    .cornerRadius(10)
                
                List {
                    ForEach(viewModel.affectationsVM.affectations, id: \.id) { affectation in
                        NavigationLink(destination: ModifierAffectationView(affectation: affectation)) {
                            VStack(alignment: .leading) {
                                if affectation.zone.isEmpty {
                                    Text("Pas affecté")
                                        .font(.headline)
                                        .foregroundColor(.red)
                                } else {
                                    Text(affectation.zone)
                                        .font(.headline)
                                }
                                HStack {
                                    Text(affectation.date)
                                        .font(.subheadline)
                                    Spacer()
                                    Text(affectation.creneau)
                                        .font(.subheadline)
                                }
                            }
                        }
                    }
                }.onAppear{self.viewModel.objectWillChange.send()}
                NavigationLink(destination: ModifierDisponibilitesView()) {
                    Text("Modifier mes disponibilités")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
                
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
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}


struct BenevoleDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        BenevoleDashboardView(benevole: BenevoleModel(prenom: "Paco", nom: "Gangsta", email: "paco@gangsta.money", affectations: [
            AffectationModel(zone: "Zone 1", date: "2023-03-20", creneau: "10:00 - 12:00", isDispo: true),
            AffectationModel(zone: "Zone 2", date: "2023-03-21", creneau: "10:00 - 12:00", isDispo: false),
            AffectationModel(zone: "Zone 3", date: "2023-03-19", creneau: "10:00 - 12:00", isDispo: true),
            AffectationModel(zone: "Zone 2", date: "2023-03-20", creneau: "12:00 - 14:00", isDispo: true),
            AffectationModel(zone: "Zone 1", date: "2023-03-21", creneau: "12:00 - 14:00", isDispo: false),
            AffectationModel(zone: "Zone 4", date: "2023-03-19", creneau: "12:00 - 14:00", isDispo: true),
            AffectationModel(zone: "Zone 4", date: "2023-03-22", creneau: "10:00 - 12:00", isDispo: true),
            AffectationModel(zone: "Zone 3", date: "2023-03-20", creneau: "14:00 - 16:00", isDispo: true),
            AffectationModel(zone: "Zone 1", date: "2023-03-20", creneau: "16:00 - 18:00", isDispo: true),
        ]))
    }
}
