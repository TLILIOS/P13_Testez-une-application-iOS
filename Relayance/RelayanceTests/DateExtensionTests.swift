//
//  DateExtensionTests.swift
//  RelayanceTests
//
//  Created by TLiLi Hamdi on 22/05/2025.
//

import XCTest
@testable import Relayance

final class DateExtensionTests: XCTestCase {
    
    // MARK: - Tests pour dateFromString
    
    func testDateFromStringAvecFormatValide() {
        // MARK: - Given
        let dateString = "2023-02-20"
        
        // MARK: - When
        let date = Date.dateFromString(dateString)
        
        // MARK: - Then
        XCTAssertNotNil(date, "La conversion devrait réussir avec un format valide")
        
        // Vérification des composants de la date
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date!)
        
        XCTAssertEqual(components.year, 2023, "L'année devrait être 2023")
        XCTAssertEqual(components.month, 2, "Le mois devrait être 2 (février)")
        XCTAssertEqual(components.day, 20, "Le jour devrait être 20")
    }
    
    func testDateFromStringAvecFormatInvalide() {
        // MARK: - Given
        let dateString = "date_invalide"
        
        // MARK: - When
        let date = Date.dateFromString(dateString)
        
        // MARK: - Then
        XCTAssertNil(date, "La conversion devrait échouer avec un format invalide")
    }
    
    func testDateFromStringAvecChaineVide() {
        // MARK: - Given
        let dateString = ""
        
        // MARK: - When
        let date = Date.dateFromString(dateString)
        
        // MARK: - Then
        XCTAssertNil(date, "La conversion devrait échouer avec une chaîne vide")
    }
    
    // MARK: - Tests pour stringFromDate
    
    func testStringFromDateAvecDateValide() {
        // MARK: - Given
        // Création d'une date fixe pour le test (20 février 2023)
        var dateComponents = DateComponents()
        dateComponents.year = 2023
        dateComponents.month = 2
        dateComponents.day = 20
        let date = Calendar.current.date(from: dateComponents)!
        
        // MARK: - When
        let dateString = Date.stringFromDate(date)
        
        // MARK: - Then
        XCTAssertNotNil(dateString, "La conversion devrait réussir avec une date valide")
        XCTAssertEqual(dateString, "20-02-2023", "La date devrait être formatée au format 'dd-MM-yyyy'")
    }
    
    func testStringFromDateAvecDateLimite() {
        // MARK: - Given
        // Création d'une date limite (1er janvier 1970)
        var dateComponents = DateComponents()
        dateComponents.year = 1970
        dateComponents.month = 1
        dateComponents.day = 1
        let date = Calendar.current.date(from: dateComponents)!
        
        // MARK: - When
        let dateString = Date.stringFromDate(date)
        
        // MARK: - Then
        XCTAssertNotNil(dateString, "La conversion devrait réussir même avec une date limite")
        XCTAssertEqual(dateString, "01-01-1970", "La date devrait être formatée correctement même pour une date limite")
    }
    
    // MARK: - Tests pour getDay
    
    func testGetDayAvecJourValide() {
        // MARK: - Given
        var dateComponents = DateComponents()
        dateComponents.year = 2023
        dateComponents.month = 2
        dateComponents.day = 20
        let date = Calendar.current.date(from: dateComponents)!
        
        // MARK: - When
        let jour = date.getDay()
        
        // MARK: - Then
        XCTAssertEqual(jour, 20, "La méthode getDay() devrait retourner 20")
    }
    
    func testGetDayAvecDernierJourDuMois() {
        // MARK: - Given
        var dateComponents = DateComponents()
        dateComponents.year = 2023
        dateComponents.month = 2
        dateComponents.day = 28 // Dernier jour de février 2023
        let date = Calendar.current.date(from: dateComponents)!
        
        // MARK: - When
        let jour = date.getDay()
        
        // MARK: - Then
        XCTAssertEqual(jour, 28, "La méthode getDay() devrait retourner 28 pour le dernier jour de février 2023")
    }
    
    // MARK: - Tests pour getMonth
    
    func testGetMonthAvecMoisValide() {
        // MARK: - Given
        var dateComponents = DateComponents()
        dateComponents.year = 2023
        dateComponents.month = 7
        dateComponents.day = 15
        let date = Calendar.current.date(from: dateComponents)!
        
        // MARK: - When
        let mois = date.getMonth()
        
        // MARK: - Then
        XCTAssertEqual(mois, 7, "La méthode getMonth() devrait retourner 7 (juillet)")
    }
    
    func testGetMonthAvecPremierMois() {
        // MARK: - Given
        var dateComponents = DateComponents()
        dateComponents.year = 2023
        dateComponents.month = 1
        dateComponents.day = 15
        let date = Calendar.current.date(from: dateComponents)!
        
        // MARK: - When
        let mois = date.getMonth()
        
        // MARK: - Then
        XCTAssertEqual(mois, 1, "La méthode getMonth() devrait retourner 1 (janvier)")
    }
    
    // MARK: - Tests pour getYear
    
    func testGetYearAvecAnneeValide() {
        // MARK: - Given
        var dateComponents = DateComponents()
        dateComponents.year = 2023
        dateComponents.month = 7
        dateComponents.day = 15
        let date = Calendar.current.date(from: dateComponents)!
        
        // MARK: - When
        let annee = date.getYear()
        
        // MARK: - Then
        XCTAssertEqual(annee, 2023, "La méthode getYear() devrait retourner 2023")
    }
    
    func testGetYearAvecAnneeBissextile() {
        // MARK: - Given
        var dateComponents = DateComponents()
        dateComponents.year = 2024 // Année bissextile
        dateComponents.month = 2
        dateComponents.day = 29
        let date = Calendar.current.date(from: dateComponents)!
        
        // MARK: - When
        let annee = date.getYear()
        
        // MARK: - Then
        XCTAssertEqual(annee, 2024, "La méthode getYear() devrait retourner 2024")
    }
}
