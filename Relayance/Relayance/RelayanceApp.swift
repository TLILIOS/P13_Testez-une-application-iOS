//
//  RelayanceApp.swift
//  Relayance
//
//  Created by Amandine Cousin on 08/07/2024.
//

import SwiftUI

@main
struct RelayanceApp: App {
    // Initialisation du ViewModel comme StateObject pour qu'il persiste pendant toute la durée de vie de l'application
    @StateObject private var clientViewModel = ClientViewModel()
    
    var body: some Scene {
        WindowGroup {
            // Injection du ViewModel dans la vue principale
            ListClientsView(viewModel: clientViewModel)
        }
    }
}
