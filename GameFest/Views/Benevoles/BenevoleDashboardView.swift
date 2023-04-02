//
//  HomeView.swift
//  GameFest
//
//  Created by Paul Merceur on 17/03/2023.
//

import Foundation
import SwiftUI

struct BenevoleDashboardView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    
    @StateObject private var viewModel: BenevoleDashboardViewModel
    
    init(benevole: BenevoleModel, festival: FestivalModel) {
        self._viewModel = StateObject(wrappedValue: BenevoleDashboardViewModel(benevole: benevole, festival: festival))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer().frame(height: 20)
                Text("Mon Dashboard")
                    .font(.title)
                    .fontWeight(.bold)
                    .cornerRadius(10)
                
                Text(viewModel.benevole.prenom + " " + viewModel.benevole.nom)
                    .font(.title2)
                    .fontWeight(.bold)
                    .cornerRadius(10)
                
                List {
                    ForEach(viewModel.affectationsVM.affectations, id: \.id) { affectation in
                        if affectation.isDispo {
                            NavigationLink(destination: ModifierAffectationView(affectation: affectation, festival: viewModel.festival)) {
                                VStack(alignment: .leading) {
                                    if affectation.zone.nom.isEmpty {
                                        Text("Pas affecté")
                                            .font(.headline)
                                            .foregroundColor(.red)
                                    } else {
                                        Text(affectation.zone.nom)
                                            .font(.headline)
                                    }
                                    HStack {
                                        Text(affectation.creneau.date)
                                            .font(.subheadline)
                                        Spacer()
                                        Text(affectation.creneau.horaires)
                                            .font(.subheadline)
                                    }
                                }
                            }
                        } else { // Pas disponible
                            VStack(alignment: .leading) {
                                Text(" ").font(.headline)
                                
                                HStack {
                                    Text(affectation.creneau.date)
                                        .font(.subheadline)
                                    Spacer()
                                    Text(affectation.creneau.horaires)
                                        .font(.subheadline)
                                }
                            }.opacity(0.5)
                        }
                    }
                }
                .onAppear{self.viewModel.objectWillChange.send()}
                NavigationLink(destination: ModifierDisponibilitesView(affectations: viewModel.affectationsVM)) {
                    Text("Modifier mes disponibilités")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
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


//struct BenevoleDashboardView_Previews: PreviewProvider {
//    static var previews: some View {
//        BenevoleDashboardView(benevole: BenevoleModel(prenom: "Paco", nom: "Gangsta", email: "paco@gangsta.money", isAdmin: false, affectations: [
//            AffectationModel(zone: "Zone 1", date: "2023-03-20", creneau: "10:00 - 12:00", isDispo: true),
//            AffectationModel(zone: "Zone 2", date: "2023-03-21", creneau: "10:00 - 12:00", isDispo: false),
//            AffectationModel(zone: "Zone 3", date: "2023-03-19", creneau: "10:00 - 12:00", isDispo: true),
//            AffectationModel(zone: "Zone 2", date: "2023-03-20", creneau: "12:00 - 14:00", isDispo: true),
//            AffectationModel(zone: "Zone 1", date: "2023-03-21", creneau: "12:00 - 14:00", isDispo: false),
//            AffectationModel(zone: "Zone 4", date: "2023-03-19", creneau: "12:00 - 14:00", isDispo: true),
//            AffectationModel(zone: "Zone 4", date: "2023-03-22", creneau: "10:00 - 12:00", isDispo: true),
//            AffectationModel(zone: "Zone 3", date: "2023-03-20", creneau: "14:00 - 16:00", isDispo: true),
//            AffectationModel(zone: "Zone 1", date: "2023-03-20", creneau: "16:00 - 18:00", isDispo: true),
//        ]))
//    }
//}
