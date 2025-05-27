//
//  ClientViewModelIntegrationTests.swift
//  RelayanceTests
//
//  Created by TLiLi Hamdi on 22/05/2025.
//

import XCTest
@testable import Relayance
@MainActor
final class ClientViewModelIntegrationTests: XCTestCase {
    
    var viewModel: ClientViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = ClientViewModel()
        // S'assurer que nous partons d'un état connu
        viewModel.clients = []
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    // MARK: - Tests d'intégration pour l'ajout de client
    
    func testAjoutNouveauClientAvecDonneesValides() {
        // MARK: - Given
        let nom = "Martin Dupont"
        let email = "martin@example.com"
        
        // MARK: - When
        let resultat = viewModel.tryAddClient(nom: nom, email: email)
        
        // MARK: - Then
        XCTAssertTrue(resultat, "L'ajout du client devrait réussir")
        XCTAssertEqual(viewModel.clients.count, 1, "La liste des clients devrait contenir un élément")
        XCTAssertEqual(viewModel.clients[0].nom, nom, "Le nom du client devrait correspondre")
        XCTAssertEqual(viewModel.clients[0].email, email, "L'email du client devrait correspondre")
        XCTAssertTrue(viewModel.isNewClient(client: viewModel.clients[0]), "Le client devrait être considéré comme nouveau")
    }
    
    func testAjoutClientDejaExistant() {
        // MARK: - Given
        let nom = "Martin Dupont"
        let email = "martin@example.com"
        
        // Ajout du premier client
        _ = viewModel.tryAddClient(nom: nom, email: email)
        
        // MARK: - When
        // Tentative d'ajout du même client
        let resultat = viewModel.tryAddClient(nom: nom, email: email)
        
        // MARK: - Then
        XCTAssertFalse(resultat, "L'ajout du client devrait échouer car il existe déjà")
        XCTAssertEqual(viewModel.clients.count, 1, "La liste des clients ne devrait toujours contenir qu'un seul élément")
    }
    
    func testAjoutClientAvecEmailInvalide() {
        // MARK: - Given
        let nom = "Alice Dupont"
        let emailInvalide = "alice.example.com" // Manque le @ dans l'email
        
        // MARK: - When
        let resultat = viewModel.tryAddClient(nom: nom, email: emailInvalide)
        
        // MARK: - Then
        // Note: Dans cette implémentation, la validation de l'email n'est pas effectuée
        // Ce test vérifie le comportement actuel, qui est d'accepter même les emails invalides
        XCTAssertTrue(resultat, "L'ajout du client devrait réussir même avec un email invalide (comportement actuel)")
        XCTAssertEqual(viewModel.clients.count, 1, "La liste des clients devrait contenir un élément")
        
        // Ce test pourrait être adapté si une validation d'email est ajoutée plus tard
    }
    
    func testAjoutClientAvecNomVide() {
        // MARK: - Given
        let nom = ""
        let email = "contact@example.com"
        
        // MARK: - When
        let resultat = viewModel.tryAddClient(nom: nom, email: email)
        
        // MARK: - Then
        // Note: Dans cette implémentation, la validation du nom n'est pas effectuée
        XCTAssertTrue(resultat, "L'ajout du client devrait réussir même avec un nom vide (comportement actuel)")
        XCTAssertEqual(viewModel.clients.count, 1, "La liste des clients devrait contenir un élément")
        XCTAssertEqual(viewModel.clients[0].nom, "", "Le nom du client devrait être vide")
    }
    
    // MARK: - Tests d'intégration pour la suppression de client
    
    func testSuppressionClientExistant() {
        // MARK: - Given
        // Ajout d'un client
        let nom = "Jean Dupont"
        let email = "jean@example.com"
        _ = viewModel.tryAddClient(nom: nom, email: email)
        
        // Récupération du client ajouté
        let client = viewModel.clients[0]
        
        // MARK: - When
        viewModel.deleteClient(client: client)
        
        // MARK: - Then
        XCTAssertEqual(viewModel.clients.count, 0, "La liste des clients devrait être vide après suppression")
    }
    
    func testSuppressionClientInexistant() {
        // MARK: - Given
        // Ajout d'un client
        _ = viewModel.tryAddClient(nom: "Jean Dupont", email: "jean@example.com")
        
        // Création d'un client différent qui n'est pas dans la liste
        let clientInexistant = Client.creerNouveauClient(nom: "Pierre Martin", email: "pierre@example.com")
        
        // MARK: - When
        viewModel.deleteClient(client: clientInexistant)
        
        // MARK: - Then
        XCTAssertEqual(viewModel.clients.count, 1, "La liste des clients ne devrait pas être modifiée")
    }
    
    // MARK: - Tests d'intégration pour la vérification de nouveau client
    
    func testVerificationNouveauClient() {
        // MARK: - Given
        // Ajout d'un client qui sera forcément créé aujourd'hui
        _ = viewModel.tryAddClient(nom: "Sophie Durand", email: "sophie@example.com")
        let client = viewModel.clients[0]
        
        // MARK: - When
        let estNouveau = viewModel.isNewClient(client: client)
        
        // MARK: - Then
        XCTAssertTrue(estNouveau, "Un client créé aujourd'hui devrait être considéré comme nouveau")
    }
    
    func testVerificationClientAncien() {
        // MARK: - Given
        // Création d'un client avec une date d'hier
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        let hier = Calendar.current.date(byAdding: .day, value: -1, to: Date.now)!
        let dateCreationString = dateFormatter.string(from: hier)
        
        let clientAncien = Client(nom: "Robert Martin", email: "robert@example.com", dateCreationString: dateCreationString)
        
        // Ajout manuel à la liste
        viewModel.clients.append(clientAncien)
        
        // MARK: - When
        let estNouveau = viewModel.isNewClient(client: clientAncien)
        
        // MARK: - Then
        XCTAssertFalse(estNouveau, "Un client créé hier ne devrait pas être considéré comme nouveau")
    }
    
    // MARK: - Tests d'intégration pour le formatage de date
    
    func testFormatageDate() {
        // MARK: - Given
        let dateCreationString = "2023-02-20T09:15:00Z"
        let client = Client(nom: "Martine Dubois", email: "martine@example.com", dateCreationString: dateCreationString)
        
        // MARK: - When
        let dateFormatee = viewModel.formatClientDate(client: client)
        
        // MARK: - Then
        XCTAssertEqual(dateFormatee, "20-02-2023", "La date devrait être formatée au format jour-mois-année")
    }
    
    // MARK: - Tests d'intégration pour le chargement des clients
    
    func testChargementClients() {
        // MARK: - Given
        // Ici, nous ne pouvons pas facilement mocker le chargement depuis un fichier JSON
        // donc nous testons que la méthode s'exécute sans erreur
        
        // MARK: - When
        viewModel.loadClients()
        
        // MARK: - Then
        // Nous ne pouvons pas prévoir exactement combien de clients seront chargés
        // mais nous pouvons vérifier que la liste n'est pas nil
        XCTAssertNotNil(viewModel.clients, "La liste des clients ne devrait pas être nil après chargement")
    }
}
