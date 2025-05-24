//
//  ModelDataTests.swift
//  RelayanceTests
//
//  Created by TLiLi Hamdi on 20/05/2025.
//


import XCTest
@testable import Relayance

final class ModelDataTests: XCTestCase {
    
    // MARK: - Tests pour la fonction chargement
    
    func testChargementAvecFichierValide() {
        // Note: Ce test suppose qu'il existe un fichier 'Source.json' dans le bundle
        // qui contient une liste de clients valide.
        
        // MARK: - Given
        // Aucune préparation
        
        // MARK: - When
        let clients: [Client] = ModelData.chargement("Source.json")
        
        // MARK: - Then
        XCTAssertFalse(clients.isEmpty, "Le chargement devrait retourner au moins un client")
        
        // Vérification que chaque client a des propriétés valides
        for client in clients {
                    XCTAssertFalse(client.nom.isEmpty, "Le nom du client ne devrait pas être vide")
                    XCTAssertFalse(client.email.isEmpty, "L'email du client ne devrait pas être vide")
                    
                    // Solution 1: Propriété publique ou computed property
                    XCTAssertNotNil(client.dateCreation, "La date de création ne devrait pas être nulle")
                    // ou si c'est une String:
                    // XCTAssertFalse(client.dateCreationString.isEmpty, "La date de création ne devrait pas être vide")
                }
    }
    
    
}
