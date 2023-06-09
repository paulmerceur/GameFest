//
//  ModifierDisponibilitesViewModel.swift
//  GameFest
//
//  Created by Paul Merceur on 26/03/2023.
//

import Foundation

class ModifierDisponibilitesViewModel: ObservableObject {
    @Published var affectationsVM: AffectationListViewModel
    
    init(affectations: AffectationListViewModel) {
        self.affectationsVM = affectations
    }
}
