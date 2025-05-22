//
//  ListClientsView.swift
//  Relayance
//
//  Created by Amandine Cousin on 10/07/2024.
//

import SwiftUI

struct ListClientsView: View {
    // Utilisation du viewModel avec @ObservedObject pour observer les changements
    @ObservedObject var viewModel: ClientViewModel
    @State private var showModal: Bool = false
    
    var body: some View {
        NavigationStack {
            List(viewModel.clients, id: \.self) { client in
                NavigationLink {
                    DetailClientView(viewModel: viewModel, client: client)
                } label: {
                    Text(client.nom)
                        .font(.title3)
                }
            }
            .navigationTitle("Liste des clients")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Ajouter un client") {
                        showModal.toggle()
                    }
                    .foregroundStyle(.orange)
                    .bold()
                }
            }
            .sheet(isPresented: $showModal, content: {
                AjoutClientView(viewModel: viewModel, dismissModal: $showModal)
            })
        }
    }
}

#Preview {
    ListClientsView(viewModel: ClientViewModel())
}
