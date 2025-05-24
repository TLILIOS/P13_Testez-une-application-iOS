//
//  MainViewModel.swift
//  Relayance
//
//  Created by TLiLi Hamdi on 22/05/2025.
//

import Foundation
import SwiftUI

@MainActor
final class ClientViewModel: ObservableObject {
    // Published property pour la liste des clients, ce qui permettra aux vues de réagir aux changements
    @Published var clients: [Client] = []
    
    init() {
        // Chargement des clients depuis le fichier JSON
        loadClients()
    }
    
    // Chargement des clients
    func loadClients() {
        clients = ModelData.chargement("Source.json")
    }
    
    // Ajouter un nouveau client
    func addClient(nom: String, email: String) -> Bool {
        let newClient = Client.creerNouveauClient(nom: nom, email: email)
        
        // Vérifier si le client existe déjà
        if !newClient.clientExiste(clientsList: clients) {
            clients.append(newClient)
            return true  // Client was added successfully
        }
        return false  // Client already exists
    }

    
    // Supprimer un client
    func deleteClient(client: Client) {
        if let index = clients.firstIndex(where: { $0 == client }) {
            clients.remove(at: index)
        }
    }
    
    // Vérifier si un client est nouveau (créé aujourd'hui)
    func isNewClient(client: Client) -> Bool {
        return client.estNouveauClient()
    }
    
    // Formatter la date du client en chaîne
    func formatClientDate(client: Client) -> String {
        return client.formatDateVersString()
    }
}
