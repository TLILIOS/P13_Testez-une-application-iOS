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
            // Vérification que la date de création est une date valide
            let mirror = Mirror(reflecting: client)
            if let dateCreationString = mirror.children.first(where: { $0.label == "dateCreationString" })?.value as? String {
                XCTAssertFalse(dateCreationString.isEmpty, "La date de création ne devrait pas être vide")
            }
        }
    }
    
    // Note: Le test suivant échouerait en temps normal car la fonction `chargement` appelle `fatalError`
    // si le fichier n'existe pas. Pour tester correctement ce cas, il faudrait refactoriser la fonction
    // pour qu'elle lance une erreur normale au lieu de `fatalError`. Nous allons donc écrire ce test
    // comme documentation de ce comportement.
    
}
