//
//  Model.swift
//  Relayance
//
//  Created by Amandine Cousin on 10/07/2024.
//

import Foundation

struct Client: Codable, Hashable {
    var nom: String
    var email: String
    private var dateCreationString: String
    var dateCreation: Date {
        Date.dateFromString(dateCreationString) ?? Date.now

    }
    
    enum CodingKeys: String, CodingKey {
        case nom
        case email
        case dateCreationString = "date_creation"
    }
    
    /// Constructeur
    init(nom: String, email: String, dateCreationString: String) {
        self.nom = nom
        self.email = email
        self.dateCreationString = dateCreationString
    }
    
    /// Fonctions
    static func creerNouveauClient(nom: String, email: String) -> Client {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return Client(nom: nom, email: email, dateCreationString: dateFormatter.string(from: Date.now))
    }
    
    func estNouveauClient() -> Bool {
        let aujourdhui = Date.now
        let dateCreation = self.dateCreation
        
        if aujourdhui.getYear() != dateCreation.getYear() ||
            aujourdhui.getMonth() != dateCreation.getMonth() ||
            aujourdhui.getDay() != dateCreation.getDay() {
            return false
        }
        return true
    }
    
    func clientExiste(clientsList: [Client]) -> Bool {
        // Vérifier si un client avec le même email existe déjà dans la liste
        return clientsList.contains { $0.email.lowercased() == self.email.lowercased() }
    }

    func formatDateVersString() -> String {
        return Date.stringFromDate(self.dateCreation) ?? self.dateCreationString
    }
    
    
}
