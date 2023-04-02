//
//  AdminDashboardView.swift
//  GameFest
//
//  Created by Paul Merceur on 01/04/2023.
//

import Foundation

class AdminDashboardViewModel: ObservableObject {
    @Published var isLoggedOut: Bool = false
    public var festival: FestivalModel
    
    init(festival: FestivalModel) {
        self.festival = festival
    }
    
    func logout() {
        AuthRequests.logout()
        self.isLoggedOut = true
    }
    
}
