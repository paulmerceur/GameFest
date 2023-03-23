//
//  AssignmentListView.swift
//  GameFest
//
//  Created by Paul Merceur on 23/03/2023.
//

import Foundation
import SwiftUI

struct Assignment: Identifiable {
    var id = UUID()
    var zone: String
    var date: String
    var time: String
}

struct AssignmentListView: View {
    let assignments: [Assignment]
    
    var body: some View {
        List(assignments) { assignment in
            VStack(alignment: .leading) {
                Text(assignment.zone)
                    .font(.headline)
                HStack {
                    Text(assignment.date)
                        .font(.subheadline)
                    Spacer()
                    Text(assignment.time)
                        .font(.subheadline)
                }
            }
        }
        Button(action: {
                        // Action pour modifier les disponibilités
        }) {
                Text("Modifier mes disponibilités")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
    }
}
