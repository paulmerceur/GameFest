//
//  AffectationListViewModel.swift
//  GameFest
//
//  Created by Paul Merceur on 24/03/2023.
//

import Foundation


class AffectationListViewModel : ObservableObject, AffectationVMObserver {
    @Published var affectations : [AffectationViewModel] = []
    
    init(affectations: [AffectationViewModel]) {
        for affectation in affectations {
            self.affectations.append(affectation)
            affectation.register(self)
        }
    }
    init() {
        self.affectations = []
    }
    
    func update(zone: Zone, at index: Int) {
        self.affectations[index].zone = zone
        self.objectWillChange.send()
    }
    
    func update(isDispo: Bool, at index: Int) {
        self.affectations[index].isDispo = isDispo
        self.objectWillChange.send()
    }
    
    func vmupdated()  { self.objectWillChange.send() }
}
