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
    @State private var searchText = ""
    
    var filteredClients: [Client] {
        if searchText.isEmpty {
            return viewModel.clients
        } else {
            return viewModel.clients.filter { client in
                client.nom.lowercased().contains(searchText.lowercased()) ||
                client.email.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.clients.isEmpty {
                    ContentUnavailableView(
                        "Aucun client",
                        systemImage: "person.crop.circle.badge.exclamationmark",
                        description: Text("Ajoutez votre premier client en cliquant sur le bouton 'Ajouter un client'")
                    )
                } else {
                    List {                        
                        ForEach(filteredClients, id: \.self) { client in
                            NavigationLink {
                                DetailClientView(viewModel: viewModel, client: client)
                            } label: {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(client.nom)
                                            .font(.headline)
                                        Text(client.email)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                    
                                    Spacer()
                                    
                                    // Badge pour les nouveaux clients
                                    if viewModel.isNewClient(client: client) {
                                        Text("Nouveau")
                                            .font(.caption)
                                            .padding(.horizontal, 8)
                                            .padding(.vertical, 4)
                                            .background(Color.green)
                                            .foregroundColor(.white)
                                            .cornerRadius(10)
                                    }
                                }
                                .padding(.vertical, 4)
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .searchable(text: $searchText, prompt: "Rechercher un client")
            .navigationTitle("Liste des clients")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showModal.toggle()
                    }) {
                        Label("Ajouter un client", systemImage: "person.badge.plus")
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
