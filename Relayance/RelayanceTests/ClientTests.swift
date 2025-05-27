//
//  ClientTests.swift
//  RelayanceTests
//
//  Created by TLiLi Hamdi on 20/05/2025.
//
import XCTest
@testable import Relayance

final class ClientTests: XCTestCase {
    
    // MARK: - Tests pour l'initialisation (init)
    
    func testClientInitialization() {
        // MARK: - Given (Préparation)
        // On définit les données d'entrée pour notre test
        let nom = "Dupont"
        let email = "dupont@example.com"
        let dateCreationString = "2023-02-20T09:15:00Z"
        
        // MARK: - When (Action)
        // On crée une instance de Client avec le constructeur à tester
        let client = Client(nom: nom, email: email, dateCreationString: dateCreationString)
        
        // MARK: - Then (Vérification)
        // 1. Vérification des propriétés publiques
        XCTAssertEqual(client.nom, nom, "Le nom du client devrait être \(nom)")
        XCTAssertEqual(client.email, email, "L'email du client devrait être \(email)")
        
        // 2. Vérification de la propriété privée dateCreationString
        let expectedDate = Date.dateFromString(dateCreationString)
        XCTAssertNotNil(expectedDate, "La date devrait être convertie correctement")
        XCTAssertEqual(client.dateCreation, expectedDate, "La date de création (Date) devrait correspondre à \(dateCreationString)")
        // Coherence du formatage
        let formattedDate = client.formatDateVersString()
        XCTAssertEqual(formattedDate, Date.stringFromDate(client.dateCreation), "Le formatage devrait être cohérent avec la date stockée")
    }
    
    func testClientInitializationWithEmptyValues() {
        // MARK: - Given
        let nom = ""
        let email = ""
        let dateCreationString = "2023-02-20T09:15:00Z"
        
        // MARK: - When
        let client = Client(nom: nom, email: email, dateCreationString: dateCreationString)
        
        // MARK: - Then
        XCTAssertEqual(client.nom, "", "Le nom du client devrait être vide")
        XCTAssertEqual(client.email, "", "L'email du client devrait être vide")
        
        // Vérification de la date
        let expectedDate = Date.dateFromString(dateCreationString)
        XCTAssertEqual(client.dateCreation, expectedDate, "La date de création devrait être correcte même avec des champs vides")
    }
    
    // MARK: - Tests pour creerNouveauClient
    
    func testCreerNouveauClientWithValidData() {
        // MARK: - Given
        let nom = "Martin"
        let email = "martin@example.com"
        
        // MARK: - When
        let client = Client.creerNouveauClient(nom: nom, email: email)
        
        // MARK: - Then
        XCTAssertEqual(client.nom, nom, "Le nom devrait être correctement assigné")
        XCTAssertEqual(client.email, email, "L'email devrait être correctement assigné")
        
        // Si la date est intentionnellement définie à minuit du jour actuel
        let calendar = Calendar.current
        let aujourdhui = calendar.startOfDay(for: Date.now)
        
        XCTAssertEqual(
            calendar.startOfDay(for: client.dateCreation),
            aujourdhui,
            "La date de création devrait être aujourd'hui à minuit"
        )
    }


    
    func testCreerNouveauClientWithEmptyData() {
        // MARK: - Given
        let nom = ""
        let email = ""
        
        // MARK: - When
        let client = Client.creerNouveauClient(nom: nom, email: email)
        
        // MARK: - Then
        XCTAssertEqual(client.nom, "", "Le nom devrait être vide")
        XCTAssertEqual(client.email, "", "L'email devrait être vide")
        
        // Vérification que la date est valide malgré les données vides
        let calendar = Calendar.current
        let maintenant = Date.now
        let composantsMaintenant = calendar.dateComponents([.year, .month, .day], from: maintenant)
        let composantsClient = calendar.dateComponents([.year, .month, .day], from: client.dateCreation)
        
        XCTAssertEqual(composantsClient.year, composantsMaintenant.year, "L'année devrait être celle d'aujourd'hui même avec des données vides")
        XCTAssertEqual(composantsClient.month, composantsMaintenant.month, "Le mois devrait être celui d'aujourd'hui même avec des données vides")
        XCTAssertEqual(composantsClient.day, composantsMaintenant.day, "Le jour devrait être celui d'aujourd'hui même avec des données vides")
    }
    
    // MARK: - Tests pour estNouveauClient
    
    func testEstNouveauClientAvecClientCreeAujourdhui() {
        // MARK: - Given
        // Création d'un client avec la date d'aujourd'hui
        let client = Client.creerNouveauClient(nom: "Petit", email: "petit@example.com")
        
        // MARK: - When
        let estNouveau = client.estNouveauClient()
        
        // MARK: - Then
        XCTAssertTrue(estNouveau, "Un client créé aujourd'hui devrait être considéré comme nouveau")
    }
    
