//
//  HomeView.swift
//  GameFest
//
//  Created by Paul Merceur on 17/03/2023.
//

import Foundation
import SwiftUI

struct BenevoleDashboardView: View {
    @State private var prenom = "Paco"
    @State private var nom = "Gangsta"
    @State private var assignments: [Assignment] = [
        Assignment(zone: "Zone 1", date: "2023-03-20", time: "10:00 - 12:00"),
        Assignment(zone: "Zone 2", date: "2023-03-21", time: "14:00 - 16:00"),
        Assignment(zone: "Zone 3", date: "2023-03-20", time: "14:00 - 16:00")
    ]
    
    var sortedAssignments: [Assignment] {
            assignments.sorted {
                if $0.date != $1.date {
                    return $0.date < $1.date
                } else {
                    return $0.time < $1.time
                }
            }
        }
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Text(prenom + " " + nom)
                        .font(.title)
                        .fontWeight(.bold)
                        .cornerRadius(10)
                    
                    Text("Mes affectations")
                        .font(.title2)
                        .fontWeight(.bold)
                        .cornerRadius(10)
                }
                
                AssignmentListView(assignments: sortedAssignments)
            }
            .background(Color.gray.opacity(0.1))
        }
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}


struct BenevoleDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        BenevoleDashboardView()
    }
}
