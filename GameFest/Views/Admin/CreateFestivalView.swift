//
//  CreateFestivalView.swift
//  GameFest
//
//  Created by Paul Merceur on 01/04/2023.
//

import Foundation
import SwiftUI

struct CreateFestivalView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel: CreateFestivalViewModel
    
    init(listeFestivals: ListeFestivalsViewModel) {
        self._viewModel = StateObject(wrappedValue: CreateFestivalViewModel(listeFestivals: listeFestivals))
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer().frame(height: 30)
            
            Group {
                Text("Nom")
                    .font(.headline)
                TextField("Nom du festival", text: $viewModel.nom)
                   .font(.body)
                   .padding(.all, 10)
                   .background(Color(UIColor.systemGray6))
                   .cornerRadius(5)
            }
            Spacer().frame(height: 30)
            
            Group {
                Text("Date de début")
                    .font(.headline)
                DatePicker(selection: $viewModel.dateDebut, in: Date()..., displayedComponents: [.date]) {
                    Text("")
                }
                .datePickerStyle(.compact)
                Spacer().frame(height: 30)
                
                Text("Date de fin")
                    .font(.headline)
                DatePicker(selection: $viewModel.dateFin, in: viewModel.dateDebut..., displayedComponents: [.date]) {
                    Text("")
                }
                .datePickerStyle(.compact)
            }
            Spacer().frame(height: 30)
            
            Group {
                Text("Heure de début")
                    .font(.headline)
                DatePicker(selection: $viewModel.heureDebut, displayedComponents: [.hourAndMinute]) {
                    Text("")
                }
                .datePickerStyle(.compact)
                Spacer().frame(height: 30)
                
                Text("Heure de fin")
                    .font(.headline)
                DatePicker(selection: $viewModel.heureFin, displayedComponents: [.hourAndMinute]) {
                    Text("")
                }
                .datePickerStyle(.compact)
            }
            
            Spacer()
            
            Button(action: {
                self.viewModel.createFestival()
                presentationMode.wrappedValue.dismiss()
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
