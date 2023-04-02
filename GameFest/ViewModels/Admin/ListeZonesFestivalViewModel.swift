//
//  ListeZonesFestivalViewModel.swift
//  GameFest
//
//  Created by Paul Merceur on 01/04/2023.
//

import Foundation

class ListeZonesFestivalViewModel: ObservableObject {
    public var festival: FestivalModel
    
    @Published var zones: [Zone] = []
    
    init(festival: FestivalModel) {
        self.festival = festival
        self.zones = festival.zones
    }
}