    func testEstNouveauClientAvecClientCreeHier() {
        // MARK: - Given
        // Création d'un client avec une date d'hier
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        let hier = Calendar.current.date(byAdding: .day, value: -1, to: Date.now)!
        let dateCreationString = dateFormatter.string(from: hier)
        
        let client = Client(nom: "Ancien", email: "ancien@example.com", dateCreationString: dateCreationString)
        
        // MARK: - When
        let estNouveau = client.estNouveauClient()
        
        // MARK: - Then
        XCTAssertFalse(estNouveau, "Un client créé hier ne devrait pas être considéré comme nouveau")
    }
    
    // MARK: - Tests pour clientExiste
    
    func testClientExisteQuandClientEstDansLaListe() {
        // MARK: - Given
        let client1 = Client(nom: "Dupont", email: "dupont@example.com", dateCreationString: "2023-02-20T09:15:00Z")
        let client2 = Client(nom: "Martin", email: "martin@example.com", dateCreationString: "2023-03-15T14:30:00Z")
        let client3 = Client(nom: "Dupont", email: "dupont@example.com", dateCreationString: "2023-02-20T09:15:00Z") // Mêmes valeurs que client1
        
        let clientsList = [client1, client2]
        
        // MARK: - When
        let existe = client3.clientExiste(clientsList: clientsList)
        
        // MARK: - Then
        XCTAssertTrue(existe, "Le client devrait être considéré comme existant dans la liste")
    }
    
    func testClientExisteQuandClientNEstPasDansLaListe() {
        // MARK: - Given
        let client1 = Client(nom: "Dupont", email: "dupont@example.com", dateCreationString: "2023-02-20T09:15:00Z")
        let client2 = Client(nom: "Martin", email: "martin@example.com", dateCreationString: "2023-03-15T14:30:00Z")
        let client3 = Client(nom: "Petit", email: "petit@example.com", dateCreationString: "2023-04-10T11:00:00Z") // Différent des autres clients
        
        let clientsList = [client1, client2]
        
        // MARK: - When
        let existe = client3.clientExiste(clientsList: clientsList)
        
        // MARK: - Then
        XCTAssertFalse(existe, "Le client ne devrait pas être considéré comme existant dans la liste")
    }
    
    func testClientExisteAvecListeVide() {
        // MARK: - Given
        let client = Client(nom: "Dupont", email: "dupont@example.com", dateCreationString: "2023-02-20T09:15:00Z")
        let clientsList: [Client] = []
        
        // MARK: - When
        let existe = client.clientExiste(clientsList: clientsList)
        
        // MARK: - Then
        XCTAssertFalse(existe, "Le client ne devrait pas être considéré comme existant dans une liste vide")
    }
    
    // MARK: - Tests pour formatDateVersString
    
    func testFormatDateVersStringAvecDateValide() {
        // MARK: - Given
        let dateCreationString = "2023-02-20T09:15:00Z"
        let client = Client(nom: "Dupont", email: "dupont@example.com", dateCreationString: dateCreationString)
        
        // MARK: - When
        let dateFormatee = client.formatDateVersString()
        
        // MARK: - Then
        // La date 2023-02-20T09:15:00Z devrait être formatée en "20-02-2023" (jour-mois-année)
        XCTAssertEqual(dateFormatee, "20-02-2023", "La date devrait être formatée au format jour-mois-année")
    }
    
    func testFormatDateVersStringAvecDateInvalide() {
        // MARK: - Given
        let dateCreationString = "date_invalide"
        let client = Client(nom: "Dupont", email: "dupont@example.com", dateCreationString: dateCreationString)
        
        // MARK: - When
        let dateFormatee = client.formatDateVersString()
        
        // MARK: - Then
        // Note: Lorsque dateCreationString est invalide, dateCreation retourne Date.now comme valeur par défaut,
        // qui est ensuite formatée au format "dd-MM-yyyy" par stringFromDate
        
        // Vérifier que la date formatée est une date valide au format "dd-MM-yyyy"
        let dateRegex = #"\d{2}-\d{2}-\d{4}"#
        let regexMatch = (dateFormatee.range(of: dateRegex, options: .regularExpression) != nil)
        XCTAssertTrue(regexMatch, "Pour une date invalide, la méthode devrait retourner une date formatée basée sur Date.now")
        
        // Vérifier que la date formatée correspond à la date d'aujourd'hui
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let expectedDateString = dateFormatter.string(from: Date.now)
        XCTAssertEqual(dateFormatee, expectedDateString, "La date formatée devrait correspondre à la date d'aujourd'hui")
    }
}
