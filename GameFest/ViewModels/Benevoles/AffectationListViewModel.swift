//
//  AffectationListViewModel.swift
//  GameFest
//
//  Created by Paul Merceur on 24/03/2023.
//

import Foundation


class AffectationListViewModel : ObservableObject, AffectationVMObserver {
    @Published var affectations : [AffectationViewModel] = []
    
    init(affectations: [AffectationModel]) {
        for affectation in affectations {
            let affectationVM = AffectationViewModel(model: affectation)
            self.affectations.append(affectationVM)
            affectationVM.register(self)
        }
    }
    
    func update(zone: String, at index: Int) {
        self.affectations[index].zone = zone
        self.objectWillChange.send()
    }
    
    func vmupdated()  { self.objectWillChange.send() }
}
